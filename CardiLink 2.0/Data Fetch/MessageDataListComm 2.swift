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
//            let AuthKey = defaults.string(forKey: "DATASTRING")
//            let myURL = defaults.string(forKey: "myPortal")
    let selectedComm = defaults.string(forKey: "SelectedComm")
//            let authKey = AuthKey!
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
 
 //MARK: RESULT
 .responseData {response in
     
     
     switch response.result {
     case .success(let value):
         
         let json = JSON(value)
         
         if let status = json["data"].arrayObject {
             
             for obj in status {
                 if let dict = obj as? NSDictionary {
                     
                     let transmissionAttemptsNum = dict.value(forKey: "transmissionAttempts")
                     let transmissionAttemptsString = String(describing: transmissionAttemptsNum!)
//                     print("messagetransmissionAttempts", transmissionAttemptsString)
                     
                     let messageType = dict.value(forKey: "messageType")
                     let messageTypeString = String(describing: messageType!)
//                     print("messageTypeString", messageTypeString)
                     
                     let messageId = dict.value(forKey: "messageId")
                     let messageIdString = String(describing: messageId!)
//                     print("messageIdString", messageIdString)
                     
                     let timeStamp = dict.value(forKey: "timeStamp")
                     let timeStampString = String(describing: timeStamp!)
//                     print("messageTimeStamp", timeStampString)
                     
//                                if let prodfinalDate = subJson["productionDate"].int {
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
                     let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 7200))
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
                     
                     messagesDataComm.append("{" + stringid + "\""  + messageIdString + "\"" + "," + " \"transmissionAttempts\"" + " : " + "\"" + transmissionAttemptsString + "\"" + "," + " \"messageType\"" + " : " + "\"" + messageTypeString + "\"" + "," + " \"timeStamp\"" + " : " + "\"" + timetest + "\"" + "}" + ",")

                     messagesDataInfoComm = "[" + messagesDataComm + "]"

                     let messagesDataComm = messagesDataInfoComm
                     let url = getDocumentsDirectory().appendingPathComponent("NKMessagesDataComm.json")

                     do {
                         try messagesDataComm.write(to: url, atomically: true, encoding: .utf8)
                         //MARK: Uncomment for debugging
                         //                            let input = try String(contentsOf: url)
                         //                            print(input)
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
