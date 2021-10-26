//
//  ShareData.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/05/26.
//

import Foundation

class Variety: ObservableObject {
    static var InputVarietyID: String = ""
    static var InputVarietyScionName: String = ""
    static var InputVarietyScionShort: String = ""
    static var InputVarietyRootstockName: String = ""
    static var isInputVarietysYieldSurvey: Bool = false
    static var InputVarietyRemarks: String = ""
    
    // Varietyクラスの値をリセット
    class func ResetVariety() {
        Variety.InputVarietyID = ""
        Variety.InputVarietyScionName = ""
        Variety.InputVarietyScionShort = ""
        Variety.InputVarietyRootstockName = ""
        Variety.isInputVarietysYieldSurvey = false
        Variety.InputVarietyRemarks = ""
    }
}

