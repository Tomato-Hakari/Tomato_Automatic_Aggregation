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
    
    func getDate() -> String {
        return DataManagement.StringFromDate(date: date, format: "yyyy/MM/dd")
    }
}
