//
//  SearchModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.10.23.
//

import Foundation
import SwiftyJSON
import Combine

struct SearchDefibrillator: Identifiable {
    let id: UUID
    let defiId: String
    let serial: String?
    let ownerId: UUID
    let ownerName: String?
    let description: String?
    let lat: Double?
    let lon: Double?
    let dashboardState: Int
    let dashboardStateReason: String?
    let adminStatus: Int
    let address: Address?
    let geoCoordinate: GeoCoordinate?
    
    private enum CodingKeys: String, CodingKey {
        case id = "defiId"
        case serial
        case ownerId
        case ownerName
        case description
        case lat
        case lon
        case dashboardState
        case dashboardStateReason
        case adminStatus
        case address
        case geoCoordinate
    }
    
    init(json: JSON) {
        self.defiId = json[CodingKeys.id.rawValue].stringValue
        self.id = UUID(uuidString: self.defiId) ?? UUID()
        self.serial = json[CodingKeys.serial.rawValue].string
        self.ownerId = UUID(uuidString: json[CodingKeys.ownerId.rawValue].stringValue) ?? UUID()
        self.ownerName = json[CodingKeys.ownerName.rawValue].string
        self.description = json[CodingKeys.description.rawValue].string
        self.lat = json[CodingKeys.lat.rawValue].doubleValue
        self.lon = json[CodingKeys.lon.rawValue].doubleValue
        self.dashboardState = json[CodingKeys.dashboardState.rawValue].intValue
        self.dashboardStateReason = json[CodingKeys.dashboardStateReason.rawValue].string
        self.adminStatus = json[CodingKeys.adminStatus.rawValue].intValue
        self.address = Address(json: json[CodingKeys.address.rawValue])
        self.geoCoordinate = GeoCoordinate(json: json[CodingKeys.geoCoordinate.rawValue])
    }
}

struct Address {
    let street: String?
    let houseNumber: String?
    let floorLevel: String?
    let postalCode: String?
    let postalCodeSub: String?
    let city: String?
    let country: String?
    let timezone: String?
    let comment: String?
    
    init(json: JSON) {
        self.street = json["street"].string
        self.houseNumber = json["houseNumber"].string
        self.floorLevel = json["floorLevel"].string
        self.postalCode = json["postalCode"].string
        self.postalCodeSub = json["postalCodeSub"].string
        self.city = json["city"].string
        self.country = json["country"].string
        self.timezone = json["timezone"].string
        self.comment = json["comment"].string
    }
}

struct GeoCoordinate {
    let latitude: Double?
    let longitude: Double?
    let gravitationalModel: Int?
    let distanceMetricTypes: Int?
    
    init(json: JSON) {
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.gravitationalModel = json["gravitationalModel"].intValue
        self.distanceMetricTypes = json["distanceMetricTypes"].intValue
    }
}

class SearchCriteria: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var searchPostalcode: String = ""
    @Published var searchCityName: String = ""
    @Published var searchCountryName: String = ""
    @Published var searchOwnerName: String = ""
}

class LocationData: ObservableObject {
    @Published var postalCode: String = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
    @Published var cityName: String = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
    @Published var ownerName: String = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""

    func savePostalCode() {
        UserDefaults.standard.set(postalCode, forKey: "postalCodeKey")
    }
    
    func saveCityName() {
        UserDefaults.standard.set(cityName, forKey: "cityNameKey")
    }
    
    func saveOwnerName() {
        UserDefaults.standard.set(ownerName, forKey: "ownerNameKey")
    }

}

class SharedDataModel: ObservableObject {
    static let shared = SharedDataModel()
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var defibrillatorCount: Int = 0
}
