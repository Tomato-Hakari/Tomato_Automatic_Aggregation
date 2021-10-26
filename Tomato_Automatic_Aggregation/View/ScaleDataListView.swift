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
                    Text("適切な収量を選択")
                    HStack{
                        Text("表示する期間を選択6t6→")
                        Picker(selection: $selectedPeriod, label: Text(""), content: {
                            ForEach(0..<periods.count, id: \.self) { value in
                                Text("\(periods[value])")
                                    .tag(value)
                            }
                        })
                            .pickerStyle(SegmentedPickerStyle())
                    }
                } ) {
                    List(selection: $selectedNumbers) {
                        ForEach(0..<scaledata.scale_datum.count, id:\.self) { index in
                            if selectedPeriod == 0 &&  DataManagement.isToday(dateString: scaledata.scale_datum[index].date, format: "yyyyMMddHHmm") {
                                Text("\(DataManagement.ProcessDate(DateString: scaledata.scale_datum[index].date)) \(scaledata.scale_datum[index].weight)kg")
                            } else if selectedPeriod == 1 && DataManagement.isTomonth(dateString: scaledata.scale_datum[index].date, format: "yyyyMMddHHmm") {
                                Text("\(DataManagement.ProcessDate(DateString: scaledata.scale_datum[index].date)) \(scaledata.scale_datum[index].weight)kg")
                            } else if selectedPeriod == 2 {
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
            }
        }
        .onAppear {

            scaledata.load()
            selectedScaleData.removeAll()
        }
    }
}
