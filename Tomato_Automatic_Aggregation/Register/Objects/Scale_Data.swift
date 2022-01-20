//
//  Scale_Data.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/08/19.
//

import Foundation

struct Scale_Data: Decodable, Identifiable, Hashable {
    var id: Int
    var date: String
    var weight: String
    var model: String
    var tag: String
    var created_at: String
    var updated_at: String
    var isDelete: Bool
    var Checked: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case weight = "keydata"
        case model = "model"
        case tag = "tag"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case isDelete = "isDelete"
    }
}
