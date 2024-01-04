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
    let backend = defaults.string(forKey: "Backend")
    
    if backend == "NEW" {
    
        var baseUser = ""
        print("Backend: ", backend!)
        
        let email = defaults.string(forKey: "DataUIDUser")
        
        
        baseUser = email!
        print(baseUser)
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        var selectedComm = defaults.string(forKey: "SelectedComm")
        
        if selectedComm == "" {
            
            selectedComm = defaults.string(forKey: "defridetailpairingID")
        }
        
//        UserDefaults.standard.set(value.string, forKey: "")
//        defridetailpairingID
        
        
        let myDefibrillators = "communicators/"
        let url_defi = myURL! + myDefibrillators
        let theone =  selectedComm ?? ""
        let url = url_defi + theone
//        let url = myUser + baseUser
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
    //        "Authorization": "Basic \(base64Credentials)",
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
//                    print("defi:\(index) 2:\(subJson)")

                    if let ownerid = subJson["ownerId"].string {
                    print("commOwnerid_N:",ownerid)
                    UserDefaults.standard.set(ownerid, forKey: "commdetailOwner")
                    let commId = subJson["commId"].stringValue
                    print("commId_N:",commId)
                    UserDefaults.standard.set(commId, forKey: "commdetailID")
                        
                    let commSerialId = subJson["serial"].stringValue
                        print("DefiId_SN:",commSerialId)
                        UserDefaults.standard.set(commSerialId, forKey: "commdetailSerial")
                    let description = subJson["description"].string
                        UserDefaults.standard.set(description, forKey: "commdetailDescription")
                    let ownerName = subJson["ownerName"].string
                            UserDefaults.standard.set(ownerName, forKey: "commdetailOwnername")
                   
                        let status = subJson["status"].dictionaryValue
                        for (key, value) in status {
                            
                            if key == "date" {
                                
                                print("Date: ", value)
                            }
                            
                            if key == "status" {
                                
                                print("Status: ", value)

                                UserDefaults.standard.set(value.string, forKey: "commdetailStatusValue")
                            }
                        }
                        
                        let initialBootupDate = subJson["initialBootupDate"].stringValue
//                        if key == "initialBootupDate" {
                            
                            print("Initial Bootup Date:", initialBootupDate)
                            let myString = "\(initialBootupDate)"
                            let myInt: Int = Int(myString) ?? 0000
//                            print("Initial Bootup Date: ", myInt)
                            
                            let pcbProdDate = myInt //myString.int
                            
                            let myInt1 = pcbProdDate//Int(value)
                            
//                                print("Pairing Date: ", value)

                            let unixTimestamp = myInt1 //value.int!
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy" //yyyy-MM-dd HH:mm" //Specify your format that you want
                            let strDate = dateFormatter.string(from: date)
                            
                            print("Initial Bootup Date:", strDate)

                            UserDefaults.standard.set(strDate, forKey: "initialBootupDate")
//                        }
                        
                        
                        
//                        let adminStatus = subJson["adminStatus"].dictionaryValue
//                        for (key, value) in adminStatus {
//
//                            if key == "date" {
//
//                                print("Date: ", value)
//                            }
//
//                            if key == "status" {
//
//                                print("Status: ", value)
//
//                                UserDefaults.standard.set(value.string, forKey: "commdetailAdminStatusValue")
//
//                                let whatStatusImage = value
//
//                                switch whatStatusImage {
//                                case "Operational":
//                                    UserDefaults.standard.set("comms_green", forKey: "commstatusImage")
//
//                                case "Defective":
//                                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
//
//                                case "Disabled":
//                                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
//
//                                default:
//                                    UserDefaults.standard.set("Comms", forKey: "commstatusImage")
//                                }
//                            }
//                        }
                        

                        let pairedDefibrillator = subJson["pairedDefribrillator"].dictionaryValue
                        for (key, value) in pairedDefibrillator {
                            
                            if key == "defibrillatorId" {
                                
                                print("Defibrillator Id: ", value)
                                
                                UserDefaults.standard.set(value.string, forKey: "commdetailpairingID")
                            }
                            
                            if key == "deribrillatorSerial" {
                                
                                print("Defibrillator Serial: ", value)
                                
                                UserDefaults.standard.set(value.string, forKey: "commdetailpairingSerial")
                            }
                            
                            
                            
                            
                            if key == "pairingDate" {
                                
                                print("Pairing Date: ", value)
                                let myString = "\(value)"
                                let myInt: Int = Int(myString) ?? 0000
                                print("Pairing Date: ", myInt)
                                
                                let pcbProdDate = myInt //myString.int
                                
                                let timeZone = TimeZone(abbreviation: "GMT")!
                                if timeZone.isDaylightSavingTime(for: Date()) {
                                let myInt1 = pcbProdDate//Int(value)
                                let unixTimestamp = myInt1 //value.int!
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //yyyy-MM-dd HH:mm" //Specify your format that you want
                                let strDate = dateFormatter.string(from: date)
                                
                                print("StatusDate:", strDate)

                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                                } else {
                                    
                                    let myInt1 = pcbProdDate//Int(value)
                                    let unixTimestamp = myInt1 //value.int!
                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                    dateFormatter.locale = NSLocale.current
                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //yyyy-MM-dd HH:mm" //Specify your format that you want
                                    let strDate = dateFormatter.string(from: date)
                                    
                                    print("StatusDate:", strDate)

                                    UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                                }
                            }
                        }
                        
                    }
                    
                }
            case .failure(let error):
                print(error)
                print("NOOOOOO NEW COM DE")
                
            }
    
    
        }
    
    
    
    
    
    
    
    
    } else {
    
    
    
    var baseUser = ""
    var basePass = ""
    
    let email = defaults.string(forKey: "DataUIDUser")
    let password = defaults.string(forKey: "DataPWDUser")
    let selectedComm = defaults.string(forKey: "SelectedComm")
    
    
    baseUser = email!
    basePass = password!
    
    let myURL = defaults.string(forKey: "myPortal")
    let comLink = "communicators/"
    let theone =  selectedComm ?? ""
    let url = myURL! + comLink + theone
    
    
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
                
                
                if let description4 = json["pairedDefibrillators"].arrayObject {
//                    print("WW", description4)
//                    print("WW", description4.count)
                    for obj in description4 {
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            let id = dict.value(forKey: "defibrillatorId")
                            let pair = dict.value(forKey: "pairingDate")
//                            let idstring = dict.value(forKey: "commdetailpairingSerial")
                            print("defibrillatorId", id ?? ".." , "pairingDate", pair ?? ".." )
                            UserDefaults.standard.set(id, forKey: "commdetailpairingID")
                            UserDefaults.standard.set(pair, forKey: "commdetailpairingDate")
//                            UserDefaults.standard.set(idstring, forKey: "commdetailpairingSerial")

                        }
                    }
                    
                } else {
                    
                    let defibrillatorId =  json["pairedDefibrillators"].arrayValue.map {$0["defibrillatorId"].stringValue}
                    print("Defibrillator Id:", defibrillatorId as Any)
                    //org
                    if defibrillatorId == []  {
                        print("EMPTY")
                        UserDefaults.standard.set("N/A", forKey: "commdetailpairingID")
                    } else {
                        UserDefaults.standard.set(defibrillatorId[0], forKey: "commdetailpairingID")
                    }
                    
                    let pairingDateDefi =  json["pairedDefibrillators"].arrayValue.map {$0["pairingDate"].string}
                    print("Pairing Date Defi:", pairingDateDefi as Any)
                    
                    if pairingDateDefi == []  {
                        UserDefaults.standard.set("N/A", forKey: "commdetailpairingDate")
                        print("EMPTY")
                    } else {
                        
                        let z1eroKey = pairingDateDefi[0]
                        print("Defi Date:\(z1eroKey ?? "..")")
                        let zerofinalDate = z1eroKey?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                        print("0 Defi Date:\(zerofinalDate ?? "..")")
                        UserDefaults.standard.set(zerofinalDate, forKey: "commdetailpairingDate")
                    }
                    
                }
                
            }
            
            if let ownerid = json["ownerId"].string {
                print("Ownerid:",ownerid)
                let owner = json["@id"]
                print("@id:" ,owner)
                let description = json["description"]["en"].string
                print("Description:", description ?? "..")
                
                let status = json["status"].dictionaryValue
                print("Status:",status as Any)
                
                let sorted = status.sorted(by: { $0.key > $1.key })
                print("Status 2:",sorted as Any)
                
                
                let firstKey =  Array(arrayLiteral: sorted[0])[0].key
                print("Current Status Date:\(firstKey)")
                let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                print("Current Status Status:\(firstValue)")
                
                let whatStatusImage = firstValue
                
                switch whatStatusImage {
                case "paired":
                    UserDefaults.standard.set("comms_green", forKey: "commstatusImage")
                    
                case "overdue":
                    UserDefaults.standard.set("comms_orange", forKey: "commstatusImage")
                    
                case "warning":
                    UserDefaults.standard.set("comms_orange", forKey: "commstatusImage")
                    
                case "preError":
                    UserDefaults.standard.set("comms_orange", forKey: "commstatusImage")
                    
                case "unknown":
                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
                    
                case "timeout":
                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
                    
                default:
                    UserDefaults.standard.set("Comms", forKey: "commstatusImage")
                }
                
                let adminStatus = json["adminStatus"].dictionaryValue
                print("Status:",adminStatus as Any)
                
                let adminsorted = adminStatus.sorted(by: { $0.key > $1.key })
                print("AdminStatus Sorted:",adminsorted as Any)
                let adminfirstKey =  Array(arrayLiteral: adminsorted[0])[0].key
                print("Admin Status Date:\(adminfirstKey)")
                let adminfirstValue =  Array(arrayLiteral: adminsorted[0])[0].value
                print("Admin Status Status:\(adminfirstValue)")
                
                UserDefaults.standard.set(json["ownerId"].stringValue, forKey: "commdetailOwner")
                UserDefaults.standard.set(json["@id"].stringValue, forKey: "commdetailID")
                UserDefaults.standard.set(json["description"]["en"].string, forKey: "commdetailDescription")
                UserDefaults.standard.set(firstValue.string, forKey: "commdetailStatusValue")
                UserDefaults.standard.set(adminfirstValue.string, forKey: "commdetailAdminStatusValue")
                
                //                let pairingDateDefi =  json["pairedDefibrillators"].arrayValue.map {$0["pairingDate"].string}
                //                print("Pairing Date Defi:", pairingDateDefi as Any)
                //
                //                if pairingDateDefi == []  {
                //                    UserDefaults.standard.set("N/A", forKey: "commdetailpairingDate")
                //                    print("EMPTY")
                //                } else {
                //
                //                    let z1eroKey = pairingDateDefi[0]
                //                    print("Defi Date:\(z1eroKey ?? "..")")
                //                    let zerofinalDate = z1eroKey?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                //                    print("0 Defi Date:\(zerofinalDate ?? "..")")
                //                    UserDefaults.standard.set(zerofinalDate, forKey: "commdetailpairingDate")
                //                }
                
                //test
                //                let test1 =  json["pairedDefibrillators"].dictionaryValue
                //                print("test1:", test1 as Any)
                //                let test1sorted = test1.sorted(by: { $0.key > $1.key })
                //                print("AdminStatus Sorted:",test1sorted as Any)
                //                let test1firstKey =  Array(arrayLiteral: test1sorted[0])[0].key
                //                print("Admin Status Date:\(test1firstKey)")
                //                let test1firstValue =  Array(arrayLiteral: test1sorted[0])[0].value
                //                print("Admin Status Status:\(test1firstValue)")
                
                
                
                
                //org
                //                let defibrillatorId =  json["pairedDefibrillators"].arrayValue.map {$0["defibrillatorId"].stringValue}
                //                print("Defibrillator Id:", defibrillatorId as Any)
                //                //org
                //                if defibrillatorId == []  {
                //                    print("EMPTY")
                //                    UserDefaults.standard.set("N/A", forKey: "commdetailpairingID")
                //                } else {
                //                    UserDefaults.standard.set(defibrillatorId[0], forKey: "commdetailpairingID")
                //                }
            }
            print("YESSSSSSS")
        case .failure(let error):
            print(error)
            print("NOOOOOO OLD COMM DE")
            
        }
    }
    }
}


