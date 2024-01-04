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
    var greenDataInfo : String = ""
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators"
    let url_defi = myURL! + myDefibrillators
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                        let ownerId = dict.value(forKey: "ownerId")
                        let resultString = String(describing: ownerId!)
                        let ownerName = dict.value(forKey: "ownerName")
                        let defiOwnerName = String(describing: ownerName!)
                        let defiId = dict.value(forKey: "defiId")
                        let defiIdString = String(describing: defiId!)
                        let defiSerial = dict.value(forKey: "serial")
                        let defiSerialString = String(describing: defiSerial!)
                        let defidashboardState = dict.value(forKey: "dashboardState")
                        let defidashboardStateString = String(describing: defidashboardState!)
                        let description = dict.value(forKey: "description")
                        let descriptionString = String(describing: description!)
                        let descriptionStringClean = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()

                        let stringid = """
                                      "ownerId":
                                      """
                        
                        let SGOwnerID = "{" + stringid
                        let SGOwnerIDResult = "\""  + resultString + "\""
                        let SGDash = ","  + "\"dashboardState\"" + ":"
                        let SGDashResult = "\""  + defidashboardStateString + "\""
                        let SGOwner = ","  + "\"ownerName\"" + ":"
                        let SGOwnerResult = "\""  + defiOwnerName + "\""
                        let SGSerialID = ","  + "\"serialId\"" + ":"
                        let SGSerialIDResult = "\""  + defiSerialString + "\""
                        let SGDefiID = ","  + "\"defiId\"" + ":"
                        let SGDefiIDResult = "\""  + defiIdString + "\""
                        let SGDescription = ","  + "\"description\"" + ":"
                        let SGDescriptionResult = "\""  + descriptionStringClean + "\"" + "},"
                        
                        
                        let allSearchGreen = SGOwnerID + SGOwnerIDResult + SGDash + SGDashResult + SGOwner + SGOwnerResult + SGSerialID + SGSerialIDResult + SGDefiID + SGDefiIDResult + SGDescription + SGDescriptionResult

                        GreenThisisit2.append(allSearchGreen)

                        greenDataInfo = "[" + GreenThisisit2 + "]"
                        
                        let greenData = greenDataInfo
                        let url = getDocumentsDirectory().appendingPathComponent("NKgreenData.json")
                        
                        do {
                            try greenData.write(to: url, atomically: true, encoding: .utf8)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
            
        case .failure(let error):
            print(error)
        }
    }
    
}

