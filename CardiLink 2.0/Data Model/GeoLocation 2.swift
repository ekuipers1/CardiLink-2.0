//
//  GeoLocation.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 06.10.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func getGeoLocationdata() {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone + "/homelocation"
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
    )
    
        .responseData {response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                for(_,subJson):(String, JSON) in json {
//                    print("NEWKEY:\(index) NEWVALUE:\(subJson)")
                    
                    //MARK: General
                    if let ownerid = subJson["defiId"].string {
                        print("defiId:",ownerid)
                        
                        //MARK: Address
                        let address = subJson["address"].dictionaryValue
                        for (key, value) in address {
                        
                            
                            if key == "street" {
                                print("street: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressStreet")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressStreet")
                                }
                            }
                        
                            if key == "houseNumber" {
                                print("houseNumber: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressNumber")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressNumber")
                                }
                            }
                            
                            if key == "floorLevel" {
                                print("floorLevel: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressFloor")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressFloor")
                                }
                            }

                        
                            if key == "postalCode" {
                                print("postalCode: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressPostal")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressPostal")
                                }
                            }

                            if key == "city" {
                                print("city: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressCity")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressCity")
                                }
                            }
                        
                            if key == "country" {
                                print("country: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressCountry")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressCountry")
                                }
                            }

                            if key == "comment" {
                                print("comment: ", value)
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "geoAddressComment")
                                } else {
                                UserDefaults.standard.set(myString, forKey: "geoAddressComment")
                                }
                            }
                            
                            //MARK: Geo Coordinate
                            if key == "geoCoordinate" {
                            for (key, value) in value {
                                
                                if key == "lat" {
                                    print("lat: ", value)
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "geoLocationLat")
                                }
                                
                                if key == "lon" {
                                    print("lon: ", value)
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "geoLocationLon")
                                }
                            }
                            
                            }
                        }
                        
                        //MARK: Geo Fence
                        let geoFence = subJson["geoFence"].dictionaryValue
                        for (key, value) in geoFence {
                            
                            if key == "radius" {
                                print("radius: ", value)
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "geoFenceRadius")
                            }
                            
                            if key == "type" {
                                print("type: ", value)
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "geoFenceType")
                            }
                            
                            
                            if key == "distance" {
                                print("distance: ", value)
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "distance")
                            }
                            
                            
                            if key == "distanceType" {
                                print("distanceType: ", value)
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "distanceType")
                            }
                        }
                    }
                        
                }
                                
            case .failure(let error):
                print(error)
                print("NOOOOOO NEW DEFI GEO")
            }
            print("GEOEMPTY")

        }
    
    
}
