//
//  EnterInputData.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/06/05.
//

import Foundation
import UIKit


let Varieties: [VarietiesDataBase] = Bundle.main.decodeJSON(file: "varieties.json")

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
    
    class func MakeVarietyViewName(Scion scion:String, Rootstock rootstock:String, Remarks remarks:String) -> String {
        var editString: String = ""
        
        if scion != "" {
            editString += scion
            if rootstock != "" {
                // 台木がある場合(接ぎ木栽培)
                editString += "+" + rootstock + "(接ぎ木栽培)"
            } else {
                // 台木がない場合(自根栽培)
                editString += "(自根栽培)"
            }
        } else {
            // 品種が混在するもの
            editString += remarks
        }
        
        return editString
    }
  
    // ListViewに表示する品種名を生成
    class func MakeVarietiesViewName()->[String] {
        var dataArray: [String] = []
        var editString: String = ""
        
        for num in 0..<Varieties.count {
            editString = ""
            editString = MakeVarietyViewName(Scion: Varieties[num].scion_name, Rootstock: Varieties[num].rootstock_name, Remarks: Varieties[num].remarks)
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
        
        editString = MakeVarietyViewName(Scion: Variety.InputVarietyScionName, Rootstock: Variety.InputVarietyRootstockName, Remarks: Variety.InputVarietyRemarks)
        
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
        let time = datelist[8] + datelist[9] + ":" + datelist[10] + datelist[11] + ":00"
        
        return year + "/" + month + "/" + day + "_" + time
    }
    
    // 品種IDから対応する品種名を返す
    class func VarietyIDtoName(ID id:String) -> String {
        for num in 0..<Varieties.count {
            if id == Varieties[num].id {
                return MakeVarietyViewName(Scion: Varieties[num].scion_name, Rootstock: Varieties[num].rootstock_name, Remarks: Varieties[num].remarks)
            }
        }
        return ""
    }
    
    // PHPスクリプトのURLの先頭を返す
    class func GeneratePHPURLHead() -> String {
        return "http://www.cyanpuma31.sakura.ne.jp/accessDB/\(flag.currentmode)"
    }
    
    // String=>Date変換
    class func DateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    // Date=>String変換
    class func StringFromDate(date: Date, format: String) ->String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