func CommGetsingleDataOverview() {

let defaults = UserDefaults.standard

    var baseUser = ""
//    print("Backend: ", backend!)
    
    let email = defaults.string(forKey: "DataUIDUser")
    
    
    baseUser = email!
    print(baseUser)
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    
    
    let selectedComm = defaults.string(forKey: "OVERVIEWCOMMID")
    
//    if selectedComm == "" {
//
//        selectedComm = defaults.string(forKey: "defridetailpairingID")
//    }
//
//        UserDefaults.standard.set(value.string, forKey: "")
//        defridetailpairingID
    
    print("OVERVIEWCOMMID:",selectedComm ?? "00")
    let myDefibrillators = "communicators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedComm ?? ""
    let url = url_defi + theone
//        let url = myUser + baseUser
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        "Authorization": "Basic \(base64Credentials)",
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
//                    print("defi:\(index) 2:\(subJson)")

                if let ownerid = subJson["ownerId"].string {
                print("commOwnerid_N:",ownerid)
                UserDefaults.standard.set(ownerid, forKey: "commdetailOwner")
                let commId = subJson["commId"].stringValue
                print("commId_N:",commId)
                UserDefaults.standard.set(commId, forKey: "commdetailID")
                    
                let commSerialId = subJson["serial"].stringValue
                    print("DefiId_SN:",commSerialId)
                    UserDefaults.standard.set(commSerialId, forKey: "commdetailSerial")
                let description = subJson["description"].string
                    UserDefaults.standard.set(description, forKey: "commdetailDescription")
                let ownerName = subJson["ownerName"].string
                        UserDefaults.standard.set(ownerName, forKey: "commdetailOwnername")
               
                    let status = subJson["status"].dictionaryValue
                    for (key, value) in status {
                        
                        if key == "date" {
                            
                            print("Date: ", value)
                        }
                        
                        if key == "status" {
                            
                            print("Status: ", value)

                            UserDefaults.standard.set(value.string, forKey: "commdetailStatusValue")
                        }
                    }
                    
                    let initialBootupDate = subJson["initialBootupDate"].stringValue
//                        if key == "initialBootupDate" {
                        
//                        print("Initial Bootup Date: ", initialBootupDate)
                        let myString = "\(initialBootupDate)"
                        let myInt: Int = Int(myString) ?? 0000
//                        print("Initial Bootup Date: ", myInt)
                        
                        let pcbProdDate = myInt //myString.int
                        
                        let myInt1 = pcbProdDate//Int(value)
                        
//                                print("Pairing Date: ", value)

                        let unixTimestamp = myInt1 //value.int!
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy" //yyyy-MM-dd HH:mm" //Specify your format that you want
                        let strDate = dateFormatter.string(from: date)
                        
                        print("Initial Bootup Date:", strDate)

                        UserDefaults.standard.set(strDate, forKey: "initialBootupDate")
//                        }
                    
                    
                    
//                        let adminStatus = subJson["adminStatus"].dictionaryValue
//                        for (key, value) in adminStatus {
//
//                            if key == "date" {
//
//                                print("Date: ", value)
//                            }
//
//                            if key == "status" {
//
//                                print("Status: ", value)
//
//                                UserDefaults.standard.set(value.string, forKey: "commdetailAdminStatusValue")
//
//                                let whatStatusImage = value
//
//                                switch whatStatusImage {
//                                case "Operational":
//                                    UserDefaults.standard.set("comms_green", forKey: "commstatusImage")
//
//                                case "Defective":
//                                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
//
//                                case "Disabled":
//                                    UserDefaults.standard.set("comms_red", forKey: "commstatusImage")
//
//                                default:
//                                    UserDefaults.standard.set("Comms", forKey: "commstatusImage")
//                                }
//                            }
//                        }
                    

                    let pairedDefibrillator = subJson["pairedDefribrillator"].dictionaryValue
                    for (key, value) in pairedDefibrillator {
                        
                        if key == "defibrillatorId" {
                            
                            print("Defibrillator Id: ", value)
                            
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingID")
                        }
                        
                        if key == "deribrillatorSerial" {
                            
                            print("Defibrillator Serial: ", value)
                            
                            UserDefaults.standard.set(value.string, forKey: "commdetailpairingSerial")
                        }
                        
                        
                        
                        
                        if key == "pairingDate" {
                            
                            print("Pairing Date: ", value)
                            let myString = "\(value)"
                            let myInt: Int = Int(myString) ?? 0000
                            print("Pairing Date: ", myInt)
                            
                            let pcbProdDate = myInt //myString.int
                            
                            let timeZone = TimeZone(abbreviation: "GMT")!
                            if timeZone.isDaylightSavingTime(for: Date()) {
                            let myInt1 = pcbProdDate//Int(value)
                            let unixTimestamp = myInt1 //value.int!
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //yyyy-MM-dd HH:mm" //Specify your format that you want
                            let strDate = dateFormatter.string(from: date)
                            
                            print("StatusDate:", strDate)

                            UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            } else {
                                
                                let myInt1 = pcbProdDate//Int(value)
                                let unixTimestamp = myInt1 //value.int!
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //yyyy-MM-dd HH:mm" //Specify your format that you want
                                let strDate = dateFormatter.string(from: date)
                                
                                print("StatusDate:", strDate)

                                UserDefaults.standard.set(strDate, forKey: "commdetailpairingDate")
                            }
                        }
                    }
                    
                }
                
            }
        case .failure(let error):
            print(error)
            print("NOOOOOO NEW COM DE")
            
        }
    }

    
    
}
