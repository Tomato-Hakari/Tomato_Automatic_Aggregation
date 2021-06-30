//
//  ContentView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/05/12.
//

import SwiftUI

struct ContentView: View {
    // Reloaderのインスタンス作成
    @ObservedObject var reloader = Reloader()
    // データ入力画面が表示されているか
    @State var isShowInputView: Bool = false
    
    var body: some View {
        VStack(){
            ZStack(){
                HStack(){
                    Text("\(reloader.value)")
                    Spacer()
                    Button("リセット"){
                        Variety.InputVarietyID = ""
                        Variety.InputVarietyName = ""
                        print("id:\(Variety.InputVarietyID)")
                        print("name:\(Variety.InputVarietyName)")
                    }
                    .sheet(isPresented: $isShowInputView){
                       InputVarietyView(isPresented: self.$isShowInputView)
                    }
                    .padding()
                    
                }
                Text("ミニトマト自動集計").font(.title).fontWeight(.bold).padding()
                
            }
            Spacer()
           
            HStack{
                Button(action: {}){
                    VStack{
                    Text("設定")
                        .font(.system(size: 50))
                        .font(.largeTitle)
                        Text("※開発中")
                    }
                }
                .disabled(true)
                .padding()
                Button("データ入力"){
                    isShowInputView = true
                }
                .sheet(isPresented: $isShowInputView){
                   InputVarietyView(isPresented: self.$isShowInputView)
                }
                .font(.system(size: 50))
                .font(.largeTitle)
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            reloader.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
