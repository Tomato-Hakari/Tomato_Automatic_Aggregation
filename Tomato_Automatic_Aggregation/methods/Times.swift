//
//  Reloader.swift
//  Tomato_Automatic_Aggregation
//
//  Created by Terao Jumpei on 2021/06/06.
//

import Foundation
import SwiftUI

// 空白の長さを0.5秒毎に変えることによる画面再読み込みクラス
class Reloader: ObservableObject {
    @Published var value: String = ""
    @State private var roop: Int = 0
    private var timer = Timer()
    
    // 使いたいViewの.onAppearで使用
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _  in
            self.value = ""
            self.roop = Int.random(in: 0 ... 20)
            for _ in 0 ... self.roop {
                self.value += " "
            }
        }
    }
}
