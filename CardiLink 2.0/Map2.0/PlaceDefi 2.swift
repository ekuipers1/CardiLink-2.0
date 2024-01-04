//
//  MapView2.0.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.02.22.
//

import Foundation
import MapKit

final class PlaceDefi: NSObject, Decodable, Identifiable {
    let ownerName: String
    let idCode: String
    let ownerSerial: String
    let status: String
    let ownerid: String
    let location: CLLocation
    private let regionRadius: CLLocationDistance = 1500
    let region: MKCoordinateRegion
    let id = UUID()
    
    init(from decoder: Decoder) throws {
        
        enum CodingKey: Swift.CodingKey {
            case ownerName
            case idCode
            case ownerSerial
            case status
            case ownerid
            case latitude
            case longitude
        }
        
        let values = try decoder.container(keyedBy: CodingKey.self)
        ownerName = try values.decode(String.self, forKey: .ownerName)
        ownerSerial = try values.decode(String.self, forKey: .ownerSerial)
        idCode = try values.decode(String.self, forKey: .idCode)
        ownerid = try values.decode(String.self, forKey: .ownerid)
        status = try values.decode(String.self, forKey: .status)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }
}

extension PlaceDefi: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { location.coordinate }
    var title: String? { idCode }
    //  var IDcode: String? { idCode }
}


final class PlaceDefiMove: NSObject, Decodable, Identifiable {
    let ownerName: String
    let idCode: String
    let ownerSerial: String
    let status: String
    let ownerid: String
    let eventTime: String
    let location: CLLocation
    private let regionRadius: CLLocationDistance = 1500 //MARK: TODO?
    let region: MKCoordinateRegion
    let id = UUID()
    
    init(from decoder: Decoder) throws {
        
        enum CodingKey: Swift.CodingKey {
            case ownerName
            case idCode
            case ownerSerial
            case status
            case ownerid
            case eventTime
            case latitude
            case longitude
        }
        
        let values = try decoder.container(keyedBy: CodingKey.self)
        ownerName = try values.decode(String.self, forKey: .ownerName)
        ownerSerial = try values.decode(String.self, forKey: .ownerSerial)
        eventTime = try values.decode(String.self, forKey: .eventTime)
        idCode = try values.decode(String.self, forKey: .idCode)
        ownerid = try values.decode(String.self, forKey: .ownerid)
        status = try values.decode(String.self, forKey: .status)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }
}

extension PlaceDefiMove: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { location.coordinate }
}

