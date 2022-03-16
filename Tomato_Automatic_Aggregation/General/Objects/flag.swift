//
//  flag.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/09/28.
//

import Foundation

class flag: ObservableObject {
    // データベースにデータが送信できたかどうか(ほぼ意味ない)
    static var isSuccessedSendings: Bool = false
    
    // 現在のモード(trial or test)
    static var currentmode: String = "trial"
    
    // 現在のモード(trial:0, test:1)
    // currentmodeと状態が異なることがないよう注意
    static var currentmodeNum: Int = 0
    
    // モードの種類(currentmodeとcurrentmodeNumの対応はこれで決まる)
    static let modes: [String] = ["trial", "test"]
}
