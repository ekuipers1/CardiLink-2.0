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
    
    if myBackend == "NEW" {
        
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
                        print(" ^^^^ NEWKEY:\(index) NEWVALUE:\(subJson)")
                        
                        //MARK: General
                        if let ownerid = subJson["defiId"].string {
                            print("defiId:",ownerid)
                            UserDefaults.standard.set(subJson["defiId"].stringValue, forKey: "harwareDefriID")
                            let harwareModel = subJson["model"].string
                            UserDefaults.standard.set(subJson["model"].stringValue, forKey: "harwareModel")
                            print("harwareModel:", harwareModel ?? "..")
                            
//                            let harwareOwnerName = subJson["ownerName"].string
//                            UserDefaults.standard.set(subJson["ownerName"].stringValue, forKey: "harwareModel")
//                            print("harwareModel:", harwareOwnerName ?? "..")
                            
                            
                            let languageSettings = subJson["languageSetting"].string
                            UserDefaults.standard.set(subJson["languageSetting"].stringValue, forKey: "harwareLanguage")
                            print("languageSetting:" ,languageSettings ?? "..")
                            let batchId = subJson["batchId"].string
                            
                            if batchId == "" {
                                
                                UserDefaults.standard.set("N/A", forKey: "hardwareBatchID")
                                print("batchId: N/A")
                            } else {
                            
                            UserDefaults.standard.set(subJson["batchId"].stringValue, forKey: "hardwareBatchID")
                            print("batchId:" ,batchId ?? "..")
                            }
                            let productionDate = subJson["productionDate"].int
                            print("productionDate:" ,productionDate ?? "..")
                            let activationDate = subJson["activationDate"].int
                            print("activationDate:" ,activationDate ?? "..")
                            
//TODO: FIX EMPTY DATE
                            if let prodfinalDate = subJson["productionDate"].int {
                                
                                let timeZone = TimeZone(abbreviation: "GMT")!
                                if timeZone.isDaylightSavingTime(for: Date()) {
                                    print("Yes, daylight saving time at a given date")
                                
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
                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
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
                                    print("Yes, daylight saving time at a given date")
                                
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
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "hardwareActicatonDate")
                                }
                            }
                            
                            
                            //MARK: PCBInformation
                            
                            let pcbInformation = subJson["pcbInformation"].dictionaryValue
                            for (key, value) in pcbInformation {
                                
                                if key == "manufacturer" {
                                    print("manufacturer: ", value)
                                    let myString = "\(value)"
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "manufacturerPCB")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "manufacturerPCB")
                                    }
                                }
                                if key == "firmwareVersion" {
                                    print("firmwareVersion: ", value)
                                    let myString = "\(value)"
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "firmwarePCB")
                                    }
                                }
                                if key == "hardwareVersion" {
                                    
                                    print("hardwareVersion: ", value)
                                    let myString = "\(value)"
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "hardwarePCB")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "hardwarePCB")
                                    }
                                    
                                }
                                //TODO: FIX EMPTY DATE
                                if key == "productionDate" {
                                    print("productionDate: ", value)
                                    let myString = "\(value)"
                                    let myInt: Int = Int(myString) ?? 0000
                                    print("productionDate: ", myInt)
                                    
                                    
                                    if myInt == 0 {
                                        UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
                                    } else {
                                    
                                    
                                    let pcbProdDate = myInt //myString.int
                                    
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
                                    print("serialNumber: ", value)
                                    let myString = "\(value)"
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "serialPCB")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "serialPCB")
                                    }
                                    
                                    
                                }
                                if key == "batchId" {
                                    print("batchId: ", value)
                                    let myString = "\(value)"
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "batchPCB")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "batchPCB")
                                    
                                }
                                }
                                
                                
                                //MARK: ElectrodesInformation
                                
                                let electrodesInformation = subJson["electrodesInformation"].dictionaryValue
                                for (key, value) in electrodesInformation {
                                    
                                    if key == "batchId" {
//                                        print("electrodesInformationbatchId: ", value)
                                        let myString = "\(value)"
                                        if myString == "null" || myString == ""{
                                            UserDefaults.standard.set("N/A", forKey: "batchElectrodes")
                                        } else {
                                        UserDefaults.standard.set(myString, forKey: "batchElectrodes")
                                        }
                                    }
                                    if key == "model" {
//                                        print("electrodesInformationmodel: ", value)
                                        let myString = "\(value)"
                                        if myString == "null" {
                                            UserDefaults.standard.set("N/A", forKey: "modelElectrodes")
                                        } else {
                                        UserDefaults.standard.set(myString, forKey: "modelElectrodes")
                                        }
                                        
                                    }
                                    if key == "expirationDate" {
//                                        print("electrodesInformationexpirationDate: ", value)

                                        let myString = "\(value)"
                                        let myInt: Int = Int(myString) ?? 0000
//                                        print("electrodesInformationexpirationDate: ", myInt)
                                        
                                        if myInt == 0 {
                                            UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                                        } else {
                                        
                                        let pcbProdDate = myInt
                                        
                                        let myInt1 = pcbProdDate//Int(value)
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
                                    print("expirationDate: ", value)
                                    let myString = "\(value)"
                                    let myInt: Int = Int(myString) ?? 0000
                                    print("expirationDate: ", myInt)
                                    
                                    if myInt == 0 {
                                        UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                                    } else {
                                    
                                    
                                    let pcbProdDate = myInt //myString.int
                                    
                                    let myInt1 = pcbProdDate//Int(value)
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
                                        UserDefaults.standard.set("N/A", forKey: "batteryLevel")
                                    } else {
                                    
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "batteryLevel")
                                    }
                                }
                                

                            }
                            
                            let macAddress = subJson["macAddress"].string
                            print("macAddress:" ,macAddress ?? "..")
                            UserDefaults.standard.set(subJson["macAddress"].stringValue, forKey: "addressBLE")
                            
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI HARDWAREDATA")
                    
                }
            }
        
        
    } else {
        
        
        
        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        baseUser = email!
        basePass = password!
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "defibrillators/"
        let theone =  selectedDefi ?? ""
        let hardware = "/hardware"
        let url = myURL! + comLink + theone + hardware
        
        print("gethardwaredata", url)
        let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
        let base64Credentials = credentialData.base64EncodedString()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
            .responseData {response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    for (index,subJson):(String, JSON) in json {
                        print("defi:\(index) 2:\(subJson)")
                    }
                    
                    if  let owner = json["@id"].string {
                        print("@id:" ,owner)
                        let harwareModel = json["model"].string
                        print("harwareModel:", harwareModel ?? "..")
                        let owner = json["@id"]
                        print("@id:" ,owner)
                        let description = json["description"]["en"].string
                        print("Description:", description ?? "..")
                        let languageSettings = json["languageSettings"].string
                        print("languageSettings:" ,languageSettings ?? "..")
                        let batchId = json["batchId"].string
                        print("batchId:" ,batchId ?? "..")
                        let productionDate = json["productionDate"].string
                        print("productionDate:" ,productionDate ?? "..")
                        let activationDate = json["activationDate"].string
                        print("activationDate:" ,activationDate ?? "..")
                        
                        let prodfinalDate = productionDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                        
                        let activationfinalDate = activationDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                        
                        UserDefaults.standard.set(json["model"].stringValue, forKey: "harwareModel")
                        UserDefaults.standard.set(json["@id"].stringValue, forKey: "harwareDefriID")
                        UserDefaults.standard.set(json["description"]["en"].string, forKey: "harwareDefriDescription")
                        UserDefaults.standard.set(json["languageSettings"].stringValue, forKey: "harwareLanguage")
                        UserDefaults.standard.set(json["batchId"].stringValue, forKey: "hardwareBatchID")
                        
                        UserDefaults.standard.set(prodfinalDate, forKey: "hardwareProddate")
                        UserDefaults.standard.set(activationfinalDate, forKey: "hardwareActicatonDate")
                        
                        
                        
                        let serialPCB = json["PCB"]["serialNumber"].string
                        print("serialPCB:", serialPCB ?? "..")
                        let batchPCB = json["PCB"]["batchId"].string
                        print("batchPCB:", batchPCB ?? "..")
                        let manufacturerPCB = json["PCB"]["manufacturer"].string
                        print("manufacturerPCB:", manufacturerPCB ?? "..")
                        let hardwarePCB = json["PCB"]["hardwareVersion"].string
                        print("hardwarePCB:", hardwarePCB ?? "..")
                        let firmwarePCB = json["PCB"]["firmwareVersion"].string
                        print("firmwarePCB:", firmwarePCB ?? "..")
                        let productionDatePCB = json["PCB"]["productionDate"].string
                        print("productionDatePCB:" ,productionDatePCB ?? "..")
                        
                        if productionDatePCB == nil {
                            UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
                            
                        } else {
                            
                            let prodfinalDatePCB = productionDatePCB?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(prodfinalDatePCB, forKey: "productionDatePCB")
                        }
                        
                        UserDefaults.standard.set(json["PCB"]["serialNumber"].stringValue, forKey: "serialPCB")
                        UserDefaults.standard.set(json["PCB"]["batchId"].stringValue, forKey: "batchPCB")
                        UserDefaults.standard.set(json["PCB"]["manufacturer"].string, forKey: "manufacturerPCB")
                        UserDefaults.standard.set(json["PCB"]["hardwareVersion"].stringValue, forKey: "hardwarePCB")
                        UserDefaults.standard.set(json["PCB"]["firmwareVersion"].stringValue, forKey: "firmwarePCB")
                        
                        let modelElectrodes = json["electrodes"]["model"].string
                        print("modelElectrodes:",modelElectrodes ?? "..")
                        let batchElectrodes = json["electrodes"]["batchId"].string
                        print("batchElectrodes:", batchElectrodes ?? "..")
                        let experationDateElectrodes = json["electrodes"]["expirationDate"].string
                        print("experationDateElectrodes:" ,experationDateElectrodes ?? "..")
                        
                        if experationDateElectrodes == nil {
                            UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                        } else {
                            let prodfinalDateBattery = experationDateElectrodes?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy")
                            UserDefaults.standard.set(prodfinalDateBattery, forKey: "experationDateElectrodes")
                        }
                        
                        UserDefaults.standard.set(json["electrodes"]["model"].stringValue, forKey: "modelElectrodes")
                        UserDefaults.standard.set(json["electrodes"]["batchId"].stringValue, forKey: "batchElectrodes")
                        
                        
                        let modelBattery = json["battery"]["model"].string
                        print("modelBattery:",modelBattery ?? "..")
                        let batchBattery = json["battery"]["batchId"].string
                        print("batchBattery:", batchBattery ?? "..")
                        let productionDateBattery = json["battery"]["activationDate"].string
                        print("productionDateBattery:" ,productionDateBattery ?? "..")
                        
                        if productionDateBattery == nil {
                            UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                        } else {
                            let prodfinalDateBattery = productionDateBattery?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(prodfinalDateBattery, forKey: "activationsDateBattery")
                        }
                        
                        UserDefaults.standard.set(json["battery"]["model"].stringValue, forKey: "modelBattery")
                        UserDefaults.standard.set(json["battery"]["batchId"].stringValue, forKey: "batchBattery")
                        
                        let addressBLE = json["bluetooth"]["MACAddress"].string
                        print("addressBLE:",addressBLE ?? "..")
                        
                        UserDefaults.standard.set(json["bluetooth"]["MACAddress"].stringValue, forKey: "addressBLE")
                        
                        let geoLocationLat = json["geoLocation"]["lat"].double
                        print("geoLocationLat:",geoLocationLat ?? 00.01)
                        let geoLocationLon = json["geoLocation"]["lng"].double
                        print("geoLocationLon:", geoLocationLon ?? 00.01)
                        
                        UserDefaults.standard.set(json["geoLocation"]["lat"].stringValue, forKey: "geoLocationLat")
                        UserDefaults.standard.set(json["geoLocation"]["lng"].stringValue, forKey: "geoLocationLon")
                        
                        let geoAddressStreet = json["address"]["street"].string
                        print("geoAddressStreet:",geoAddressStreet ?? "N/A")
                        let geoAddressNumber = json["address"]["houseNumber"].string
                        print("geoAddressNumber:", geoAddressNumber ?? "N/A")
                        
                        let geoAddressFloor = json["address"]["floorLevel"].string
                        print("geoAddressFloor:", geoAddressFloor ?? "N/A")
                        let geoAddressPostal = json["address"]["postalCode"].string
                        print("geoAddressPostal:", geoAddressPostal ?? "N/A")
                        
                        
                        let geoAddressCity = json["address"]["city"]["en"].string
                        print("geoAddressCity:", geoAddressCity ?? "N/A")
                        
                        UserDefaults.standard.set(json["address"]["street"].stringValue, forKey: "geoAddressStreet")
                        UserDefaults.standard.set(json["address"]["houseNumber"].stringValue, forKey: "geoAddressNumber")
                        
                        UserDefaults.standard.set(json["address"]["floorLevel"].stringValue, forKey: "geoAddressFloor")
                        UserDefaults.standard.set(json["address"]["postalCode"].stringValue, forKey: "geoAddressPostal")
                        
                        
                        UserDefaults.standard.set(json["address"]["country"].stringValue, forKey: "geoAddressCountry")
                        UserDefaults.standard.set(json["address"]["city"]["en"].stringValue, forKey: "geoAddressCity")
                        UserDefaults.standard.set(json["address"]["comment"]["en"].stringValue, forKey: "geoAddressComment")
                        
                        UserDefaults.standard.set(json["geoFence"]["type"].stringValue, forKey: "geoFenceType")
                        UserDefaults.standard.set(json["geoFence"]["radius"].stringValue, forKey: "geoFenceRadius")
                        
                    }
                    
                    print("YESSSSSSS")
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD DEO")
                    
                }
            }
    }
}
