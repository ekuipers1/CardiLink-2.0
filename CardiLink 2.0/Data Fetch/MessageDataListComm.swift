//
//  MessageDataListComm.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.12.21.
//

import Foundation
import Alamofire
import SwiftyJSON

func getNKMessagesDataComm() {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    var messagesDataComm: String = ""
    var messagesDataInfoComm : String = ""
    var timetest: String  = ""
    let selectedComm = defaults.string(forKey: "SelectedComm")
    let myCommunicatorsMessages = "messages?communicatorid="
    let theoneComm =  selectedComm ?? ""
    let url_commMes = myURL! + myCommunicatorsMessages + theoneComm + "&pagesize=100"
    
    AF.request(url_commMes, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
            if let status = json["data"].arrayObject {
                for obj in status {
                    if let dict = obj as? NSDictionary {
                        
                        let transmissionAttemptsNum = dict.value(forKey: "transmissionAttempts")
                        let transmissionAttemptsString = String(describing: transmissionAttemptsNum!)
                        let messageType = dict.value(forKey: "messageType")
                        let messageTypeString = String(describing: messageType!)
                        let messageId = dict.value(forKey: "messageId")
                        let messageIdString = String(describing: messageId!)
                        let timeStamp = dict.value(forKey: "timeStamp")
                        let timeStampString = String(describing: timeStamp!)
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myInt1 = Int(timeStampString)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 ))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            timetest = strDate
                        } else {
                            let myInt1 = Int(timeStampString)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            timetest = strDate
                        }
                        
                        let stringid = """
                                   "id":
                                   """
                        
                        let MDCOwnerID = "{" + stringid
                        let MDCOwnerIDResult = "\""  + messageIdString + "\""
                        let MDCTranAtt = ","  + "\"transmissionAttempts\"" + ":"
                        let MDCTranAttResult = "\""  + transmissionAttemptsString + "\""
                        let MDCMessType = ","  + "\"messageType\"" + ":"
                        let MDCMessTypeResult = "\""  + messageTypeString + "\""
                        let MDCTime = ","  + "\"timeStamp\"" + ":"
                        let MDCTimeResult = "\""  + timetest + "\"" + "},"
                        
                        let allmessagesDataComm = MDCOwnerID + MDCOwnerIDResult + MDCTranAtt + MDCTranAttResult + MDCMessType + MDCMessTypeResult + MDCTime + MDCTimeResult
                        
                        messagesDataComm.append(allmessagesDataComm)
                        messagesDataInfoComm = "[" + messagesDataComm + "]"
                        
                        let messagesDataComm = messagesDataInfoComm
                        let url = getDocumentsDirectory().appendingPathComponent("NKMessagesDataComm.json")
                        
                        do {
                            try messagesDataComm.write(to: url, atomically: true, encoding: .utf8)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
            
        case .failure(let error):
            print(error)
            print("NOOOOOO")
            
        }
    }
}
