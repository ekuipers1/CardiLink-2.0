//
//  GetData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.09.23.
//

import Foundation
import Alamofire
import SwiftyJSON

func ADActivation(){
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    let myDefibrillators = "activation/" //4500
    let serialnumber = defaults.string(forKey: "ADSerialNumber") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + serialnumber + "/start"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
            if let errorMessage = json["error"].string, errorMessage == "Activation Failed" {
                UserDefaults.standard.set("STOP", forKey: "ActivationError")
                
            } else {
                
                if let serialnumber = json["data"]["serial"].string {
                    let state = json["data"]["state"]
                    let stateText = json["data"]["stateText"]
                    let owner = json["data"]["id"]
                    
                    UserDefaults.standard.set("GO", forKey: "ActivationError")
                    UserDefaults.standard.set(json["data"]["serial"].string, forKey: "ADserial")
                    UserDefaults.standard.set(json["data"]["state"].int, forKey: "ADstate") //PageIndex
                    UserDefaults.standard.set(json["data"]["pageIndex"].int, forKey: "ADPageIndex")
                    UserDefaults.standard.set(json["data"]["stateText"].string, forKey: "ADstateText")
                    UserDefaults.standard.set(json["data"]["id"].stringValue, forKey: "ADIDStart")
                }
            }
        case .failure(let error):
            print(error)
            print("NOOOOOO NEW USER")
        }
    }
}
func ADActivationCheck(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    let myDefibrillators = "activation/"
    let serialnumber = defaults.string(forKey: "ADSerialNumber") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + serialnumber + "/check"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
            
            if let errorMessage = json["error"].string {
                UserDefaults.standard.set(0, forKey: "ADstate")
                UserDefaults.standard.set(json["data"]["stateText"].string, forKey: "ADstateText")
            } else {
            }
            
            if let serialnumber = json["data"]["serial"].string {
                let state = json["data"]["state"]
                let stateText = json["data"]["stateText"]
                let statePageCount = json["data"]["pageCount"]
                let owner = json["data"]["id"]
                let pageIndex = json["data"]["pageIndex"]
                
                UserDefaults.standard.set(json["data"]["serial"].string, forKey: "ADserial")
                UserDefaults.standard.set(json["data"]["state"].int, forKey: "ADstate")
                UserDefaults.standard.set(json["data"]["pageCount"].int, forKey: "ADPageCount")
                UserDefaults.standard.set(json["data"]["pageIndex"].int, forKey: "ADPageIndexCheck")
                UserDefaults.standard.set(json["data"]["stateText"].string, forKey: "ADstateText")
                UserDefaults.standard.set(json["data"]["id"].stringValue, forKey: "ADIDCheck")
            }
            
        case .failure(let error):
            print(error)
            UserDefaults.standard.set(0, forKey: "ADstate")
            
        }
    }
}
func getOutsideTheBuilding(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/"
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DeviceIsOutsideTheBuilding"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                UserDefaults.standard.set(dataValue, forKey: "AEDOutsideBuilding")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getInsideaCabinet(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/" //4500
    
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DeviceIsInsideACabinet"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                UserDefaults.standard.set(dataValue, forKey: "AEDIsInsideCabinet")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getNeedsPinToOpen(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/"
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DeviceCabinetIsEquippedWithPinLock"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                UserDefaults.standard.set(dataValue, forKey: "AEDisYesPinSelected")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getPinToOpen(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/"
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DevicePinlockKey"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? String {
                UserDefaults.standard.set(dataValue, forKey: "AEDcabinetPin")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getAddressInfo(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillatoraddress/" //4500
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? [String: Any] {
                
                if let address = dataValue["address"] as? [String: String] {
                    UserDefaults.standard.setValue(address["street"], forKey: "placemarkStreet")
                    UserDefaults.standard.setValue(address["houseNumber"], forKey: "placemarkStreetNumber")
                    UserDefaults.standard.setValue(address["postalCode"], forKey: "placemarkPostal")
                    UserDefaults.standard.setValue(address["city"], forKey: "placemarkCity")
                    UserDefaults.standard.setValue(address["country"], forKey: "placemarkCountry")
                    UserDefaults.standard.setValue(address["floorLevel"], forKey: "floorLevel")
                    UserDefaults.standard.setValue(address["comment"], forKey: "comments")
                }
                
                if let geoCoordinate = dataValue["geoCoordinate"] as? [String: Any] {
                    UserDefaults.standard.setValue(geoCoordinate["latitude"], forKey: "latitudeAdd")
                    UserDefaults.standard.setValue(geoCoordinate["longitude"], forKey: "longitudeAdd")
                }
                
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getADIspublicAvailable(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/" //4500
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DeviceIsPubliclyAccessible"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                UserDefaults.standard.set(dataValue, forKey: "aedisPubAvailable")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}
func getADIOkforShare(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/" //4500
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId") ?? "0000000000"
    let url_defi = myURL! + myDefibrillators + currentDefie + "/DeviceIsPubliclyPermitted"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                UserDefaults.standard.set(dataValue, forKey: "isOKforShare")
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}

