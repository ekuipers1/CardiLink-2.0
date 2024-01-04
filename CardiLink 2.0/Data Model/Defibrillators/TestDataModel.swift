//
//  TestDataModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 20.12.21.
//

import Foundation

// MARK: - DefiDataTest
struct DefiDataTest {
    var success: Bool?
    var error: NSNull?
    var errorCode: Int?
    var data: [Datum]?
}

// MARK: - Datum
struct Datum:  Codable, Identifiable  {
    var id, serial, ownerID: String?
    var ownerName: String?
    var datumDescription: String?
    var lat, lon: NSNull?
    var dashboardState, adminStatus: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "defiId"
    }
}

//enum Description {
//    case createdOn20211220
//}
//
//enum OwnerName {
//    case nihonKohdenCorporation日本光電工業株式会社
//}
