//
//  ServiceTicketData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.03.21.

import Foundation

// MARK: - SeriveTicket
struct SeriveTicket: Codable, Identifiable {
    var id: String?
    var context: String?
    var title: AdditionalInfoService?
    var status: StatusService?
    var author: AuthorService?
    var priority: Priority?
    var location: AdditionalInfo?
    var statusIndicators: [StatusIndicator]?
    var affected: AffectedService?
    var problemDescriptions: [AdditionalInfo]?
    var additionalInfo: AdditionalInfo?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case context = "@context"
        case title, status, author, priority, location, statusIndicators, affected, problemDescriptions, additionalInfo
    }
}

// MARK: - AdditionalInfo
struct AdditionalInfoService: Codable {
    var en: String?
}

// MARK: - Affected
struct AffectedService: Codable {
    var defibrillators: [Defibrillator]?
}

// MARK: - Defibrillator
struct Defibrillator: Codable {
    var deviceID: String?
    var defibrillatorDescription: AdditionalInfo?
    var model: String?
    var warrantyStatus: WarrantyStatus?

    enum CodingKeys: String, CodingKey {
        case deviceID
        case defibrillatorDescription
        case model, warrantyStatus
    }
}

enum WarrantyStatus: String, Codable {
    case unknown = "unknown"
}

// MARK: - Author
struct AuthorService: Codable {
    var id, name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

enum Priority: String, Codable {
    case high = "high"
    case low = "low"
    case normal = "normal"
}


enum StatusIndicator: String, Codable {
    case battery = "battery"
    case ok = "ok"
    case repair = "repair"
}


struct StatusService: Codable {
//    var date, state: String
}


typealias SeriveTickets = [SeriveTicket]
