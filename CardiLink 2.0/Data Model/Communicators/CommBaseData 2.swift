//
//  CommBaseData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.09.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func getCommBaseDataList() {
    
    var CommThisisit2: String = ""
    
    var commDataInfo : String = ""
    //    var baseUser = ""
    let defaults = UserDefaults.standard
    
    print("app folder path is \(NSHomeDirectory())")
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    let myCommunicator = "communicators"
    let url = myURL! + myCommunicator
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        
                        let commId = dict.value(forKey: "commId")
                        let defiIdString = String(describing: commId!)
//                                print("commId", defiIdString)
                        
                        let ownerId = dict.value(forKey: "ownerId")
                        let resultString = String(describing: ownerId!)
//                                print("comownerId", resultString)
                        
                        let ownerName = dict.value(forKey: "ownerName")
                        let ownerNameString = String(describing: ownerName ?? "N/A")
                        

                        let ownerSerial = dict.value(forKey: "serial")
                        let resultSerial = String(describing: ownerSerial!)
                        
                        let description = dict.value(forKey: "description")
                        let descriptionString = String(describing: description!)
//                        print("comdescription", descriptionString)
                        
                        
                        let stringid = """
                                      "ownerId":
                                      """
                        
                        CommThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString + "\"" + "," + " \"commSerial\"" + " : " + "\"" + resultSerial + "\"" + "," + " \"commId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + descriptionString + "\"" + "}" + ",")
                        
                        commDataInfo = "[" + CommThisisit2 + "]"
                        
                        let commData = commDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKCommData.json")
                        
                        do {
                            try commData.write(to: url, atomically: true, encoding: .utf8)
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
