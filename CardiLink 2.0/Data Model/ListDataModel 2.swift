//
//  ListDataModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import Foundation
import MapKit

struct acme: Codable, Identifiable {
    public var id: String?
    public var context: String?
    public var ownerId: String?
    public var acmedescription : Description?
    public var model: String?
    public var geoLocation: GeoLocation?
    public var battery: Battery?
    
    
    public var title: TicketTitleInfo?
    public var author: Author?
    public var priority: String?
    public var location: TicketLocationInfo?
    public var problemDescriptions: [AdditionalInfoList]?
    public var additionalInfo: AdditionalInfo?
    public var affected: Affected?
    public var statusIndicators: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case context = "@context"
        case ownerId = "ownerId"
        case acmedescription = "description"
        case model, geoLocation, battery, title, author, priority, location, problemDescriptions, additionalInfo, affected, statusIndicators //, status//, pairedCommunicators
    }
    
    enum Int {
        
        case communicatorBatteryLevel, transmissionAttempts
    }
    
}

// MARK: - Description
struct Description: Codable {
    let en: String
}

struct MessageContent {
    var errorReportPart: String?
    var messagePartNumber: Int?
}


// MARK: - GeoLocation
struct GeoLocation: Codable {
    let lat, lng: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

// MARK: - PairedCommunicator
struct PairedCommunicator: Codable {
    let communicatorID, pairingDate: String
    
    enum CodingKeys: String, CodingKey {
        case communicatorID = "communicatorId"
        case pairingDate
    }
}

struct Battery: Codable {
    let activationDate: String?
}

struct DictionaryIndex0: Codable {
    let statusbla: String?
}

// MARK: - TicketTitleInfo
struct TicketTitleInfo: Codable {
    var en: String
}

// MARK: - TicketLocationInfo
struct TicketLocationInfo: Codable {
    var en: String
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Codable {
    var en: String
}

// MARK: - AdditionalInfoList
struct AdditionalInfoList: Codable {
    var en: String
}

// MARK: - Affected
struct Affected: Codable {
    var defibrillators, communicators: [Ator]?
}

// MARK: - Ator
struct Ator: Codable {
    var deviceID, model, warrantyStatus: String
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case model, warrantyStatus
    }
}

// MARK: - Author
struct Author: Codable {
    var id, name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case name
    }
}

struct Status: Codable {
    var date, state: String
}

// MARK: - Description
struct CommDescription: Codable {
    let en: String
}

// MARK: - PCB
struct PCB: Codable {
}

// MARK: - SIMCard
struct SIMCard: Codable {
    let id, activationCode: String
    let phoneNumber, ipAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case activationCode, phoneNumber
        case ipAddress = "IPAddress"
    }
}

