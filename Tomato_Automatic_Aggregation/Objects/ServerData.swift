//
//  CheckData.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/10/18.
//

import Foundation

struct ServerData: Codable {
    var adddatetime: String
    var varietyID: String
    var scion: String?
    var scionshort: String?
    var rootstock: String?
    var issurvey: Bool
    var remarks: String?
    var measurementdatetime: String
    var yield: Float

}
