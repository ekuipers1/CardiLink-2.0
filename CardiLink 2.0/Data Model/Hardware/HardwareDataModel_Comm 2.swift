//
//  HardwareDataModel_Comm.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 06.10.21.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: COMM HARDWARE
func getCommhardwaredata() {
    
    let defaults = UserDefaults.standard
    let myBackend = defaults.string(forKey: "Backend")
    let overview = defaults.string(forKey: "Overview")
    
    if myBackend == "NEW" {
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        var selectedComm = defaults.string(forKey: "commdetailID")
        
        if overview == "YES" {
            
            selectedComm = defaults.string(forKey: "OVERVIEWCOMMID")
        }
        
        
        let myCommunicators = "communicators/"
        let url_defi = myURL! + myCommunicators
        let theone =  selectedComm ?? ""
        let url = url_defi + theone + "/Hardware"
        
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
                        print(" @@@@ NEWKEY:\(index) NEWVALUE:\(subJson)")
                        
                        //MARK: General
                        if let ownerid = subJson["commId"].string {
                            print("commId:",ownerid)
//                            UserDefaults.standard.set(subJson["commId"].stringValue, forKey: "harwareDefriID")
                            
                            
                            //MARK: BASE Information
                            let baseinformation = subJson["baseinformation"].dictionaryValue
                            for (key, value) in baseinformation {
                                
                                if key == "model" {
                                    print("model: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commharwareModel")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commharwareModel")
                                    }
                                    
                                }
                            }
                            
                            //MARK: PCBInformation
                            
                            let pcbInformation = subJson["pcbinformation"].dictionaryValue
                            for (key, value) in pcbInformation {
                                
                                                                if key == "firmwareVersion" {
                                                                    print("firmwareVersion: ", value)
                                                                    let myString = "\(value)"
                                                                    
                                                                    
                                                                    if myString == "null" {
                                                                        UserDefaults.standard.set("N/A", forKey: "commHardwarefirmwareVersion")
                                                                    } else {
                                                                    UserDefaults.standard.set(myString, forKey: "commHardwarefirmwareVersion")
                                                                    }
                                
                                                                }
                                
                                if key == "batteryPercentage" {
                                    print("batteryPercentage: ", value)
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "commHardwarebatteryPercentage")

                                }
                                
                                if key == "lot" {
                                    print("lot: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commHardwarelot")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commHardwarelot")
                                    }
                                    
                                }

                            }
                                                        
                            
                            //MARK: InternalChecks
                            let batteryInformation = subJson["internalChecks"].dictionaryValue
                            for (key, value) in batteryInformation {
                                
                                print(key, value)

                                if key == "bootupStatus" {
                                    let myString = "\(value)"
                                    
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbootupStatus")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbootupStatus")
                                    }
                                }
                                
                                if key == "bluetoothChipset" {

                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbluetoothChipset")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbluetoothChipset")
                                    }
                                }
                                
                                if key == "bluetoothMacAddress" {

                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbluetoothMacAddress")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbluetoothMacAddress")
                                    }
                                }
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI HARDWARE")
                    UserDefaults.standard.set("YES", forKey: "WaitForItOverview")
                    
                }
            }
        
        
    } else {
        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedComm = defaults.string(forKey: "commdetailID")
        
        baseUser = email!
        basePass = password!
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "communicators/"
        let theone =  selectedComm ?? ""
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
                        let commharwareModel = json["model"].string
                        print("CommharwareModel:", commharwareModel ?? "..")
                        let commowner = json["ownerId"]
                        print("ownerId" ,commowner)
                        let commdescription = json["description"]["en"].string
                        print("Description:", commdescription ?? "..")
                        
                        UserDefaults.standard.set(json["model"].stringValue, forKey: "commharwareModel")
                        
                        let commserialPCB = json["PCB"]["serialnumber"].string
                        print("commserialPCB:", commserialPCB ?? "..")
                        let commdeliveryDatePCB = json["PCB"]["deliveryDate"].string
                        print("commdeliveryDatePCB:" ,commdeliveryDatePCB ?? "..")
                        
                        UserDefaults.standard.set(json["PCB"]["serialnumber"].stringValue, forKey: "commserialPCB")
                        
                        
                        if commdeliveryDatePCB == nil {
                            UserDefaults.standard.set("N/A", forKey: "commfinaldeliveryDatePCB")
                            
                        } else {
                            
                            let commfinaldeliveryDatePCB = commdeliveryDatePCB?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commfinaldeliveryDatePCB, forKey: "commfinaldeliveryDatePCB")
                        }
                        
                        UserDefaults.standard.set(json["SIMCard"]["@id"].stringValue, forKey: "SIMCardid")
                        UserDefaults.standard.set(json["SIMCard"]["activationCode"].stringValue, forKey: "SIMCardactivationCode")
                        UserDefaults.standard.set(json["SIMCard"]["phoneNumber"].string, forKey: "SIMCardphoneNumber")
                        UserDefaults.standard.set(json["SIMCard"]["IPAddress"].stringValue, forKey: "SIMCardIPAddress")
                        
                        
                        let commBatteryBatch = json["battery"]["batch"].string
                        print("commBatteryBatch:",commBatteryBatch ?? "..")
                        let commBatteryVoltage = json["battery"]["voltage"].string
                        print("commBatteryVoltage:", commBatteryVoltage ?? "..")
                        let commBatteryDateBattery = json["battery"]["activationDate"].string
                        print("commBatteryDateBattery:" ,commBatteryDateBattery ?? "..")
                        if commBatteryDateBattery == nil {
                            UserDefaults.standard.set("N/A", forKey: "commactivationsDateBattery")
                        } else {
                            let commBatteryFinalDateBattery = commBatteryDateBattery?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commBatteryFinalDateBattery, forKey: "commactivationsDateBattery")
                        }
                        
                        UserDefaults.standard.set(json["battery"]["batch"].stringValue, forKey: "commBatteryBatch")
                        UserDefaults.standard.set(json["battery"]["voltage"].stringValue, forKey: "commBatteryVoltage")
                        
                        
                        let commassemblyDate = json["assemblyDate"].string
                        print("commassemblyDate:" ,commassemblyDate ?? "..")
                        
                        if commassemblyDate == nil {
                            UserDefaults.standard.set("N/A", forKey: "commassemblyDate")
                        } else {
                            let commassemblyFinalDate = commassemblyDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commassemblyFinalDate, forKey: "commassemblyDate")
                        }
                        
                        
                        let commactiveSince = json["activeSince"].string
                        print("commactiveSince:" ,commactiveSince ?? "..")
                        
                        if commactiveSince == nil {
                            UserDefaults.standard.set("N/A", forKey: "commactiveSince")
                        } else {
                            let commactiveFinalSince = commactiveSince?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commactiveFinalSince, forKey: "commactiveSince")
                        }
                        
                        let GPSAntennasAttached = json["GPSAntennasAttached"].boolValue
                        print("GPSAntennasAttached:" ,GPSAntennasAttached )
                        
                        UserDefaults.standard.set(json["GPSAntennasAttached"].boolValue, forKey: "GPSAntennasAttached")
                        
                    }
                    
                    print("YESSSSSSS")
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD HW")
                    
                }
            }
    }
}


