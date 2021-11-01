//
//  flag.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/09/28.
//

import Foundation

class flag: ObservableObject {
    static var isSuccessedSendings: Bool = false
    static var currentmode: String = "trial"
    static var currentmodeNum: Int = 0
    static let modes: [String] = ["trial", "test"]
}

