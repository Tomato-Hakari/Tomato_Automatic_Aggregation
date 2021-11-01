//
//  GetUpdateInfo.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/11/01.
//

import Foundation

class UpdateInfo: ObservableObject {
    @Published var info: String = ""
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
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
}
