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
            GroupBox(label: Text("適切な収量を選択\n(表示されてない場合は前の画面に一度戻り再度この画面を開いてください)")) {
                List(selection: $selectedData) {
                    ForEach(0..<scaledata.scale_datum.count) { index in
                        Text("\(DataManagement.ProcessDate(DateString: scaledata.scale_datum[index].date)) \(scaledata.scale_datum[index].weight)kg")
                    }
                }.environment(\.editMode, .constant(.active))
            }
        }
        .padding()
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
        }
    }
}

struct ScaleDataListView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleDataListView(isPresented: Binding.constant(false))
    }
}
