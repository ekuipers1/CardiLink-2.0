//
//  ListDataService.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.04.21.
//

import Foundation

struct DataServiceElement: Codable, Identifiable {
    var id: String?
    var ownerId: String?
    var description: String?
    var status: String?
    var statusDate: String?
}

struct DataServiceNKElement: Codable, Identifiable {
    var id: String?
    var title: String?
    var status: String?
    var priority: String?
    var eventTime: String?
    var DefibrillatorSerial: String?
    var DefibrillatorId: String?
    var CommunicatorSerial: String?
    var CommunicatorId: String?
    var additionalInfo: String?
}
