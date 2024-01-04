//
//  YellowOverdueData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 22.02.23.
//

import Foundation
import Alamofire
import SwiftyJSON


func YellowOverdueData() {
    
//    @Binding var value = ""

    
    var dashCountYellowOverdue: Int = 0
    var searchDataInfoYellow : String = ""
    var SearchYellow: String = ""
    //    var countDashGreenNumber:String = ""
    let defaults = UserDefaults.standard
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
//    let myBackend = defaults.string(forKey: "Backend")
    
    //MARK: NK START
    
    
//    let email = defaults.string(forKey: "DataUIDUser")
    
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    
    
    //MARK: DEFI
    //            let myDefibrillators = "defibrillators"
    let myDefibrillators = "defibrillators?DashboardColorGroup=2"
//    let myDefibrillators = "defibrillators?PageSize=500&dashboardState=1" //4500
    let url_defi = myURL! + myDefibrillators
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
//            print("YELLOW OVER NK LIST : \(json)")
            
            if let count = json["count"].int {
                UserDefaults.standard.set(count, forKey: "YellowCount")
            }
            
            
            if let status = json["data"].arrayObject {
                
                for obj in status {
                    if let dict = obj as? NSDictionary {
                        
                        let defidashboardState = dict.value(forKey: "dashboardState")
                        let defidashboardStateString = String(describing: defidashboardState!)
                        
//                        print(defidashboardStateString)
                        
                        //overdue = 1
                        if defidashboardStateString == "1"{
                            
                            dashCountYellowOverdue += 1
                            
                            
                            let ownerId = dict.value(forKey: "ownerId")
                            let resultString = String(describing: ownerId!)
                            //                                print("ownerId2", resultString)
                            
                            let ownerName = dict.value(forKey: "ownerName")
                            let defiOwnerName = String(describing: ownerName ?? "N/A")
                            
                            let defiId = dict.value(forKey: "defiId")
                            let defiIdString = String(describing: defiId!)
                            //                                print("ownerId2", defiIdString)
                            
                            
                            let defiSerial = dict.value(forKey: "serial")
                            let defiSerialString = String(describing: defiSerial!)
                            
                            let description = dict.value(forKey: "description")
                            let descriptionString = String(describing: description!)
                            //                                print("ownerId2", descriptionString)
                            let descriptionStringClean = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()
                            
                            
                            let stringid = """
                                              "ownerId":
                                              """
                            
                            let SYOwnerID = "{" + stringid
                            let SYOwnerIDResult = "\""  + resultString + "\""
                            let SYDash = ","  + "\"dashboardState\"" + ":"
                            let SYDashResult = "\""  + defidashboardStateString + "\""
                            let SYOwner = ","  + "\"ownerName\"" + ":"
                            let SYOwnerResult = "\""  + defiOwnerName + "\""
                            let SYSerialID = ","  + "\"serialId\"" + ":"
                            let SYSerialIDResult = "\""  + defiSerialString + "\""
                            let SYDefiID = ","  + "\"defiId\"" + ":"
                            let SYDefiIDResult = "\""  + defiIdString + "\""
                            let SYDescription = ","  + "\"description\"" + ":"
                            let SYDescriptionResult = "\""  + descriptionStringClean + "\"" + "},"
                            
                            
                            let allSearchYellow = SYOwnerID + SYOwnerIDResult + SYDash + SYDashResult + SYOwner + SYOwnerResult + SYSerialID + SYSerialIDResult + SYDefiID + SYDefiIDResult + SYDescription + SYDescriptionResult
//                            print("@all:" ,allSearchYellow)
                            
                            SearchYellow.append(allSearchYellow)
                            
                            searchDataInfoYellow = "[" + SearchYellow + "]"
                            
                            //                                    self.yellowDataInfo = "[" + self.YellowThisisit2 + "]"
                            
                            let yellowData = searchDataInfoYellow
                            let url = getDocumentsDirectory().appendingPathComponent("NKyellowOverdueData.json")
                            
                            do {
                                try yellowData.write(to: url, atomically: true, encoding: .utf8)
                                //MARK: Uncomment for debugging
                                //                            let input = try String(contentsOf: url)
                                //                            print(input)
                            } catch {
                                print(error.localizedDescription)
                            }
                        } else {
                            
                        }
                        // MARK: ⚠️ SAVE YELLOW COUNT OLD  END
//                        let dashCountYellow = String(dashCountYellowOverdue)
                        //                                                                self.countDashYellowNumber = dashCountYellow
//                        print("Yellow COUNT Overdue:", dashCountYellowOverdue)
                        
                        UserDefaults.standard.set(dashCountYellowOverdue, forKey: "YellowCountOverdue")
                        
                    }
                }
            }
        case .failure(let error):
            print(error)
            print("NKredData FILE ERROR")
            
        }
    }
    
}
