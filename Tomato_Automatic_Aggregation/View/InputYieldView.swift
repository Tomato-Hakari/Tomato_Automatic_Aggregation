//
//  InputYieldView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/06/30.
//

import SwiftUI

struct InputYieldView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
            Text("開発中").font(.title).padding()
            HStack(){
                Text("品種ID：" + Variety.InputVarietyID)
                Spacer()
            }
            .frame(width: 250.0)
            HStack(){
                Text("品種名：" + Variety.InputVarietyScionName)
                Spacer()
            }.frame(width: 250.0)
        }
        .padding()
        .navigationBarTitle("収量入力")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("閉じる"){
                    isPresented = false
                }
            }
        }
    }
}

struct InputYieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputYieldView(isPresented: Binding.constant(false))
    }
}
