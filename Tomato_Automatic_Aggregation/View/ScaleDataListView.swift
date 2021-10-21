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
    
    @ObservedObject var reloader = Reloader()
    
    @ObservedObject var period = LoadingPeriod()
    
    @State var isButtonActive:Bool = false
    
    @ObservedObject var scaledata = ScaleDataFetcher()
    
    @State var selectedScaleDate:String = ""
    @State var selectedScaleWeight:String = ""
    
    // Pickerで選択された品種
    @State var selectedData:Int? = 0
    
    var body: some View {
        VStack{
            NavigationLink(destination: SendDataToServerView(isPresented: $isPresented, selectedScaleDate: selectedScaleDate, selectedScaleWeight: selectedScaleWeight), isActive: $isButtonActive){
                EmptyView()
            }
            ZStack{
                GroupBox(label: Text("適切な収量を選択")) {
                    List(selection: $selectedData) {
                        ForEach(0..<scaledata.scale_datum.count, id:\.self) { index in
                            Text("\(DataManagement.ProcessDate(DateString: scaledata.scale_datum[index].date)) \(scaledata.scale_datum[index].weight)kg")
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
                            print("scale_data.measurementdatetime:\(scaledata.scale_datum[0].date)")
                        }
                }
            }
        }
        .padding()
        .onAppear {
            scaledata.deleteAll()
            scaledata.load()
        }
        .navigationBarTitle("収量選択\(reloader.value)")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("入力データ確認") {
                    if scaledata.scale_datum[selectedData!].weight != "" {
                        selectedScaleDate = DataManagement.ProcessDate(DateString: scaledata.scale_datum[selectedData!].date)
                        selectedScaleWeight = scaledata.scale_datum[selectedData!].weight
                    }
                    if selectedScaleWeight != "" {
                        isButtonActive = true
                    }
                }
            }
        }
        .onAppear {
            reloader.start()
            scaledata.load()
        }
    }
}

struct ScaleDataListView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleDataListView(isPresented: Binding.constant(false))
    }
}
