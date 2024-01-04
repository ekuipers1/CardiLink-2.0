//
//  SIMDataModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func getSIMcardDataOverview() {
    
    let defaults = UserDefaults.standard
    let myBackend = defaults.string(forKey: "Backend")
    let overview = defaults.string(forKey: "Overview")
    
    if myBackend == "NEW" {
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        var selectedComm = defaults.string(forKey: "defridetailpairingID")
        
        if overview == "YES" {
            
            selectedComm = defaults.string(forKey: "OVERVIEWCOMMID")
        }
        
        
        
        let myCommunicators = "communicators/"
        let url_defi = myURL! + myCommunicators
        let theone =  selectedComm ?? ""
        let url = url_defi + theone + "/Sim"
        
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
                        print("SIMcNEWKEY:\(index) SIMcNEWVALUE:\(subJson)")
                        
                        //MARK: General
                        if let ownerid = subJson["commId"].string {
                            print("SIMcommId:",ownerid)
                            //                            UserDefaults.standard.set(subJson["commId"].stringValue, forKey: "harwareDefriID")
                            
                            
                            //                            //MARK: BASE Information
                            //                            let baseinformation = subJson["baseinformation"].dictionaryValue
                            //                            for (key, value) in baseinformation {
                            //
                            //                                if key == "model" {
                            //                                    print("model: ", value)
                            //                                    let myString = "\(value)"
                            //                                    UserDefaults.standard.set(myString, forKey: "commharwareModel")
                            //
                            //                                }
                            //                            }
                            
                            //MARK: PCBInformation
                            
                            let pcbInformation = subJson["simInformation"].dictionaryValue
                            for (key, value) in pcbInformation {
                                
                                if key == "serial" {
                                    print("Simserial: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMserial")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMserial")
                                    }
                                }
                                
                                if key == "id" {
                                    print("id: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMid")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMid")
                                    }
                                }
                                
                                if key == "operator" {
                                    print("operator: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMoperator")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMoperator")
                                    }
                                }
                                
                                if key == "countryCode" {
                                    print("countryCode: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMcountryCode")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMcountryCode")
                                    }
                                }
                                
                                if key == "networkCode" {
                                    print("networkCode: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMnetworkCode")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMnetworkCode")
                                    }
                                }
                                
                                if key == "signalStrength" {
                                    print("signalStrength: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMsignalStrength")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMsignalStrength")
                                    }
                                }
                                
                                if key == "signalQuality" {
                                    print("signalQuality: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMsignalQuality")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMsignalQuality")
                                    }
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI SIM")
                    
                }
            }
    }
}


func getSIMcardData() {
    
    let defaults = UserDefaults.standard
    let myBackend = defaults.string(forKey: "Backend")
    
    if myBackend == "NEW" {
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        var selectedComm = defaults.string(forKey: "commdetailID")
        
        if selectedComm == "" {
            
//            selectedComm = defaults.string(forKey: "defridetailpairingID")
            selectedComm = defaults.string(forKey: "defidetailpairingSerial")
        }
        
        
        let myCommunicators = "communicators/"
        let url_defi = myURL! + myCommunicators
        let theone =  selectedComm ?? ""
        let url = url_defi + theone + "/Sim"
        
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
                        print(" !!!! NEWKEY:\(index) NEWVALUE:\(subJson)")
                        
                        //MARK: General
                        if let ownerid = subJson["commId"].string {
                            print("commId:",ownerid)
                            //                            UserDefaults.standard.set(subJson["commId"].stringValue, forKey: "harwareDefriID")
                            
                            
                            //                            //MARK: BASE Information
                            //                            let baseinformation = subJson["baseinformation"].dictionaryValue
                            //                            for (key, value) in baseinformation {
                            //
                            //                                if key == "model" {
                            //                                    print("model: ", value)
                            //                                    let myString = "\(value)"
                            //                                    UserDefaults.standard.set(myString, forKey: "commharwareModel")
                            //
                            //                                }
                            //                            }
                            
                            //MARK: PCBInformation
                            
                            let pcbInformation = subJson["simInformation"].dictionaryValue
                            for (key, value) in pcbInformation {
                                
                                if key == "serial" {
                                    print("Simserial: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMserial")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMserial")
                                    }
                                }
                                
                                if key == "id" {
                                    print("id: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMid")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMid")
                                    }
                                }
                                
                                if key == "operator" {
                                    print("operator: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMoperator")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMoperator")
                                    }
                                }
                                
                                if key == "countryCode" {
                                    print("countryCode: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMcountryCode")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMcountryCode")
                                    }
                                }
                                
                                if key == "networkCode" {
                                    print("networkCode: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMnetworkCode")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMnetworkCode")
                                    }
                                }
                                
                                if key == "signalStrength" {
                                    print("signalStrength: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMsignalStrength")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMsignalStrength")
                                    }
                                }
                                
                                if key == "signalQuality" {
                                    print("signalQuality: ", value)
                                    let myString = "\(value)"
                                    
                                    if myString == "null" {
                                        UserDefaults.standard.set("N/A", forKey: "SIMsignalQuality")
                                    } else {
                                    UserDefaults.standard.set(myString, forKey: "SIMsignalQuality")
                                    }
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI DE")
                    
                }
            }
    }
}


//MARK: COMM SIM OLD
func getCommSimdata() {
    
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
    let hardware = "/SIMCard"
    let url = myURL! + comLink + theone + hardware
    
    print("SIMCard", url)
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
            
            //            for (index,subJson):(String, JSON) in json {
            //                print("defi:\(index) 2:\(subJson)")
            //            }
            
            
            
            UserDefaults.standard.set(json["SIMCard"]["@id"].stringValue, forKey: "SIMCardid")
            UserDefaults.standard.set(json["SIMCard"]["activationCode"].stringValue, forKey: "SIMCardactivationCode")
            
            let commdeliveryDateSIM = json["SIMCard"]["activationDate"].string
            print("commdeliveryDateSIM:" ,commdeliveryDateSIM ?? "..")
            
            if commdeliveryDateSIM == nil {
                UserDefaults.standard.set("N/A", forKey: "SIMCarddeliveryDateSIM")
                
            } else {
                
                let commfinaldeliveryDateSIM = commdeliveryDateSIM?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                UserDefaults.standard.set(commfinaldeliveryDateSIM, forKey: "SIMCarddeliveryDateSIM")
            }
            
            
            
            print("YESSSSSSS")
            getCommSimStatus()
        case .failure(let error):
            print(error)
            print("NOOOOOO OLD SIM")
            
        }
    }
}
