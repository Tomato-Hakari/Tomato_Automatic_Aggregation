//
//  ScaleDatafetcher.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/08/19.
//

import Foundation
import Combine

class ScaleDataFetcher: ObservableObject {
    @Published var scale_datum: [Scale_Data] = []

    init() {
        load()
    }

    func load() {
        let url = URL(string: "https://scaleapi.herokuapp.com/scale_data")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.scale_datum = try! JSONDecoder().decode([Scale_Data].self, from: data!)
            }
        }.resume()
    }
    
    func deleteAll() {
        self.scale_datum.removeAll()
    }
}
