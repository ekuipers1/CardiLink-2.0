//
//  ServiceGetsingleData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 08.03.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func ServiceGetsingleData() {
    
    let defaults = UserDefaults.standard
    
    var baseUser = ""
    var basePass = ""
    

    var problemDescription: String = ""
    
    
    let email = defaults.string(forKey: "DataUIDUser")
    let password = defaults.string(forKey: "DataPWDUser")
    let selectedTicket = defaults.string(forKey: "SelectedTicket")
    
    baseUser = email ?? ""
    basePass = password ?? ""
    
    let myURL = defaults.string(forKey: "myPortal") ?? ".."
    let tickets = "/serviceTickets/"
    let theone =  selectedTicket ?? ""
    
    let url = myURL +  tickets + theone
    
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
            
            
            if let ownerid = json["@id"].string {
                print("ticketId:",ownerid)
                let description = json["title"]["en"].string
                print("title:", description ?? "..")
                
                let status = json["status"].dictionaryValue
                print("Status:",status as Any)
                let sorted = status.sorted(by: { $0.key > $1.key })
                print("Status 2:",sorted as Any)
                
                
                let firstKey =  Array(arrayLiteral: sorted[0])[0].key
                print("Current Status Date:\(firstKey)")
                let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                print("Current Status Status:\(firstValue)")
                
                
                UserDefaults.standard.set(json["@id"].stringValue, forKey: "servicedetailNumber")
                UserDefaults.standard.set(json["title"]["en"].string, forKey: "servicedetailTitle")
                
                UserDefaults.standard.set(firstValue.string, forKey: "servicedetailStatusValue")
                let statusDate = firstKey
                print("productionDateBattery:" ,statusDate )

                let finalstatusDate = statusDate.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                    UserDefaults.standard.set(finalstatusDate, forKey: "servicedetailDateStatusValue")

                let authorID = json["author"]["@id"].string
                print("authorID:", authorID ?? "..")
                let authorName = json["author"]["name"].string
                print("authorName:", authorName ?? "..")
                let priority = json["priority"].string
                print("priority:",priority as Any)
                let location = json["location"]["en"].string
                print("location:", location ?? "..")
                let additionalInfo = json["additionalInfo"]["en"].string
                print("additionalInfo:", additionalInfo ?? "..")
                let statusIndicators = json["statusIndicators"].array
                print("statusIndicators:",statusIndicators as Any)
                
                
                UserDefaults.standard.set(json["author"]["@id"].string, forKey: "servicedetailAuthorID")
                UserDefaults.standard.set(json["author"]["name"].string, forKey: "servicedetailAuthorName")
                UserDefaults.standard.set(json["priority"].stringValue, forKey: "servicedetailPriority")
                UserDefaults.standard.set(json["location"]["en"].string, forKey: "servicedetaillocation")
                UserDefaults.standard.set(json["additionalInfo"]["en"].string, forKey: "servicedetailAdditionalInfo")
                UserDefaults.standard.set(json["statusIndicators"].stringValue, forKey: "servicedetailStatusIndicators")
                
//                let problemDescriptions =  json["problemDescriptions"].arrayValue.map {$0["en"].string}
//                let problemDescriptions =  json["problemDescriptions"].arrayValue.map {$0["en"].stringValue}

                if let problems = json["problemDescriptions"].array {
                   for problemsitem in problems {
                     let description = problemsitem["en"].stringValue
                    
                    problemDescription.append(description + "\n")
                    UserDefaults.standard.set(problemDescription, forKey: "servicedetailProblemDescriptions")
                   }
                 }
                
                let affectedcomdef = json["affected"].dictionaryValue
                print("affectedTest:", affectedcomdef as Any)
                let comOrDef = Array(affectedcomdef.keys)[0]
                print("Admin Status Value:\(comOrDef)")

                if comOrDef == "defibrillators" {
                    
                    let affected = json["affected"]["defibrillators"].arrayValue.map {$0["deviceId"].stringValue}
                    print("affectedDef:", affected as Any)
                    let affectedwarrantyStatus = json["affected"]["defibrillators"].arrayValue.map {$0["warrantyStatus"].stringValue}
                    print("affectedDef:", affectedwarrantyStatus as Any)
                    let affecteddescription = json["affected"]["defibrillators"].arrayValue.map {$0["model"].stringValue}
                    print("affectedDef:", affecteddescription as Any)

                    UserDefaults.standard.set(affected[0], forKey: "servicedetailAffected")
                    UserDefaults.standard.set(affectedwarrantyStatus[0], forKey: "servicedetailAffectedwarrantyStatus")
                    UserDefaults.standard.set(affecteddescription[0], forKey: "servicedetailAffecteddescription")

                } else{
                    
                    let affected = json["affected"]["communicators"].arrayValue.map {$0["deviceId"].stringValue}
                    print("affectedCom:", affected as Any)
                    let affectedwarrantyStatus = json["affected"]["communicators"].arrayValue.map {$0["warrantyStatus"].stringValue}
                    print("affectedCom:", affectedwarrantyStatus as Any)
                    let affecteddescription = json["affected"]["communicators"].arrayValue.map {$0["model"].stringValue}
                    print("affectedCom:", affecteddescription as Any)
                    

                    UserDefaults.standard.set(affected[0], forKey: "servicedetailAffected")
                    UserDefaults.standard.set(affectedwarrantyStatus[0], forKey: "servicedetailAffectedwarrantyStatus")
                    UserDefaults.standard.set(affecteddescription[0], forKey: "servicedetailAffecteddescription")
                }
                
            }
            
            print("YESSSSSSS")
            
        case .failure(let error):
            print(error)
            print("NOOOOOO")
            
        }
    }
    
}


