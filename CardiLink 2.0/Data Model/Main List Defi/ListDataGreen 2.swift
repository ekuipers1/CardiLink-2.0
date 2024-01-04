//
//  ListDataGreen.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 02.08.21.
//

import Foundation

// MARK: - DataYellowElement
struct DataGreenElement: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var description: String?
    var status: String?
    var statusDate: String?
}

struct DataGreenElementNK: Codable, Identifiable {
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
