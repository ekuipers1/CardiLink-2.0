//
//  ListDataBlue.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 27.07.23.
//

import Foundation

struct DataBlueElement: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var description: String?
    var status: String?
    var statusDate: String?
}
struct DataBlueElementNK: Codable, Identifiable {
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
