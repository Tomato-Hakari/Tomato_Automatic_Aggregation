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
            Text("品種名: \(DataManagement.MakeInputVarietyViewName())")
                .font(.system(size: 25))
                .background(Color.yellow)
                .foregroundColor(.black)
                .padding()
            Button(action: {
                UIApplication.shared.open(HealthPlanetURL!)
            }) {
                HealthPlanetButtonView()
                    .frame(width: 400)
            }
            
            NavigationLink("収量データ表示",
                destination: ScaleDataListView(isPresented: $isPresented))
                .font(.title)
                .padding()
                .frame(width: 400, alignment: .center)
                .border(Color.black)
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

