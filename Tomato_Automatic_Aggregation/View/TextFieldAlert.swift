//
//  TextFieldAlertView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/11/05.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    let title: String
    @Binding var text1: String
    let text1Placeholder: String
    let isSecureFieldInText1: Bool
    @Binding var text2: String
    let text2Placeholder: String
    let isSecureFieldInText2: Bool
    let presenting: Presenting
    let leftButtonTitle: String
    var leftButtonAction: (() -> Void)?
    let rightButtonTitle: String?
    var rightButtonAction: (() -> Void)?

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    Group {
                        if isSecureFieldInText1 {
                            SecureField(text1Placeholder, text: self.$text1)
                        } else {
                            TextField(text1Placeholder, text: self.$text1)
                        }
                        if isSecureFieldInText2 {
                            SecureField(text2Placeholder, text: self.$text2)
                        } else {
                            TextField(text2Placeholder, text: self.$text2)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Divider()
                    HStack {
                        Button(action: {
                            leftButtonAction!()
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text(leftButtonTitle)
                        }
                        if let rightButtonTitle = rightButtonTitle {
                            Divider()
                            Button(action: {
                                rightButtonAction!()
                                withAnimation {
                                    self.isShowing.toggle()
                                }
                            }) {
                                Text(rightButtonTitle)
                            }
                        }
                        
                    }
                    .fixedSize()
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        title: String,
                        text1: Binding<String>,
                        text1Placeholder: String,
                        isSecureFieldInText1: Bool,
                        text2: Binding<String>,
                        text2Placeholder: String,
                        isSecureFieldInText2: Bool,
                        leftButtonTitle: String,
                        leftButtonAction: (() -> Void)?,
                        rightButtonTitle: String?,
                        rightButtonAction: (() -> Void)?
    ) -> some View {
        TextFieldAlert(
            isShowing: isShowing,
            title: title,
            text1: text1,
            text1Placeholder: text1Placeholder,
            isSecureFieldInText1: isSecureFieldInText1,
            text2: text2,
            text2Placeholder: text2Placeholder,
            isSecureFieldInText2: isSecureFieldInText2,
            presenting: self,
            leftButtonTitle: leftButtonTitle,
            leftButtonAction: leftButtonAction,
            rightButtonTitle: rightButtonTitle,
            rightButtonAction: rightButtonAction)
    }

}
