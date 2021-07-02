//
//  EnterInputData.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/06/05.
//

import Foundation
import UIKit

// 品種IDと品種名の関連付け
struct VarietiesDataBase: Codable {
    var id: String
    var scion_name: String
    var scion_short: String
    var rootstock_name: String
    var isYieldSurvey: Bool
    var remarks: String
}
let Varieties: [VarietiesDataBase] = Bundle.main.decodeJSON("varieties.json")

class EnterInputData: NSObject {

    // 品種IDにより入力する品種を決定
    class func EnterData(ID id:String) {
        print("EnterData:ID")
        for num in 0..<Varieties.count {
            if Varieties[num].id == id {
                Variety.InputVarietyID = Varieties[num].id
                Variety.InputVarietyScionName = Varieties[num].scion_name
                Variety.InputVarietyScionShort = Varieties[num].scion_short
                Variety.InputVarietyRootstockName = Varieties[num].rootstock_name
                Variety.isInputVarietysYieldSurvey = Varieties[num].isYieldSurvey
                Variety.InputVarietyRemarks = Varieties[num].remarks
                return
            }
        }
    }
    
    // 品種名により入力する品種を決定
    class func EnterData(Name name:String) {
        print("EnterData:Name")
        for num in 0..<Varieties.count {
            if Varieties[num].scion_name == name {
                Variety.InputVarietyID = Varieties[num].id
                Variety.InputVarietyScionName = Varieties[num].scion_name
                Variety.InputVarietyScionShort = Varieties[num].scion_short
                Variety.InputVarietyRootstockName = Varieties[num].rootstock_name
                Variety.isInputVarietysYieldSurvey = Varieties[num].isYieldSurvey
                Variety.InputVarietyRemarks = Varieties[num].remarks
                return
            }
        }
    }
}
