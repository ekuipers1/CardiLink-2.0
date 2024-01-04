//
//  HardwareDataModel_Comm.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 06.10.21.
//

import Foundation
import Alamofire
import SwiftyJSON

func getCommhardwaredata() {
    
    let defaults = UserDefaults.standard
    let overview = defaults.string(forKey: "Overview")
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
                if let ownerid = subJson["commId"].string {
                    let baseinformation = subJson["baseinformation"].dictionaryValue
                    for (key, value) in baseinformation {
                        if key == "model" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commharwareModel")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commharwareModel")
                            }
                        }
                    }
                    
                    let pcbInformation = subJson["pcbinformation"].dictionaryValue
                    for (key, value) in pcbInformation {
                        
                        if key == "firmwareVersion" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commHardwarefirmwareVersion")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commHardwarefirmwareVersion")
                            }
                            
                        }
                        
                        if key == "batteryPercentage" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commHardwarebatteryPercentage")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commHardwarebatteryPercentage")
                            }
                            
                        }
                        
                        if key == "lot" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commHardwarelot")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commHardwarelot")
                            }
                            
                        }
                        
                    }
                    
                    let batteryInformation = subJson["internalChecks"].dictionaryValue
                    for (key, value) in batteryInformation {
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
            
        }
    }
}
func getCommhardwaredataOverview() {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
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
                if let ownerid = subJson["commId"].string {
                    let baseinformation = subJson["baseinformation"].dictionaryValue
                    for (key, value) in baseinformation {
                        
                        if key == "model" {
                            let myString = "\(value)"
                            
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commharwareModel")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commharwareModel")
                            }
                            
                        }
                    }
                    
                    let pcbInformation = subJson["pcbinformation"].dictionaryValue
                    for (key, value) in pcbInformation {
                        
                        if key == "firmwareVersion" {
                            let myString = "\(value)"
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commHardwarefirmwareVersion")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commHardwarefirmwareVersion")
                            }
                            
                        }
                        
                        if key == "batteryPercentage" {
                            let myString = "\(value)"
                            UserDefaults.standard.set(myString, forKey: "commHardwarebatteryPercentage")
                            
                        }
                        
                        if key == "lot" {
                            let myString = "\(value)"
                            
                            if myString == "null" {
                                UserDefaults.standard.set("N/A", forKey: "commHardwarelot")
                            } else {
                                UserDefaults.standard.set(myString, forKey: "commHardwarelot")
                            }
                        }
                    }
                    
                    let batteryInformation = subJson["internalChecks"].dictionaryValue
                    for (key, value) in batteryInformation {
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
            
        }
    }
    
}
