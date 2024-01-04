//
//  CommGetsingleData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 05.03.21.
//

import Foundation
import Alamofire
import SwiftyJSON

func CommGetsingleData() {
    
    let defaults = UserDefaults.standard
    let email = defaults.string(forKey: "username")
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    var selectedComm = defaults.string(forKey: "SelectedComm")
    if selectedComm == "" {
        selectedComm = defaults.string(forKey: "defridetailpairingID")
    }
    let myDefibrillators = "communicators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedComm ?? ""
    let url = url_defi + theone
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
                if let ownerid = subJson["ownerId"].string {
                    UserDefaults.standard.set(ownerid, forKey: "commdetailOwner")
                    let commId = subJson["commId"].stringValue
                    UserDefaults.standard.set(commId, forKey: "commdetailID")
                    let commSerialId = subJson["serial"].stringValue
                    UserDefaults.standard.set(commSerialId, forKey: "commdetailSerial")
                    let description = subJson["description"].string
                    UserDefaults.standard.set(description, forKey: "commdetailDescription")
                    let ownerName = subJson["ownerName"].string
                    UserDefaults.standard.set(ownerName, forKey: "commdetailOwnername")
                    let status = subJson["status"].dictionaryValue
                    for (key, value) in status {
                        if key == "date" {
                        }
                        if key == "status" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailStatusValue")
                        }
                    }
                    let initialBootupDate = subJson["initialBootupDate"].stringValue
                    let myString = "\(initialBootupDate)"
                    let myInt: Int = Int(myString) ?? 0000
                    let pcbProdDate = myInt
                    let myInt1 = pcbProdDate
                    let unixTimestamp = myInt1
                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    dateFormatter.locale = NSLocale.current
                    dateFormatter.dateFormat = "MMM d, yyyy"
                    let strDate = dateFormatter.string(from: date)
                    UserDefaults.standard.set(strDate, forKey: "initialBootupDate")
                    let pairedDefibrillator = subJson["pairedDefribrillator"].dictionaryValue
                    for (key, value) in pairedDefibrillator {
                        if key == "defibrillatorId" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingID")
                        }
                        if key == "deribrillatorSerial" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingSerial")
                        }
                        if key == "pairingDate" {
                            let myString = "\(value)"
                            let myInt: Int = Int(myString) ?? 0000
                            let pcbProdDate = myInt
                            let timeZone = TimeZone(abbreviation: "GMT")!
                            if timeZone.isDaylightSavingTime(for: Date()) {
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                
                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            } else {
                                
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 3600))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            }
                        }
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
    }

}
func CommGetsingleDataOverview() {
    
    let defaults = UserDefaults.standard
    let email = defaults.string(forKey: "username")
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedComm = defaults.string(forKey: "OVERVIEWCOMMID")
    let myDefibrillators = "communicators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedComm ?? ""
    let url = url_defi + theone
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
                if let ownerid = subJson["ownerId"].string {
                    UserDefaults.standard.set(ownerid, forKey: "commdetailOwner")
                    let commId = subJson["commId"].stringValue
                    UserDefaults.standard.set(commId, forKey: "commdetailID")
                    let commSerialId = subJson["serial"].stringValue
                    UserDefaults.standard.set(commSerialId, forKey: "commdetailSerial")
                    let description = subJson["description"].string
                    UserDefaults.standard.set(description, forKey: "commdetailDescription")
                    let ownerName = subJson["ownerName"].string
                    UserDefaults.standard.set(ownerName, forKey: "commdetailOwnername")
                    
                    let status = subJson["status"].dictionaryValue
                    for (key, value) in status {
                        if key == "date" {
                        }
                        if key == "status" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailStatusValue")
                        }
                    }
                    
                    let initialBootupDate = subJson["initialBootupDate"].stringValue
                    let myString = "\(initialBootupDate)"
                    let myInt: Int = Int(myString) ?? 0000
                    let pcbProdDate = myInt
                    let myInt1 = pcbProdDate
                    let unixTimestamp = myInt1
                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    dateFormatter.locale = NSLocale.current
                    dateFormatter.dateFormat = "MMM d, yyyy"
                    let strDate = dateFormatter.string(from: date)
                    
                    UserDefaults.standard.set(strDate, forKey: "initialBootupDate")
                    
                    let pairedDefibrillator = subJson["pairedDefribrillator"].dictionaryValue
                    for (key, value) in pairedDefibrillator {
                        
                        if key == "defibrillatorId" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingID")
                        }
                        
                        if key == "deribrillatorSerial" {
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingSerial")
                        }
                        
                        if key == "pairingDate" {
                            
                            let myString = "\(value)"
                            let myInt: Int = Int(myString) ?? 0000
                            let pcbProdDate = myInt
                            let timeZone = TimeZone(abbreviation: "GMT")!
                            if timeZone.isDaylightSavingTime(for: Date()) {
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            } else {
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 3600))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            }
                        }
                    }
                    
                }
                
            }
        case .failure(let error):
            print(error)
        }
    }
    
}
