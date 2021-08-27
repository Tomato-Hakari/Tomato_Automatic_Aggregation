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
                Button("閉じる"){
                    isPresented = false
                }
            }
        }
    }
}

struct SendDataToServerView_Previews: PreviewProvider {
    static var previews: some View {
        SendDataToServerView(isPresented: Binding.constant(false), selectedScaleDate: "no data", selectedScaleWeight: "no data")
    }
}
