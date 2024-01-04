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
    
    let email = defaults.string(forKey: "username")
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
                let description = json["title"]["en"].string
                let status = json["status"].dictionaryValue
                let sorted = status.sorted(by: { $0.key > $1.key })
                let firstKey =  Array(arrayLiteral: sorted[0])[0].key
                let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                
                UserDefaults.standard.set(json["@id"].stringValue, forKey: "servicedetailNumber")
                UserDefaults.standard.set(json["title"]["en"].string, forKey: "servicedetailTitle")
                UserDefaults.standard.set(firstValue.string, forKey: "servicedetailStatusValue")
                
                let statusDate = firstKey
                let finalstatusDate = statusDate.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                UserDefaults.standard.set(finalstatusDate, forKey: "servicedetailDateStatusValue")
                let authorID = json["author"]["@id"].string
                let authorName = json["author"]["name"].string
                let priority = json["priority"].string
                let location = json["location"]["en"].string
                let additionalInfo = json["additionalInfo"]["en"].string
                let statusIndicators = json["statusIndicators"].array
                
                UserDefaults.standard.set(json["author"]["@id"].string, forKey: "servicedetailAuthorID")
                UserDefaults.standard.set(json["author"]["name"].string, forKey: "servicedetailAuthorName")
                UserDefaults.standard.set(json["priority"].stringValue, forKey: "servicedetailPriority")
                UserDefaults.standard.set(json["location"]["en"].string, forKey: "servicedetaillocation")
                UserDefaults.standard.set(json["additionalInfo"]["en"].string, forKey: "servicedetailAdditionalInfo")
                UserDefaults.standard.set(json["statusIndicators"].stringValue, forKey: "servicedetailStatusIndicators")
                
                if let problems = json["problemDescriptions"].array {
                    for problemsitem in problems {
                        let description = problemsitem["en"].stringValue
                        
                        problemDescription.append(description + "\n")
                        UserDefaults.standard.set(problemDescription, forKey: "servicedetailProblemDescriptions")
                    }
                }
                
                let affectedcomdef = json["affected"].dictionaryValue
                let comOrDef = Array(affectedcomdef.keys)[0]
                
                if comOrDef == "defibrillators" {
                    let affected = json["affected"]["defibrillators"].arrayValue.map {$0["deviceId"].stringValue}
                    let affectedwarrantyStatus = json["affected"]["defibrillators"].arrayValue.map {$0["warrantyStatus"].stringValue}
                    let affecteddescription = json["affected"]["defibrillators"].arrayValue.map {$0["model"].stringValue}
                    
                    UserDefaults.standard.set(affected[0], forKey: "servicedetailAffected")
                    UserDefaults.standard.set(affectedwarrantyStatus[0], forKey: "servicedetailAffectedwarrantyStatus")
                    UserDefaults.standard.set(affecteddescription[0], forKey: "servicedetailAffecteddescription")
                    
                } else{
                    
                    let affected = json["affected"]["communicators"].arrayValue.map {$0["deviceId"].stringValue}
                    let affectedwarrantyStatus = json["affected"]["communicators"].arrayValue.map {$0["warrantyStatus"].stringValue}
                    let affecteddescription = json["affected"]["communicators"].arrayValue.map {$0["model"].stringValue}
                    
                    UserDefaults.standard.set(affected[0], forKey: "servicedetailAffected")
                    UserDefaults.standard.set(affectedwarrantyStatus[0], forKey: "servicedetailAffectedwarrantyStatus")
                    UserDefaults.standard.set(affecteddescription[0], forKey: "servicedetailAffecteddescription")
                }
                
            }
            
        case .failure(let error):
            print(error)
            
        }
    }
    
}
func ServiceGetsingleDataNK() {
    
    let defaults = UserDefaults.standard
    let problemDescription: String = ""
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let selectedTicket = defaults.string(forKey: "SelectedTicket")
    let authKey = AuthKey!
    let myURL = defaults.string(forKey: "myPortal") ?? ".."
    let tickets = "servicetickets/"
    let theone =  selectedTicket ?? ""
    let url = myURL +  tickets + theone
    
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
                if let ownerid = subJson["id"].string {
                    let description = subJson["title"].string
                    let priority = subJson["priority"].int
                    
                    UserDefaults.standard.set(subJson["id"].stringValue, forKey: "servicedetailNumber")
                    UserDefaults.standard.set(subJson["title"].string, forKey: "servicedetailTitle")
                    UserDefaults.standard.set(subJson["priority"].stringValue, forKey: "servicedetailPriority")
                    
                    let eventLatLon = subJson["statusDate"].int
                    let unixTimestamp = eventLatLon
                    let timeZone = TimeZone(abbreviation: "GMT")!
                    if timeZone.isDaylightSavingTime(for: Date()) {
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 3600))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
                        let strDate = dateFormatter.string(from: date)
                        UserDefaults.standard.set(strDate, forKey: "servicedetailDateStatusValue")
                    }else {
                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 3600))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
                        let strDate = dateFormatter.string(from: date)
                        UserDefaults.standard.set(strDate, forKey: "servicedetailDateStatusValue")
                    }
                    
                    let authorName = subJson["authorName"].string
                    UserDefaults.standard.set(subJson["authorName"].string, forKey: "servicedetailAuthorName")
                    let status = subJson["status"].int
                    UserDefaults.standard.set(subJson["status"].stringValue, forKey: "servicedetailStatusValue")
                    let problemDescriptions = subJson["problemDescriptions"].string
                    UserDefaults.standard.set(problemDescription, forKey: "servicedetailProblemDescriptions")
                    let additionalInfo = subJson["additionalInfo"].string
                    UserDefaults.standard.set(subJson["additionalInfo"].string, forKey: "servicedetailAdditionalInfo")
                    let location = subJson["location"].int
                    UserDefaults.standard.set(subJson["location"].stringValue, forKey: "servicedetaillocation")
                    let defibrillatorSerial: String! = subJson["affected"][0]["defibrillatorSerial"].string
                    UserDefaults.standard.set(defibrillatorSerial, forKey: "defibrillatorSerial")
                    let defibrillatorId: String! = subJson["affected"][0]["defibrillatorId"].string
                    UserDefaults.standard.set(defibrillatorId, forKey: "defibrillatorId")
                    let communicatorSerial: String! = subJson["affected"][0]["communicatorSerial"].string
                    UserDefaults.standard.set(communicatorSerial, forKey: "communicatorSerial")
                    let communicatorId: String! = subJson["affected"][0]["communicatorId"].string
                    UserDefaults.standard.set(communicatorId, forKey: "communicatorId")
                }
            }
            
        case .failure(let error):
            print(error)
            
        }
    }
    
}
