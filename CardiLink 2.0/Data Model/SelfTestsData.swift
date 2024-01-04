//
//  SelfTestsData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.03.21.
//

import Foundation

struct SelfTest: Codable, Identifiable {
    var id: String?
    var context: String?
    var timestamp: String?
    var defibrillatorID: String?
    var isBatteryError: Bool?
    var isUncriticalError: Bool?
    var isRedError: Bool?
    var cryptoHash: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case context = "@context"
        case timestamp
        case defibrillatorID = "defibrillatorId"
        case isBatteryError, isUncriticalError, isRedError, cryptoHash
    }
}
typealias SelfTests = [SelfTest]
