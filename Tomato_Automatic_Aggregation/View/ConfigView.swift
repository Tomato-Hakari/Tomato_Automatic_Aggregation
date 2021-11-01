//
//  ConfigView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/19.
//

import SwiftUI

struct ConfigView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    @State var selectedMode: Int? = 0
    
    var body: some View {
        NavigationView{
            VStack{
                GroupBox(label: Text("実行モード(通常時はtrialを選択)")) {
                    List(selection: $selectedMode) {
                        ForEach(0..<flag.modes.count) { num in
                            Text("\(flag.modes[num])")
                        }
                    }
                    .environment(\.editMode, .constant(.active))
                    .onChange(of: selectedMode){ [selectedMode] newvalue in
                        if (newvalue != nil) {
                            flag.currentmode = flag.modes[newvalue!]
                            flag.currentmodeNum = newvalue!
                        } else {
                            self.selectedMode = selectedMode
                        }
                    }
                }
            }
            .navigationTitle("設定")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("閉じる"){
                        if selectedMode != nil {
                            isPresented = false
                        }
                    }
                }
            }
            .onAppear {
                self.selectedMode = flag.currentmodeNum
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(isPresented: Binding.constant(false))
    }
}
