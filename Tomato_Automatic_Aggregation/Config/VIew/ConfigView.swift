//
//  ConfigView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/19.
//

import SwiftUI

struct DeveloperLogin {
    var id = ""
    var password = ""
}
struct DeveloperDB: Codable {
    let id: String
    let pass: Int
}

struct ConfigView: View {
    // シートが開いている状態
    @Binding var isPresented: Bool
    
    @State var selectedMode: Int? = 0
    
    @State var toDeveloperLogin: Bool = false
    
    @State var isLoginError: Bool = false
    
    @State var login = DeveloperLogin()
    let Developer: DeveloperDB = Bundle.main.decodeJSON(file: "Developer.json")
    
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
                        if newvalue == 1 {
                            toDeveloperLogin = true
                        }
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
        .textFieldAlert(
            isShowing: $toDeveloperLogin,
            title: "開発者用ログイン",
            text1: $login.id,
            text1Placeholder: "開発者ID",
            isSecureFieldInText1: false,
            text2: $login.password,
            text2Placeholder: "パスワード",
            isSecureFieldInText2: true,
            leftButtonTitle: "キャンセル",
            leftButtonAction: {
                self.selectedMode = 0
                UIApplication.shared.endEditing()
            },
            rightButtonTitle: "ログイン",
            rightButtonAction: {
                UIApplication.shared.endEditing()
                var hash = 0
                for code in login.password.utf8 {
                    hash += Int(code)
                }
                if (login.id != Developer.id) || (hash != Developer.pass) {
                    self.selectedMode = 0
                    login.password = ""
                    isLoginError = true
                }
            })
        .alert(isPresented: $isLoginError) {
            Alert(title: Text("ログイン失敗"), message: Text("ログインIDまたはパスワードが異なります。"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(isPresented: Binding.constant(false))
    }
}

