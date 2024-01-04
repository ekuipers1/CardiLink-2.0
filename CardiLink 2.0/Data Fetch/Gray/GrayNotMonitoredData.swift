//
//  GrayNotMonitoredData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 03.03.23.
//

import Foundation
import Alamofire
import SwiftyJSON

func GrayNotMonitoredData() {
    
    var dashCountGray: Int = 0
    var searchDataInfoGray : String = ""
    var SearchGreen: String = ""
    let defaults = UserDefaults.standard
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators?PageSize=10&DashboardColorGroup=3"
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
            if let count = json["count"].int {
                UserDefaults.standard.set(count, forKey: "GrayCount")
            }
            
            if let status = json["data"].arrayObject {
                
                for obj in status {
                    if let dict = obj as? NSDictionary {
                        let defidashboardState = dict.value(forKey: "dashboardState")
                        let defidashboardStateString = String(describing: defidashboardState!)
                        if defidashboardStateString == "5" {
                            dashCountGray += 1
                            
                            let ownerId = dict.value(forKey: "ownerId")
                            let resultString = String(describing: ownerId!)
                            let ownerName = dict.value(forKey: "ownerName")
                            let defiOwnerName = String(describing: ownerName ?? "N/A")
                            let defiId = dict.value(forKey: "defiId")
                            let defiIdString = String(describing: defiId!)
                            let defiSerial = dict.value(forKey: "serial")
                            let defiSerialString = String(describing: defiSerial!)
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
                            
                            SearchGreen.append(allSearchGreen)
                            
                            searchDataInfoGray = "[" + SearchGreen + "]"
                            
                            let greenData = searchDataInfoGray
                            let url = getDocumentsDirectory().appendingPathComponent("NKgrayNonMonitoredData.json")
                            
                            do {
                                try greenData.write(to: url, atomically: true, encoding: .utf8)
                            } catch {
                                print(error.localizedDescription)
                            }
                        } else {
                            
                        }
 
                    }
                    
                }
                UserDefaults.standard.set("OK", forKey: "WaitForIt")
            }
            
        case .failure(let error):
            print(error)
            UserDefaults.standard.set("OK", forKey: "WaitForIt")
        }
    }
    
}
