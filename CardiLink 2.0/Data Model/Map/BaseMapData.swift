//
//  BaseMapData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.05.23.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

struct DefibrillatorResponse: Codable {
    let success: Bool
    let data: [DefibrillatorMap]
    let count: Int
}
struct DefibrillatorMap: Codable, Identifiable {
    let id = UUID()
    let defiId: String
    let serial: String?
    let ownerId: String
    let ownerName: String?
    let description: String?
    let lat: Double
    let lon: Double
    let dashboardState: Int
    let adminStatus: Int
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
func fetchDefibrillatorsGPS(completion: @escaping (DefibrillatorResponse?) -> Void) {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators?GpsIsAvailable=True&PageSize=2500"
    let url_defi = myURL! + myDefibrillators
    
    let headers: HTTPHeaders = [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
    
    AF.request(url_defi, headers: headers).responseDecodable(of: DefibrillatorResponse.self) { response in
        switch response.result {
        case .success(let defibrillators):
            completion(defibrillators)
        case .failure(let error):
            print(error)
            completion(nil)
        }
    }
}