func ServiceGetsingleDataNK() {
    
    let defaults = UserDefaults.standard
    
//    var baseUser = ""
//    var basePass = ""
    

    let problemDescription: String = ""
    
    
//    let email = defaults.string(forKey: "DataUIDUser")
//    let password = defaults.string(forKey: "DataPWDUser")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let selectedTicket = defaults.string(forKey: "SelectedTicket")
    
//    baseUser = email ?? ""
//    basePass = password ?? ""
    let authKey = AuthKey!
    
    let myURL = defaults.string(forKey: "myPortal") ?? ".."
    let tickets = "servicetickets/"
    let theone =  selectedTicket ?? ""
    
    let url = myURL +  tickets + theone
    
//    let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//
//    let base64Credentials = credentialData.base64EncodedString()
    
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
            
            for (index,subJson):(String, JSON) in json {
                print("defi:\(index) 2:\(subJson)")
            
            
            
            if let ownerid = subJson["id"].string {
                print("ticketId:",ownerid)
                let description = subJson["title"].string
                print("title:", description ?? "N/A")
                let priority = subJson["priority"].int
                print("priority:", priority!)
                
                
                            UserDefaults.standard.set(subJson["id"].stringValue, forKey: "servicedetailNumber")
                      UserDefaults.standard.set(subJson["title"].string, forKey: "servicedetailTitle")
                UserDefaults.standard.set(subJson["priority"].stringValue, forKey: "servicedetailPriority")
                

                let eventLatLon = subJson["statusDate"].int
                let unixTimestamp = eventLatLon
                    
                    let timeZone = TimeZone(abbreviation: "GMT")!
                    if timeZone.isDaylightSavingTime(for: Date()) {
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 3600))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a" //Specify your format that you want
                        let strDate = dateFormatter.string(from: date)
                        
                        print("eventLatLon:", strDate)
                        UserDefaults.standard.set(strDate, forKey: "servicedetailDateStatusValue")
                        
//                                                UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                    }else {
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 7200))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a" //Specify your format that you want
                        let strDate = dateFormatter.string(from: date)
                        
                        print("eventLatLon:", strDate)
                        UserDefaults.standard.set(strDate, forKey: "servicedetailDateStatusValue")
//                                                UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                    }
                    
                
                let authorName = subJson["authorName"].string
                print("authorName:", authorName ?? "N/A")
                UserDefaults.standard.set(subJson["authorName"].string, forKey: "servicedetailAuthorName")
                
                let status = subJson["status"].int
                print("status:", status!)
                UserDefaults.standard.set(subJson["status"].stringValue, forKey: "servicedetailStatusValue")
                
                let problemDescriptions = subJson["problemDescriptions"].string
                print("problemDescriptions:", problemDescriptions ?? "N/A")
                UserDefaults.standard.set(problemDescription, forKey: "servicedetailProblemDescriptions")
                
                let additionalInfo = subJson["additionalInfo"].string
                print("additionalInfo:", additionalInfo ?? "N/A")
                UserDefaults.standard.set(subJson["additionalInfo"].string, forKey: "servicedetailAdditionalInfo")

                let location = subJson["location"].int
                print("location:", location!)
                UserDefaults.standard.set(subJson["location"].stringValue, forKey: "servicedetaillocation")

                
//                let defibrillatorSerial = subJson["affected"].dictionaryValue
//                print("defibrillatorSerial:", defibrillatorSerial )

                
                let defibrillatorSerial: String! = subJson["affected"][0]["defibrillatorSerial"].string
                print("defibrillatorSerial:", defibrillatorSerial ?? "N/A" )
                UserDefaults.standard.set(defibrillatorSerial, forKey: "defibrillatorSerial")
                
                
                let defibrillatorId: String! = subJson["affected"][0]["defibrillatorId"].string
                print("defibrillatorId:", defibrillatorId ?? "N/A" )
                UserDefaults.standard.set(defibrillatorId, forKey: "defibrillatorId")
                
                let communicatorSerial: String! = subJson["affected"][0]["communicatorSerial"].string
                print("communicatorSerial:", communicatorSerial ?? "N/A")
                UserDefaults.standard.set(communicatorSerial, forKey: "communicatorSerial")
                
                let communicatorId: String! = subJson["affected"][0]["communicatorId"].string
                print("communicatorId:", communicatorId ?? "N/A")
                UserDefaults.standard.set(communicatorId, forKey: "communicatorId")
 
            }
            }
            print("YESSSSSSS")
            
        case .failure(let error):
            print(error)
            print("NOOOOOO")
            
        }
    }
    
}
