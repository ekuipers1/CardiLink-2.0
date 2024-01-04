//
//  HardwareDataModel_Defi.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 27.09.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func gethardwaredata() {
    
    let defaults = UserDefaults.standard
    let myBackend = defaults.string(forKey: "Backend")
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone + "/hardware"
    
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
            for(index,subJson):(String, JSON) in json {
                
                if let ownerid = subJson["defiId"].string {
                    UserDefaults.standard.set(subJson["defiId"].stringValue, forKey: "harwareDefriID")
                    let harwareModel = subJson["model"].string
                    UserDefaults.standard.set(subJson["model"].stringValue, forKey: "harwareModel")
                    let languageSettings = subJson["languageSetting"].string
                    UserDefaults.standard.set(subJson["languageSetting"].stringValue, forKey: "harwareLanguage")
                    let batchId = subJson["batchId"].string
                    if batchId == "" {
                        UserDefaults.standard.set("N/A", forKey: "hardwareBatchID")
                    } else {
                        UserDefaults.standard.set(subJson["batchId"].stringValue, forKey: "hardwareBatchID")
                    }
                    let productionDate = subJson["productionDate"].int
                    let activationDate = subJson["activationDate"].int
                    if let prodfinalDate = subJson["productionDate"].int {
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myInt1 = Int(prodfinalDate)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "hardwareProddate")
                        } else {
                            let myInt1 = Int(prodfinalDate)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "hardwareProddate")
                        }
                    } else {
                        UserDefaults.standard.set("null", forKey: "hardwareProddate")
                    }
                    if let activationfinalDate = subJson["activationDate"].int {
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myInt1 = Int(activationfinalDate)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "hardwareActicatonDate")
                            
                        } else {
                            
                            let myInt1 = Int(activationfinalDate)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "hardwareActicatonDate")
                        }
                    }
                    
                    let pcbInformation = subJson["pcbInformation"].dictionaryValue
                    for (key, value) in pcbInformation {
                        
                        if key == "manufacturer" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "manufacturerPCB")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "manufacturerPCB")
                            }
                        }
                        if key == "firmwareVersion" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "firmwarePCB")
                            }
                        }
                        if key == "hardwareVersion" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "hardwarePCB")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "hardwarePCB")
                            }
                            
                        }
                        if key == "productionDate" {
                            let myString = "\(value)"
                            let myInt: Int = Int(myString) ?? 0000
                            if myInt == 0 {
                                UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
                            } else {
                                
                                let pcbProdDate = myInt
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "productionDatePCB")
                            }
                        }
                        if key == "serialNumber" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "serialPCB")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "serialPCB")
                            }
                            
                            
                        }
                        if key == "batchId" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "batchPCB")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "batchPCB")
                                
                            }
                        }
                        
                        let electrodesInformation = subJson["electrodesInformation"].dictionaryValue
                        for (key, value) in electrodesInformation {
                            
                            if key == "batchId" {
                                let myString = "\(value)"
                                if myString == "null" || myString == ""{
                                    UserDefaults.standard.set("N/A", forKey: "batchElectrodes")
                                } else {
                                    UserDefaults.standard.set(myString, forKey: "batchElectrodes")
                                }
                            }
                            if key == "model" {
                                let myString = "\(value)"
                                if myString == "null" {
                                    UserDefaults.standard.set("N/A", forKey: "modelElectrodes")
                                } else {
                                    UserDefaults.standard.set(myString, forKey: "modelElectrodes")
                                }
                                
                            }
                            if key == "expirationDate" {
                                let myString = "\(value)"
                                let myInt: Int = Int(myString) ?? 0000
                                if myInt == 0 {
                                    UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                                } else {
                                    
                                    let pcbProdDate = myInt
                                    let myInt1 = pcbProdDate
                                    let unixTimestamp = myInt1
                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                    dateFormatter.locale = NSLocale.current
                                    dateFormatter.dateFormat = "MMM d, yyyy"
                                    let strDate = dateFormatter.string(from: date)
                                    
                                    UserDefaults.standard.set(strDate, forKey: "experationDateElectrodes")
                                }
                            }
                        }
                    }
                    
                    
                    //MARK: Battery
                    let batteryInformation = subJson["batteryInformation"].dictionaryValue
                    for (key, value) in batteryInformation {
                        
                        if key == "expirationDate" {
                            let myString = "\(value)"
                            let myInt: Int = Int(myString) ?? 0000
                            if myInt == 0 {
                                UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                            } else {
                                
                                let pcbProdDate = myInt
                                let myInt1 = pcbProdDate
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "activationsDateBattery")
                            }
                        }
                        if key == "model" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "modelBattery")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "modelBattery")
                            }
                        }
                        
                        if key == "serialNumber" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "serialNumberBattery")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "serialNumberBattery")
                            }
                        }
                        
                        if key == "lotNumber" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "lotNumber")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "lotNumber")
                            }
                        }
                        
                        if key == "batteryLevel" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("0", forKey: "batteryLevel")
                            } else {
                                
                                let myString = "\(value)"
                                UserDefaults.standard.set(myString, forKey: "batteryLevel")
                            }
                        }
                        
                        
                    }
                    
                    let macAddress = subJson["macAddress"].string
                    UserDefaults.standard.set(subJson["macAddress"].stringValue, forKey: "addressBLE")
                }
            }
        case .failure(let error):
            print(error)
            
        }
    }
    
}
