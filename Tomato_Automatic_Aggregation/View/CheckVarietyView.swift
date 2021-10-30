//
//  InputYieldView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/06/30.
//

import SwiftUI

struct CheckVarietyView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    // HealthPlanetアプリのURL
    let HealthPlanetURL = URL(string: "healthplanet://")
    
    var body: some View {
        VStack{
            Link("Health Planet アプリへ遷移(収量データ送信)", destination: HealthPlanetURL!)
                .padding()
            HStack(){
                Text("品種ID：" + Variety.InputVarietyID)
                Spacer()
            }
            .frame(width: 250.0)
            
            HStack(){
                Text("品種名：" + DataManagement.MakeInputVarietyViewName())
                Spacer()
            }.frame(width: 250.0)
            
            NavigationLink("収量データ表示",
                destination: ScaleDataListView(isPresented: $isPresented))
            .padding()
        }
        .padding()
        .navigationBarTitle("品種確認・収量取得準備")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("閉じる"){
                    isPresented = false
                }
            }
        }
    }
}

struct CheckVarietyView_Previews: PreviewProvider {
    static var previews: some View {
        CheckVarietyView(isPresented: Binding.constant(false))
    }
}

