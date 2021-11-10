//
//  ScaleDataListView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/08/19.
//

import SwiftUI
import Combine

struct ScaleDataListView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    let periods = ["24時間","1ヶ月","全期間"]
    
    @State var selectedPeriod: Int = 0;
    
    @ObservedObject var period = LoadingPeriod()
    
    @State var isButtonActive:Bool = false
    
    @ObservedObject var scaledata = ScaleDataFetcher()
    
    @State var selectedScaleData: [SelectedScaleData] = []
    
    @State var hiddendatas: Int = 0;
    
    // Pickerで選択された品種
    @State var selectedNumbers = Set<Int>()
    
    var body: some View {
        VStack{
            NavigationLink(destination: SendDataToServerView(isPresented: $isPresented, selectedScaleData: selectedScaleData), isActive: $isButtonActive){
                EmptyView()
            }
            ZStack{
                GroupBox(label:VStack{
                    Text("「\(DataManagement.MakeInputVarietyViewName())」の適切な収量を選択")
                    HStack{
                        Text("表示する期間を選択→")
                        Picker(selection: $selectedPeriod, label: Text(""), content: {
                            ForEach(0..<periods.count, id: \.self) { value in
                                Text("\(periods[value])")
                                    .tag(value)
                            }
                        })
                            .pickerStyle(SegmentedPickerStyle())
                            .disabled(period.isLoading)
                    }
                } ) {
                    List(selection: $selectedNumbers) {
                        ForEach(0..<scaledata.scale_datum.count, id:\.self) { index in
                            if (selectedPeriod == 0 &&  DataManagement.isToday(dateString: scaledata.scale_datum[index].date, format: "yyyyMMddHHmm")) ||  (selectedPeriod == 2) {
                                Text("\(DataManagement.ProcessDate(DateString: scaledata.scale_datum[index].date)) \(scaledata.scale_datum[index].weight)kg")
                            }
                        }
                    }.environment(\.editMode, .constant(.active))
                }
                
                if scaledata.scale_datum.count == 0 {
                    Text("読み込み中\(period.period)")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.leading)
                        .frame(width: 300.0)
                        .onAppear{
                            period.start()
                        }
                        .onDisappear{
                            period.stop()
                        }
                } else if scaledata.isHerokuDown {
                    VStack {
                        Group {
                            Text("データ取得に失敗しました")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                            Text("ひとつ前の画面に戻ってください")
                                .font(.system(size: 20))
                        }
                        .multilineTextAlignment(.leading)
                        .frame(width: 300.0)
                    }
                } else if hiddendatas == scaledata.scale_datum.count {
                    Text("データがありません")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.leading)
                        .frame(width: 300.0)
                }
            }
        }
        .padding()
        .onAppear {
            scaledata.deleteAll()
            scaledata.load()
            hiddendatas = 0
        }
        .navigationBarTitle("収量選択")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("入力データ確認") {
                    let sortedNumbers = selectedNumbers.sorted()
                    for num in sortedNumbers {
                        selectedScaleData.append(SelectedScaleData(date: DataManagement.ProcessDate(DateString: scaledata.scale_datum[num].date), weight: scaledata.scale_datum[num].weight))
                    }
                    if !selectedScaleData.isEmpty {
                        isButtonActive = true
                    }
                }
                .disabled(period.isLoading)
            }
        }
        .onAppear {

            scaledata.load()
            selectedScaleData.removeAll()
        }
    }
    
    func delete(offsets: IndexSet) {
        let id = scaledata.scale_datum[offsets.first!].id
        guard let url = URL(string: "https://scaleapi.herokuapp.com/scale_data/\(id)") else {
            fatalError("URL生成エラー")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = "isDelete=faise".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let deletedScaleData = try JSONDecoder().decode(Scale_Data.self, from: data)
                if deletedScaleData.id != id {
                    return
                }
            } catch let error {
                print(error)
            }
        }.resume()
        scaledata.scale_datum.remove(atOffsets: offsets)
    }
}

struct ScaleDataListView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleDataListView(isPresented: Binding.constant(false))
    }
}
