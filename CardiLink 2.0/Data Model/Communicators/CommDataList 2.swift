//
//  CommDataList.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.09.21.
//

import Foundation

// MARK: - CommNK
//struct CommNK {
////    var id: Int
//    var success: Bool?
//    var error: NSNull?
//    var errorCode: Int?
//    var data: [NKCommData]
//}

// Datum.swift

// MARK: - Datum
struct commData: Codable, Identifiable {
    public var id: String?
    public var commSerial: String?
    public var ownerId: String?
    public var description: String?
    public var ownerName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "commId"
//        case serial = "commSerial"
        case ownerId,description, commSerial, ownerName
    }
}


