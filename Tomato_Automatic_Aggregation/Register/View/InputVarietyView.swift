//
//  GetDataFromBarcodereader.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/05/26.
//

import SwiftUI

extension UIApplication {
    // キーボードを下げる
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct InputVarietyView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    // 選択されているタブ
    @State var selectedTab = 1
    
    // 収量測定画面に遷移できる状態かどうか
    @State var isVarietyDataIn = false

    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: CheckVarietyView(isPresented: $isPresented), isActive: $isVarietyDataIn){
                    EmptyView()
                }
                TabView(selection: $selectedTab){
                    InputByBarcodeReaderTabView()
                        .tabItem {
                            Text("バーコードリーダーで入力")
                        }
                        .tag(1)
                    InputByListTabView()
                        .tabItem {
                            Text("一覧から入力")
                        }
                        .tag(2)
                }
                .navigationBarTitle("品種入力")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("閉じる"){
                            isPresented = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        
                        Button("収量測定へ"){
                            if !Variety.InputVarietyID.isEmpty{
                                isVarietyDataIn = true
                            }
                        }
                    }
                }
            }
        }
        .font(.body)
    }
}

struct GetDataFromBarcodereader_Previews: PreviewProvider {
    static var previews: some View {
        InputVarietyView(isPresented: Binding.constant(false))
    }
}
