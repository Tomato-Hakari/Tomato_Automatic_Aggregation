//
//  InputYieldView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/06/30.
//

import SwiftUI
import Alamofire

struct InputYieldView: View {
    // 体重計から得たデータを格納
    struct ScaleData: Codable {
        var date: String
        var keydata: String
        var model: String
        var tag: String
    }
    
    @State var scale: [ScaleData] = []
    
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    // HealthPlanetアプリのURL
    let HealthPlanetURL = URL(string: "healthplanet://")
    
    // apiscaleのURL
    let apiscaleURL = URL(string: "https://apiscale.herokuapp.com")
    
    var body: some View {
        VStack{
            Button("Health Planet アプリへ遷移"){
                UIApplication.shared.open(HealthPlanetURL!, options: [.universalLinksOnly: false], completionHandler: { completed in
                    print(completed)
                })
            }
            .padding()
            HStack(){
                Text("品種ID：" + Variety.InputVarietyID)
                Spacer()
            }
            .frame(width: 250.0)
            
            HStack(){
                Text("品種名：" + Variety.InputVarietyScionName)
                Spacer()
            }.frame(width: 250.0)
            
            Button("収量データ表示"){
                UIApplication.shared.open(apiscaleURL!, options: [.universalLinksOnly: false], completionHandler: { completed in
                    print(completed)
                })
            }
            .padding()
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

