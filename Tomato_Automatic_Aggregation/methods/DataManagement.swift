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

class DataManagement: NSObject {

    // 品種IDにより入力する品種を決定
    class func EnterInputData(ID id:String) {
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
    
    // ListViewに表示する品種名を生成
    class func MakeVarietiesViewName()->[String] {
        var dataArray: [String] = []
        var editString: String = ""
        
        for num in 0..<Varieties.count {
            editString = ""
            // 品種名表示を生成
            if Varieties[num].scion_name != "" {
                editString += Varieties[num].scion_name
                if Varieties[num].rootstock_name != "" {
                    // 台木がある場合(接ぎ木栽培)
                    editString += "+" + Varieties[num].rootstock_name + "(接ぎ木栽培)"
                } else {
                    // 台木がない場合(自根栽培)
                    editString += "(自根栽培)"
                }
            } else {
                // 品種が混在するもの
                editString += Varieties[num].remarks
            }
            dataArray.append(editString)
        }
        
        return dataArray
    }
    
    // Varietyクラスの値をリセット
    class func ResetVariety() {
        Variety.InputVarietyID = ""
        Variety.InputVarietyScionName = ""
        Variety.InputVarietyScionShort = ""
        Variety.InputVarietyRootstockName = ""
        Variety.isInputVarietysYieldSurvey = false
        Variety.InputVarietyRemarks = ""
    }
    
    class func MakeInputVarietyViewName()->String {
        var editString: String = ""
        
        // 品種名表示を生成
        if Variety.InputVarietyScionName != "" {
            editString += Variety.InputVarietyScionName
            if Variety.InputVarietyRootstockName != "" {
                // 台木がある場合(接ぎ木栽培)
                editString += "+" + Variety.InputVarietyRootstockName + "(接ぎ木栽培)"
            } else {
                // 台木がない場合(自根栽培)
                editString += "(自根栽培)"
            }
        } else {
            // 品種が混在するもの
            editString += Variety.InputVarietyRemarks
        }
        
        return editString
    }
    
    // Health Planet API のdateを加工
    class func ProcessDate(DateString datestr:String) -> String {
        if datestr.count != 12 {
            return ""
        }
        var datelist:[String] = []
        for cha in datestr {
            datelist.append(String(cha))
        }
        var year:String = ""
        for i in 0...3 {
            year += datelist[i]
        }
        let month = datelist[4] + datelist[5]
        let day = datelist[6] + datelist[7]
        let time = datelist[8] + datelist[9] + ":" + datelist[10] + datelist[11]
        
        return year + "/" + month + "/" + day + " " + time
    }
}

