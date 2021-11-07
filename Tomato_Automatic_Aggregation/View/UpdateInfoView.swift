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
    
    @State var updateinfo: [UpdateInfo] = UpdateInfo.getUpdateInfo()
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(updateinfo) { value in
                    Section(header: Text(value.getDateString(format: "yyyy/MM/dd"))) {
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
        .onAppear {
            updateinfo.sort(by: {$0.getDate() > $1.getDate()})
        }
        
    }
}

struct UpdateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateInfoView(isPresented: Binding.constant(false))
    }
}
