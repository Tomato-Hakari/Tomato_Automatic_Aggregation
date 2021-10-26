//
//  SendDataToServerView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/08/19.
//

import SwiftUI

struct SendDataToServerView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    @State var selectedScaleData: [SelectedScaleData]
    @State var weightsum: Float = 0.0
    
    @State var containers:[Int] = Array(repeating: 1, count:1000)
    
    @State private var result = ""
    
    @State private var isSuccess: Bool = false
    @State private var successed: [Bool] = []
    @State private var erroredIndex: [Int] = []
    @State private var isError: Bool = false
    @State private var ShowingAlert: Bool = false
    
    func OpenPHP(scaleDate: String, yield: String) -> Bool {
        let EncodedScion = Variety.InputVarietyScionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedScionShort = Variety.InputVarietyScionShort.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedRootstock = Variety.InputVarietyRootstockName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedRemarks = Variety.InputVarietyRemarks.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        
        var PHPurl =  "\(DataManagement.GeneratePHPURLHead())/upload.php?varietyID=\(Variety.InputVarietyID)"
        
        if !Variety.InputVarietyScionName.isEmpty {
            PHPurl += "&scion=\(EncodedScion!)"
        }
        if !Variety.InputVarietyScionShort.isEmpty {
            PHPurl += "&scionshort=\(EncodedScionShort!)"
        }
        if !Variety.InputVarietyRootstockName.isEmpty {
            PHPurl += "&rootstock=\(EncodedRootstock!)"
        }
        PHPurl += "&issurvey=\(Variety.isInputVarietysYieldSurvey ? "1" : "0" )"
        if !Variety.InputVarietyRemarks.isEmpty {
            PHPurl += "&remarks=\(EncodedRemarks!)"
        }
        PHPurl += "&measurementdatetime=\(scaleDate)&yield=\(yield)"
        
        print("URL:\(PHPurl)")
        
        guard let url = URL(string: PHPurl) else {
            isError = true
            return false
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                guard let stringdata = String(data: data, encoding: .utf8) else {
                    print("JSON decode error")
                    isError = true
                    return
                }
                DispatchQueue.main.async {
                    result = stringdata
                    print("result:\(result)")
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                isError = true
            }
        }.resume()
        return true
    }
    
    var body: some View {
        VStack {
            GroupBox(label: Text("品種と収量データを確認してください")) {
                List {
                    Section(header: Text("品種")){
                        Text("ID:\(Variety.InputVarietyID)")
                        Text("穂木品種名:\(Variety.InputVarietyScionName)")
                        Text("穂木品種略称:\(Variety.InputVarietyScionShort)")
                        Text("台木品種名:\(Variety.InputVarietyRootstockName)")
                        Text("収量調査:" + String(Variety.isInputVarietysYieldSurvey))
                        Text("備考:\(Variety.InputVarietyRemarks)")
                    }
                    Section(header: Text("収量")) {
                        HStack{
                            Text("重量合計:\(String(format: "%.2f", weightsum))")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Spacer()
                            Text("※コンテナの重量を差し引いた値")
                        }
                        .padding()
                        .background(Color.green)
                        ForEach(0..<selectedScaleData.count) { num in
                            Section(header: HStack{
                                Text("\(num+1)個目")
                                    .fontWeight(.bold)
                                Spacer()
                                Stepper(value: $containers[num], in: 0...10) {
                                    Text("コンテナの数: \(containers[num])")
                                }
                            }) {
                                Text("測定日時:\(selectedScaleData[num].date)")
                                HStack{
                                    Text("重量[kg]:\(DataManagement.CalculateYield(weightString:selectedScaleData[num].weight , containers: Float(containers[num])))")
                                    Spacer()
                                    Text("※コンテナの重量を差し引いた値")
                                }
                                Divider()
                            }
                            .onChange(of: containers[num]) { _ in
                                weightsum = 0.0
                                for i in 0..<selectedScaleData.count {
                                    weightsum += Float(DataManagement.CalculateYield(weightString:selectedScaleData[i].weight , containers: Float(containers[i])))!
                                }
                                weightsum = round(weightsum * 100) / 100
                            }
                        }
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .padding()
        .alert(isPresented: $ShowingAlert) {
            Alert(title: Text("データ送信失敗"), message: Text("\(erroredIndex.count)個のデータ送信に失敗しました"), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("入力データ確認")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    for num in 0..<selectedScaleData.count {
                        successed[num] = OpenPHP(scaleDate: selectedScaleData[num].date, yield: DataManagement.CalculateYield(weightString:selectedScaleData[num].weight , containers: Float(containers[num])))
                        print(successed[num])
                    }
                    erroredIndex = DataManagement.FalseInArray(array: successed)
                    if erroredIndex.isEmpty {
                        isSuccess = true
                    }
                    print("isSuccess:\(String(isSuccess))")
                    if isSuccess {
                        isPresented = false
                    } else {
                        ShowingAlert = true
                    }
                }) {
                    Text("データ送信")
                }
                
            }
        }
        .onAppear {
            weightsum = 0.0
            for i in 0..<selectedScaleData.count {
                weightsum += Float(DataManagement.CalculateYield(weightString:selectedScaleData[i].weight , containers: Float(containers[i])))! * 100
            }
            weightsum /= 100
            successed = Array(repeating: false, count: selectedScaleData.count)
        }
        .onDisappear {
            if isSuccess {
                flag.isSuccessed = true
            }
        }
        
    }
}