func getCommhardwaredataOverview() {
    
    let defaults = UserDefaults.standard
    let myBackend = defaults.string(forKey: "Backend")
    
    if myBackend == "NEW" {
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
//        let selectedComm = defaults.string(forKey: "defridetailpairingID")
        let selectedComm = defaults.string(forKey: "defridetailpairingID")
        
        let myCommunicators = "communicators/"
        let url_defi = myURL! + myCommunicators
        let theone =  selectedComm ?? ""
        let url = url_defi + theone + "/Hardware"
        
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
                        print("NEWKEY:\(index) NEWVALUE:\(subJson)")
                        
                        //MARK: General
                        if let ownerid = subJson["commId"].string {
                            print("commId:",ownerid)
//                            UserDefaults.standard.set(subJson["commId"].stringValue, forKey: "harwareDefriID")
                            
                            
                            //MARK: BASE Information
                            let baseinformation = subJson["baseinformation"].dictionaryValue
                            for (key, value) in baseinformation {
                                
                                if key == "model" {
                                    print("model: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commharwareModel")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commharwareModel")
                                    }
                                    
                                }
                            }
                            
                            //MARK: PCBInformation
                            
                            let pcbInformation = subJson["pcbinformation"].dictionaryValue
                            for (key, value) in pcbInformation {
                                
                                                                if key == "firmwareVersion" {
                                                                    print("firmwareVersion: ", value)
                                                                    let myString = "\(value)"
                                                                    
                                                                    
                                                                    if myString == "null" {
                                                                        UserDefaults.standard.set("N/A", forKey: "commHardwarefirmwareVersion")
                                                                    } else {
                                                                    UserDefaults.standard.set(myString, forKey: "commHardwarefirmwareVersion")
                                                                    }
                                
                                                                }
                                
                                if key == "batteryPercentage" {
                                    print("batteryPercentage: ", value)
                                    let myString = "\(value)"
                                    UserDefaults.standard.set(myString, forKey: "commHardwarebatteryPercentage")

                                }
                                
                                if key == "lot" {
                                    print("lot: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commHardwarelot")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commHardwarelot")
                                    }
                                    
                                    
                                    
                                    

                                }

                            }
                                                        
                            
                            //MARK: InternalChecks
                            let batteryInformation = subJson["internalChecks"].dictionaryValue
                            for (key, value) in batteryInformation {
                                
                                print(key, value)

                                if key == "bootupStatus" {
                                    let myString = "\(value)"
                                    
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbootupStatus")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbootupStatus")
                                    }
                                }
                                
                                if key == "bluetoothChipset" {

                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbluetoothChipset")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbluetoothChipset")
                                    }
                                }
                                
                                if key == "bluetoothMacAddress" {

                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "commbluetoothMacAddress")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "commbluetoothMacAddress")
                                    }
                                }
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI HARDWAREOVER")
                    
                }
            }
        
        
    } else {
        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedComm = defaults.string(forKey: "commdetailID")
        
        baseUser = email!
        basePass = password!
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "communicators/"
        let theone =  selectedComm ?? ""
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
                        let commharwareModel = json["model"].string
                        print("CommharwareModel:", commharwareModel ?? "..")
                        let commowner = json["ownerId"]
                        print("ownerId" ,commowner)
                        let commdescription = json["description"]["en"].string
                        print("Description:", commdescription ?? "..")
                        
                        UserDefaults.standard.set(json["model"].stringValue, forKey: "commharwareModel")
                        
                        let commserialPCB = json["PCB"]["serialnumber"].string
                        print("commserialPCB:", commserialPCB ?? "..")
                        let commdeliveryDatePCB = json["PCB"]["deliveryDate"].string
                        print("commdeliveryDatePCB:" ,commdeliveryDatePCB ?? "..")
                        
                        UserDefaults.standard.set(json["PCB"]["serialnumber"].stringValue, forKey: "commserialPCB")
                        
                        
                        if commdeliveryDatePCB == nil {
                            UserDefaults.standard.set("N/A", forKey: "commfinaldeliveryDatePCB")
                            
                        } else {
                            
                            let commfinaldeliveryDatePCB = commdeliveryDatePCB?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commfinaldeliveryDatePCB, forKey: "commfinaldeliveryDatePCB")
                        }
                        
                        UserDefaults.standard.set(json["SIMCard"]["@id"].stringValue, forKey: "SIMCardid")
                        UserDefaults.standard.set(json["SIMCard"]["activationCode"].stringValue, forKey: "SIMCardactivationCode")
                        UserDefaults.standard.set(json["SIMCard"]["phoneNumber"].string, forKey: "SIMCardphoneNumber")
                        UserDefaults.standard.set(json["SIMCard"]["IPAddress"].stringValue, forKey: "SIMCardIPAddress")
                        
                        
                        let commBatteryBatch = json["battery"]["batch"].string
                        print("commBatteryBatch:",commBatteryBatch ?? "..")
                        let commBatteryVoltage = json["battery"]["voltage"].string
                        print("commBatteryVoltage:", commBatteryVoltage ?? "..")
                        let commBatteryDateBattery = json["battery"]["activationDate"].string
                        print("commBatteryDateBattery:" ,commBatteryDateBattery ?? "..")
                        if commBatteryDateBattery == nil {
                            UserDefaults.standard.set("N/A", forKey: "commactivationsDateBattery")
                        } else {
                            let commBatteryFinalDateBattery = commBatteryDateBattery?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commBatteryFinalDateBattery, forKey: "commactivationsDateBattery")
                        }
                        
                        UserDefaults.standard.set(json["battery"]["batch"].stringValue, forKey: "commBatteryBatch")
                        UserDefaults.standard.set(json["battery"]["voltage"].stringValue, forKey: "commBatteryVoltage")
                        
                        
                        let commassemblyDate = json["assemblyDate"].string
                        print("commassemblyDate:" ,commassemblyDate ?? "..")
                        
                        if commassemblyDate == nil {
                            UserDefaults.standard.set("N/A", forKey: "commassemblyDate")
                        } else {
                            let commassemblyFinalDate = commassemblyDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commassemblyFinalDate, forKey: "commassemblyDate")
                        }
                        
                        
                        let commactiveSince = json["activeSince"].string
                        print("commactiveSince:" ,commactiveSince ?? "..")
                        
                        if commactiveSince == nil {
                            UserDefaults.standard.set("N/A", forKey: "commactiveSince")
                        } else {
                            let commactiveFinalSince = commactiveSince?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            UserDefaults.standard.set(commactiveFinalSince, forKey: "commactiveSince")
                        }
                        
                        let GPSAntennasAttached = json["GPSAntennasAttached"].boolValue
                        print("GPSAntennasAttached:" ,GPSAntennasAttached )
                        
                        UserDefaults.standard.set(json["GPSAntennasAttached"].boolValue, forKey: "GPSAntennasAttached")
                        
                    }
                    
                    print("YESSSSSSS")
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD HW")
                    
                }
            }
    }
}
