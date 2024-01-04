//
//  MessageDataListDefi.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.12.21.
//

import Foundation
import Alamofire
import SwiftyJSON

func getNKMessagesData() {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    var timetest: String  = ""
    var messagesDataDefi: String = ""
    var messagesDataInfo : String = ""
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillatorsMessages = "messages?defibrillatorid="
    let theone =  selectedDefi ?? ""
    let url_defiMes = myURL! + myDefibrillatorsMessages + theone + "&pagesize=100"
    
    AF.request(url_defiMes, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        let myInt1 = Int(timeStampString) //Int(message_defibrillatorTimestamp!)
                        let date = Date(timeIntervalSince1970: TimeInterval(myInt1! / 1000))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone.current // Use the current system timezone
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                        let strDate = dateFormatter.string(from: date)
                        timetest = strDate
                        if TimeZone.current.isDaylightSavingTime(for: Date()) {
                        }
                        
                        let stringid = """
                                              "id":
                                              """
                        
                        let MDDOwnerID = "{" + stringid
                        let MDDOwnerIDResult = "\""  + messageIdString + "\""
                        let MDDTranAtt = ","  + "\"transmissionAttempts\"" + ":"
                        let MDDTranAttResult = "\""  + transmissionAttemptsString + "\""
                        let MDDMessType = ","  + "\"messageType\"" + ":"
                        let MDDMessTypeResult = "\""  + messageTypeString + "\""
                        let MDDTime = ","  + "\"timeStamp\"" + ":"
                        let MDDTimeResult = "\""  + timetest + "\"" + "},"
                        
                        let allmessagesDataComm = MDDOwnerID + MDDOwnerIDResult + MDDTranAtt + MDDTranAttResult + MDDMessType + MDDMessTypeResult + MDDTime + MDDTimeResult
                        
                        messagesDataDefi.append(allmessagesDataComm)
                        messagesDataInfo = "[" + messagesDataDefi + "]"
                        
                        let messagesData = messagesDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKMessagesData.json")
                        
                        do {
                            try messagesData.write(to: url, atomically: true, encoding: .utf8)
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
func getNKMessagesDataOverview() {
    
    var myMessageCount: Int = 0
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    var timetest: String  = ""
    
    var messagesData: String = ""
    var messagesDataInfo : String = ""
    
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillatorsMessages = "messages?defibrillatorid="
    let theone =  selectedDefi ?? ""
    let url_defiMes = myURL! + myDefibrillatorsMessages + theone + "&pagesize=3"
    
    AF.request(url_defiMes, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        
                        let myInt1 = Int(timeStampString)
                        let date = Date(timeIntervalSince1970: TimeInterval(myInt1! / 1000))
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone.current
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                        let strDate = dateFormatter.string(from: date)
                        timetest = strDate
                        if TimeZone.current.isDaylightSavingTime(for: Date()) {
                        }
                        
                        let stringid = """
                                              "id":
                                              """
                        
                        let MDDOOwnerID = "{" + stringid
                        let MDDOOwnerIDResult = "\""  + messageIdString + "\""
                        let MDDOTranAtt = ","  + "\"transmissionAttempts\"" + ":"
                        let MDDOTranAttResult = "\""  + transmissionAttemptsString + "\""
                        let MDDOMessType = ","  + "\"messageType\"" + ":"
                        let MDDOMessTypeResult = "\""  + messageTypeString + "\""
                        let MDDOTime = ","  + "\"timeStamp\"" + ":"
                        let MDDOTimeResult = "\""  + timetest + "\"" + "},"
                        
                        
                        let allmessagesDataOverview = MDDOOwnerID + MDDOOwnerIDResult + MDDOTranAtt + MDDOTranAttResult + MDDOMessType + MDDOMessTypeResult + MDDOTime + MDDOTimeResult
                        
                        messagesData.append(allmessagesDataOverview)
                        
                        messagesDataInfo = "[" + messagesData + "]"
                        
                        let messagesData = messagesDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKMessagesDataOverView.json")
                        
                        do {
                            try messagesData.write(to: url, atomically: true, encoding: .utf8)
                            myMessageCount += 1
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
