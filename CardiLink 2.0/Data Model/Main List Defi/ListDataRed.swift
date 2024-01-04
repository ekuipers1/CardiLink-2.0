//
//  ListDataRed.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.03.21.
//

import Foundation

struct DataRedElement: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var description: String?
    var status: String?
    var statusDate: String?
}
struct DataRedElementNK: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var ownerName: String?
    var description: String?
    var serial: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "defiId"
        case serial = "serialId"
        case ownerId,description, ownerName
    }
}
