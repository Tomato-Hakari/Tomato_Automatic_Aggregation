//
//  GetCheckDataView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/18.
//

import SwiftUI
import Combine

struct GetCheckDataView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    // レスポンスされた文字列を格納する変数
    @State var result: String = ""
    // データベースのデータを格納する配列
    @State var TomatoData = [ServerData]()
    // TomatoData配列にデータが入っているかどうか
    @State var isTomatoDataIn: Bool = false
    /// データ読み込み処理
    func loadData() {

        /// URLの生成
        guard let url = URL(string: "\(DataManagement.GeneratePHPURLHead())/get.php") else {
            /// 文字列が有効なURLでない場合の処理
            return
        }

        /// URLリクエストの生成
        let request = URLRequest(url: url)

        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let stringdata = String(data: data, encoding: .utf8) else {
                    print("Json decode エラー")
                    return
                }
                DispatchQueue.main.async {
                    result = stringdata
                    if result != "[]" {
                        let decoder = JSONDecoder()
                        TomatoData = try! decoder.decode([ServerData].self, from: result.data(using: .utf8)!)
                        if !TomatoData[0].adddatetime.isEmpty {
                            result = ""
                            isTomatoDataIn = true
                        }
                    }
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }

        }.resume()      // タスク開始処理（必須）
        
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    // isTomatoDataInがtrueになったらページ遷移
                    NavigationLink(destination: CheckServerDataView(isPresented: $isPresented, TomatoData: TomatoData), isActive: $isTomatoDataIn) {
                        EmptyView()
                    }
                    .navigationTitle(Text("読み込み中"))
                    .navigationBarItems(trailing:
                        Button("閉じる"){
                            isPresented = false
                        }
                    )
                    
                    if !result.isEmpty {
                        Text(result)
                        .foregroundColor(.white)
                    }
                }
                .onAppear {
                    // ページが開いたときの処理
                    DispatchQueue.main.async {
                        print("reload.onappear")
                        TomatoData.removeAll()
                        isTomatoDataIn = false
                        loadData()
                    }
                    
                }
                if result == "[]" {
                    Text("テーブルが空です")
                        .font(.system(size: 50))
                }
            }
        }
        
                
    }
    
}


struct GetCheckDataView_Previews: PreviewProvider {
    static var previews: some View {
        GetCheckDataView(isPresented: Binding.constant(false))
    }
}

