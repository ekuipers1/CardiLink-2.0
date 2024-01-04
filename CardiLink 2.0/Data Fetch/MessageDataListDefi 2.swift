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
    
    var messagesData: String = ""
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
            
            
            
            
            //                let status = subJson["status"].dictionaryValue
            
            if let status = json["data"].arrayObject {
                
                for obj in status {
                    if let dict = obj as? NSDictionary {
                        
                        let transmissionAttemptsNum = dict.value(forKey: "transmissionAttempts")
                        let transmissionAttemptsString = String(describing: transmissionAttemptsNum!)
                        
                        let messageType = dict.value(forKey: "messageType")
                        let messageTypeString = String(describing: messageType!)
                        //                            print("messageTypeString", messageTypeString)
                        
                        let messageId = dict.value(forKey: "messageId")
                        let messageIdString = String(describing: messageId!)
                        //                            print("messageIdString", messageIdString)
                        
                        let timeStamp = dict.value(forKey: "timeStamp")
                        let timeStampString = String(describing: timeStamp!)
                        //                            print("messageTimeStamp", timeStampString)
                        // TODO: SUMMER TIME
                        
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            print("Yes, daylight saving time at a given date")
                            let myInt1 = Int(timeStampString)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000))
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
                        
                        messagesData.append("{" + stringid + "\""  + messageIdString + "\"" + "," + " \"transmissionAttempts\"" + " : " + "\"" + transmissionAttemptsString + "\"" + "," + " \"messageType\"" + " : " + "\"" + messageTypeString + "\"" + "," + " \"timeStamp\"" + " : " + "\"" + timetest + "\"" + "}" + ",")
                        
                        messagesDataInfo = "[" + messagesData + "]"
                        
                        let messagesData = messagesDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKMessagesData.json")
                        
                        do {
                            try messagesData.write(to: url, atomically: true, encoding: .utf8)
                            //MARK: Uncomment for debugging
                            //                            let input = try String(contentsOf: url)
                            //                            print(input)
                        } catch {
                            print(error.localizedDescription)
                        }
                        //                            UserDefaults.standard.set(messageTypeString, forKey: "WillThisDo")
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
    //    var mymin1: Int = 0
//    var indexNumber: Int = 1
    
    
    
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
            
            
            
            
            //                let status = subJson["status"].dictionaryValue
            
            if let status = json["data"].arrayObject {
                
                
//                print("MESNEW:\(status)")
                
                
                for obj in status {
                    
                    print(myMessageCount)
                    
                    if myMessageCount <= 2 {
                        
                        
                        
                        if let dict = obj as? NSDictionary {
                            
//                            print("MESNEWDIC:\(dict)")
                            
                            
                            let transmissionAttemptsNum = dict.value(forKey: "transmissionAttempts")
                            let transmissionAttemptsString = String(describing: transmissionAttemptsNum!)
                            
                            let messageType = dict.value(forKey: "messageType")
                            let messageTypeString = String(describing: messageType!)
                            
                            let messageId = dict.value(forKey: "messageId")
                            let messageIdString = String(describing: messageId!)
                            //                            print("messageIdString", messageIdString)
                            
                            let timeStamp = dict.value(forKey: "timeStamp")
                            let timeStampString = String(describing: timeStamp!)
                            //                            print("messageTimeStamp", timeStampString)
                            // TODO: SUMMER TIME
                            
                            let timeZone = TimeZone(abbreviation: "GMT")!
                            
                            if timeZone.isDaylightSavingTime(for: Date()) {
                                print("Yes, daylight saving time at a given date")
                                let myInt1 = Int(timeStampString)
                                let unixTimestamp = myInt1
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000))
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
                                
                                print("WWWWWWWW:\(timetest)")
                                
                            }
                            
                            print("WWWWWWWW:\(messageTypeString)")
                            
                            
                            
                            let stringid = """
                                              "id":
                                              """
                            
                            messagesData.append("{" + stringid + "\""  + messageIdString + "\"" + "," + " \"transmissionAttempts\"" + " : " + "\"" + transmissionAttemptsString + "\"" + "," + " \"messageType\"" + " : " + "\"" + messageTypeString + "\"" + "," + " \"timeStamp\"" + " : " + "\"" + timetest + "\"" + "}" + ",")
                            
                            messagesDataInfo = "[" + messagesData + "]"
                            
                            let messagesData = messagesDataInfo
                            let url = getDocumentsDirectory().appendingPathComponent("NKMessagesDataOverView.json")
                            
                            do {
                                try messagesData.write(to: url, atomically: true, encoding: .utf8)
                                myMessageCount += 1
                                //MARK: Uncomment for debugging
                                //                            let input = try String(contentsOf: url)
                                //                            print(input)
                            } catch {
                                print(error.localizedDescription)
                            }
                            //                            UserDefaults.standard.set(messageTypeString, forKey: "WillThisDo")
                        }
                    } else {
                        
                        print("STOP")
                        UserDefaults.standard.set("YES", forKey: "WaitForItOverview")
                        
                    }
                    //                    indexNumber += 1
                    //                   mymin0 += 1
                }
                
                
                
            }
            
        case .failure(let error):
            print(error)
            print("NOOOOOO")
            
        }
    }
}
