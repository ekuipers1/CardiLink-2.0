//
//  CommDataList.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.09.21.
//

import Foundation

struct commData: Codable, Identifiable {
    public var id: String?
    public var commSerial: String?
    public var ownerId: String?
    public var description: String?
    public var ownerName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "commId"
        case ownerId,description, commSerial, ownerName
    }
}


