//
//  CheckDataView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/18.
//

import SwiftUI
import Combine

struct CheckDataView: View {
    // Reloaderのインスタンス作成
    @ObservedObject var reloader = Reloader()
    // シートが開いている状態
    @Binding var isPresented: Bool

     var TomatoData: [CheckData]

    
    
    var body: some View {
        VStack{
            if !TomatoData.isEmpty{
                List {
                    Section(header: Text("項目をタップで詳細表示\(reloader.value)")){
                        ForEach(0..<TomatoData.count, id: \.self) { section in
                           DetailDataHeader(TomatoData: TomatoData[section])
                                .foregroundColor(.black)
                                .padding()
                                .border(Color.gray, width:1)
                        }
                    }
                }.listStyle(PlainListStyle())
            }
        }
        .navigationTitle("データ確認")
        .navigationBarItems(trailing:
            Button("閉じる"){
                isPresented = false
            }
        )
        .navigationBarBackButtonHidden(true)
        .onAppear{
            reloader.start()
        }
    }
}

struct Rows: View {
    let TomatoData: CheckData
    
    var body: some View {
        VStack {
            HStack{
                Text("品種ID:\(TomatoData.varietyID)")
                    .padding(.trailing)
                Spacer()
                Text("収量調査:\(TomatoData.issurvey ? "する" : "しない")")
                    .padding(.leading)
                Spacer()
            }
            HStack{
                Text("重量測定日時:\(TomatoData.measurementdatetime)")
                    .padding(.top, 5.0)
                Spacer()
            }
        }
    }
}

struct DetailDataHeader: View {
    let TomatoData: CheckData
    @State var isExpanded: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.isExpanded.toggle()
            }) {
                VStack {
                    HStack {
                        Text("登録日時:\(TomatoData.adddatetime)")
                        Spacer()
                        Text("\(String(format: "%.2f",TomatoData.yield)) kg")
                    }
                    Text(DataManagement.VarietyIDtoName(ID: TomatoData.varietyID))
                        .fontWeight(.bold)
                        .padding(5.0)
                    if self.isExpanded {
                        Rows(TomatoData: TomatoData)
                    }
                }.font(.system(size: 20))
            }
        }
    }
}

