//
//  GetUpdateInfo.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/11/01.
//

import Foundation

class UpdateInfo: ObservableObject, Identifiable {
    @Published var info: String = ""
    private let fileName: String
    private let date: Date
    
    init(fileName: String, dateStr: String, dateformat: String) {
        self.fileName = fileName
        self.date = DataManagement.DateFromString(string: dateStr, format: dateformat)
        load()
    }
    
    func load() {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            fatalError("ファイルが見つからない")
        }
        
        guard let fileContents = try? String(contentsOf: fileURL) else {
            fatalError("ファイル読み込みエラー")
        }
        
        self.info = fileContents
    }
    
    func getDateString(format: String) -> String {
        return DataManagement.StringFromDate(date: date, format: format)
    }
    
    func getDate() -> Date {
        return self.date
    }
}

extension UpdateInfo {
    class func getUpdateInfo() -> [UpdateInfo] {
        return [
            UpdateInfo(fileName: "2021_11_02", dateStr: "2021_11_02", dateformat: "yyyy_MM_dd"),
            UpdateInfo(fileName: "2021_11_09", dateStr: "2021_11_09", dateformat: "yyyy_MM_dd"),
            UpdateInfo(fileName: "2021_11_18", dateStr: "2021_11_18", dateformat: "yyyy_MM_dd")
        ]
    }
}
