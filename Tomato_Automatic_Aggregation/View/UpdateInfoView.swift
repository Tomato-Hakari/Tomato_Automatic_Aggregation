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
    
    @State var updateinfo: [UpdateInfo] = [
    UpdateInfo(fileName: "Update_2021_11_02", dateStr: "2021/11/02", dateformat: "yyyy/MM/dd")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(updateinfo) { value in
                    Section(header: Text(value.getDate())) {
                        Text(value.info)
                    }
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
