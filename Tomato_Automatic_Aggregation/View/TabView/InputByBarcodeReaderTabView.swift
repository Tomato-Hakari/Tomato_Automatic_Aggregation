//
//  InputByBarcodeReaderView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/05/29.
//

import SwiftUI
import Combine

struct InputByBarcodeReaderTabView: View {
    // テキストの最大入力文字数
    private let maxTextlength: Int = 14
    // バーコードリーダーからの読み取りデータを格納
    @State var InputByBarcodeReader: String = ""
    // バーコードリーダー入力待ちかどうか
    @State var isBarcodeReaderEditing: Bool = false
    // 入力値が適切かどうか
    @State var isInputDataAppropriate: Bool = false
    
    let Varieties: [VarietiesDataBase] = Bundle.main.decodeJSON(file: "varieties.json")
    
    @State var currentVarietyName: String = ""

    var body: some View {
        ZStack{
            Color.white.onTapGesture {
                UIApplication.shared.endEditing()
            }

            VStack{
                
                
                HStack{
                    Text("品種ID:")
                    CustomTextField(text: $InputByBarcodeReader, isFirstResponder: true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:250, height:30)
                        .onReceive(Just($InputByBarcodeReader), perform: { _ in
                            if maxTextlength < InputByBarcodeReader.count {
                                InputByBarcodeReader = String(InputByBarcodeReader.suffix(1))
                            }
                            if CalculateCheckDigit.isErrorInBarcode(InputByBarcodeReader) {
                                isInputDataAppropriate = false
                                currentVarietyName = ""
                            } else {
                                isInputDataAppropriate = true
                                DataManagement.EnterInputData(ID: String(InputByBarcodeReader.dropLast(1)))
                                
                            }
                        })
                    Spacer()
                    
                    if !InputByBarcodeReader.isEmpty {
                        Button(action: {
                            print("button pushed")
                            InputByBarcodeReader = ""
                        }, label: {
                            Image(systemName: "multiply.circle")
                                .frame(width: 40.0, height: 40.0)
                        })
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)){ _ in
                    isBarcodeReaderEditing = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)){ _ in
                    isBarcodeReaderEditing = false
                }
                .padding()
                if InputByBarcodeReader.isEmpty{
                    Text("")
                        .frame(height:0)
                } else if CalculateCheckDigit.isErrorInBarcode(InputByBarcodeReader) {
                    Text("入力値が不適切です")
                        .foregroundColor(.red)
                } else {
                    Text("").frame(height:0)
                }
                
                if isInputDataAppropriate {
                    Text("品種名: \(DataManagement.VarietyIDtoName(ID: String(InputByBarcodeReader.prefix(13))))")
                        .font(.system(size: 25))
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .padding()
                }
                Text("ソフトウェアキーボード:\(isBarcodeReaderEditing ? "true" : "false")")
                    .hidden()
            }
        }
    }
}

struct InputByBarcodeReaderTabView_Previews: PreviewProvider {
    static var previews: some View {
        InputByBarcodeReaderTabView()
    }
}
