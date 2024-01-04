//
//  ListDataGray.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 06.03.23.
//

import Foundation

struct DataGrayElement: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var description: String?
    var status: String?
    var statusDate: String?
}
struct DataGrayElementNK: Codable, Identifiable {
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
