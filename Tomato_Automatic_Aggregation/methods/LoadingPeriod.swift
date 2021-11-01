//
//  LoadingPeriod.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/19.
//

import Foundation
import Combine

// 読み込み中のアニメーション(ピリオドの表示数を０~3個の順にループする)を作成するクラス
class LoadingPeriod: ObservableObject{
    @Published var timer: Timer!
    @Published var count: Int = 0
    @Published var period: String = ""
    @Published var isLoading: Bool = false
    private let max: Int = 3


    func start(){
        // Timerの実態があるときは停止させる
        self.timer?.invalidate()
        // count初期化
        self.count = 0
        self.isLoading = true
        // Timer取得
        self.timer = Timer.scheduledTimer(withTimeInterval:0.5, repeats: true){ _ in
            self.period = ""
            self.count += 1
            if self.count > self.max {
                self.count = 0
            }
            for _ in 0 ..< self.count {
                self.period += "."
            }
        }
    }

    func stop(){
        timer?.invalidate()
        timer = nil
        self.isLoading = false
    }
}
