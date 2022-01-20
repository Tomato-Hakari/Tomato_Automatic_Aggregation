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
    // データ表示画面が表示されているか
    @State var isShowCheckView: Bool = false
    // 設定画面が表示されているか
    @State var isShowConfigView: Bool = false
    // アップデート情報画面が表示されているか
    @State var isShowUpdateInfoView: Bool = false
    // アラート表示用フラグ
    @State var alertFlag = false
    
    var body: some View {
        ZStack{
            if flag.currentmode == "test" {
                Color.blue.edgesIgnoringSafeArea(.all)
            }
            VStack(){
                ZStack(){
                    HStack(){
                        Text("\(reloader.value)")
                        Spacer()
                        Button("リセット"){
                            Variety.ResetVariety()
                            alertFlag = true
                        }
                        .alert(isPresented: $alertFlag){
                            Alert(title: Text("入力された品種データを\nリセットしました"))
                        }
                        .padding()
                        .hidden()
                        
                    }
                    Text("ミニトマト自動集計").font(.title).fontWeight(.bold).padding()
                    
                }
                Spacer()
               
                if flag.isSuccessedSendings {
                    Text("データの送信に成功しました!")
                        .font(.system(size: 30))
                        .foregroundColor(.orange)
                        .padding()
                }
                
                HStack{
                    Button(action: {
                        flag.isSuccessedSendings = false
                        isShowCheckView = true
                    }) {
                        Text("データ確認")
                            .frame(width: 300, height: 300)
                            .foregroundColor(.black)
                            .font(.system(size: 50))
                                            .font(.largeTitle)
                    }
                    .sheet(isPresented: $isShowCheckView) {
                        GetCheckDataView(isPresented: self.$isShowCheckView)
                    }
                    .background(Color.green)
                    .padding()
                    
                    Button(action: {
                        flag.isSuccessedSendings = false
                        isShowInputView = true
                    }) {
                        Text("データ入力")
                            .frame(width: 300, height: 300)
                            .font(.system(size: 50))
                                            .font(.largeTitle)
                                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $isShowInputView){
                       InputVarietyView(isPresented: self.$isShowInputView)
                    }
                    .background(Color.orange)
                    .padding()
                }
                
                Button(action: {
                    flag.isSuccessedSendings = false
                    isShowConfigView = true
                }) {
                    Text("設定")
                        .frame(width: 150, height: 100)
                        .font(.system(size: 50))
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $isShowConfigView){
                   ConfigView(isPresented: self.$isShowConfigView)
                }
                .background(Color.gray)
                .padding()
                
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        flag.isSuccessedSendings = false
                        isShowUpdateInfoView = true
                    }) {
                        Text("アップデート情報")
                            .frame(width: 270, height: 60)
                            .font(.system(size: 30))
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $isShowUpdateInfoView){
                       UpdateInfoView(isPresented: self.$isShowUpdateInfoView)
                    }
                    .background(Color.blue)
                    .padding()
                }
            }
            .onAppear {
                reloader.start()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

