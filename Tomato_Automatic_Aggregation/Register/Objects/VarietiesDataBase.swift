//
//  VarietiesDataBase.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/09/27.
//

import Foundation
// 品種IDと品種名の関連付け
struct VarietiesDataBase: Codable {
    var id: String
    var scion_name: String
    var scion_short: String
    var rootstock_name: String
    var isYieldSurvey: Bool
    var remarks: String
}
