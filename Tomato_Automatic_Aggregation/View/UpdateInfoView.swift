//
//  UpdateNotificationView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/11/01.
//

import SwiftUI

struct UpdateInfoView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    @State var updateinfo20211102 = UpdateInfo(fileName: "Update_2021_11_02")
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("2021/11/02")) {
                    Text(updateinfo20211102.info)
                }
            }
            .border(Color.black)
            .padding()
            .navigationTitle("アップデート情報")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("閉じる"){
                        isPresented = false
                    }
                }
            }
        }
        
    }
}

struct UpdateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateInfoView(isPresented: Binding.constant(false))
    }
}
