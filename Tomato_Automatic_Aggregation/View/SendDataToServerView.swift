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
    
    @State var selectedScaleDate:String
    @State var selectedScaleWeight:String
    
    @State private var result = ""
    
    @State private var isSuccess: Bool = false
    @State private var isError: Bool = false
    
    func OpenPHP() -> Bool {
        let EncodedScion = Variety.InputVarietyScionName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedScionShort = Variety.InputVarietyScionShort.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedRootstock = Variety.InputVarietyRootstockName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let EncodedRemarks = Variety.InputVarietyRemarks.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        
        var PHPurl =  "http://www.cyanpuma31.sakura.ne.jp/accessDB/upload.php?varietyID=\(Variety.InputVarietyID)"
        
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
        PHPurl += "&measurementdatetime=\(selectedScaleDate)&yield=\(selectedScaleWeight)"
        
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
                        Text("測定日時:\(selectedScaleDate)")
                        Text("重量[kg]:\(selectedScaleWeight)")
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .padding()
        .navigationBarTitle("入力データ確認")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    DispatchQueue.main.async {
                        print("execute OpenPHP")
                        isSuccess = OpenPHP()
                        
                    }
                    print("isSuccess:\(String(isSuccess))")
                    if isSuccess {
                        isPresented = false
                    }
                }) {
                    Text("データ送信")
                }
                
            }
        }
        .onDisappear {
            flag.isSuccessed = true
        }
        
    }
}

struct SendDataToServerView_Previews: PreviewProvider {
    static var previews: some View {
        SendDataToServerView(isPresented: Binding.constant(false), selectedScaleDate: "no data", selectedScaleWeight: "no data")
    }
}
