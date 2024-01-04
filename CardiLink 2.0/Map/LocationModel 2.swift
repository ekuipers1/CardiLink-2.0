//
//  LocationModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import Foundation
import MapKit

struct LatLonAvailable: Codable, Identifiable {
    var id: String
    var latitude: Double
    var longitude: Double
    var status: String
    var ownerid: String
    var ownerName: String
    var ownerSerial: String
    
    // Computed Property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


struct MoveLatLonAvailable: Codable, Identifiable {
    var id: String
    var latitude: Double
    var longitude: Double
//    var status: String
//    var ownerid: String
    
    // Computed Property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
