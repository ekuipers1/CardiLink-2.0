//
//  DefiBaseData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.09.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


func getDefiBaseDataList() {
    
    
    
    var GreenThisisit2: String = ""
    var GreenThisisit3: String = ""
    
    var greenDataInfo : String = ""
    //    var baseUser = ""
    let defaults = UserDefaults.standard
    
    print("app folder path is \(NSHomeDirectory())")
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    let myDefibrillators = "defibrillators"
    let url_defi = myURL! + myDefibrillators
    
    
//    let method = HTTPMethod.get
//    let encoding = URLEncoding(destination: .queryString)
//    let headers: HTTPHeaders = [
//        "authkey" : authKey,
//        "Accept": "application/json",
//        "Content-Type": "application/json",
//        "Connection" : "keep-alive"
//    ]
//    AF.request(url_defi, method: method, parameters: nil, encoding:encoding , headers: headers)
    
    
    
    AF.request(url_defi, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        
                        let ownerId = dict.value(forKey: "ownerId")
                        let resultString = String(describing: ownerId!)
//                                print("ownerId2", resultString)
                        
                        let ownerName = dict.value(forKey: "ownerName")
                        let defiOwnerName = String(describing: ownerName!)
                        
                        let defiId = dict.value(forKey: "defiId")
                        let defiIdString = String(describing: defiId!)
//                                print("ownerId2", defiIdString)
                        
                        let defiSerial = dict.value(forKey: "serial")
                        let defiSerialString = String(describing: defiSerial!)
                        
                        let defidashboardState = dict.value(forKey: "dashboardState")
                        let defidashboardStateString = String(describing: defidashboardState!)
                        
                        let description = dict.value(forKey: "description")
                        let descriptionString = String(describing: description!)
//                                print("ownerId2", descriptionString)
                        
                        
                        let stringid = """
                                      "ownerId":
                                      """
                        GreenThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString  + "\"" +  "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + ",")
                        
                        GreenThisisit3.append(" \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "}" + ",")
                        
                        
//                        GreenThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString  + "\"" +  "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "}" + ",")
                        
                        
//                        GreenThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString + "\"" + "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "," + " \"defiId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + descriptionString + "\"" + "}" + ",")
                        
                        greenDataInfo = "[" + GreenThisisit2 + GreenThisisit3 + "]"
                        
                        let greenData = greenDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKgreenData.json")
                        
                        do {
                            try greenData.write(to: url, atomically: true, encoding: .utf8)
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
