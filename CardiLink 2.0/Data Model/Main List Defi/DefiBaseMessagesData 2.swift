//
//  DefiBaseMessagesData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 23.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON


//func getDocumentsDirectory() -> URL {
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    return paths[0]
//}


func DefiBaseMessagesData() {
    
    
    
//    var GreenThisisit2: String = ""
//
//    var greenDataInfo : String = ""
    //    var baseUser = ""
    let defaults = UserDefaults.standard
    
    print("app folder path is \(NSHomeDirectory())")
    
   
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let myURL = defaults.string(forKey: "myPortal")
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let authKey = AuthKey!
    let myDefibrillators = "messages?defibrillatorid="
    let theone =  selectedDefi ?? ""
    let url_defi = myURL! + myDefibrillators + theone + "&pagesize=100"
    
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        
                        let defibrillatorId = dict.value(forKey: "defibrillatorId")
                        let defibrillatorIdString = String(describing: defibrillatorId!)
                        print("defibrillatorIdString", defibrillatorIdString)
                        
                        let timeStamp = dict.value(forKey: "timeStamp")
                        let timeStampString = String(describing: timeStamp!)
                        print("timeStamp", timeStampString)
                        
                        let messageType = dict.value(forKey: "messageType")
                        let messageTypeString = String(describing: messageType!)
                        print("messageTypeString", messageTypeString)
                        
                        let messageId = dict.value(forKey: "messageId")
                        let messageIdString = String(describing: messageId!)
                        print("messageIdString", messageIdString)
                        
//                        let defiSerial = dict.value(forKey: "serial")
//                        let defiSerialString = String(describing: defiSerial!)
//                        print("defiSerialString", defiSerialString)
                        
//                        let defidashboardState = dict.value(forKey: "dashboardState")
//                        let defidashboardStateString = String(describing: defidashboardState!)
//
//                        let description = dict.value(forKey: "description")
//                        let descriptionString = String(describing: description!)
//                                print("ownerId2", descriptionString)
                        
                        
//                        let stringid = """
//                                      "ownerId":
//                                      """
                        
//                        GreenThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString + "\"" + "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "," + " \"defiId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + descriptionString + "\"" + "}" + ",")
//
//                        greenDataInfo = "[" + GreenThisisit2 + "]"
//
//                        let greenData = greenDataInfo
//                        let url = getDocumentsDirectory().appendingPathComponent("NKgreenData.json")
//
//                        do {
//                            try greenData.write(to: url, atomically: true, encoding: .utf8)
//                            //MARK: Uncomment for debugging
//                            //                            let input = try String(contentsOf: url)
//                            //                            print(input)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
                    }
                }
            }
            
            
        case .failure(let error):
            print(error)
            print("NOOOOOO")
            
        }
    }
    
}
