//
//  YellowWarningData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 22.02.23.
//

import Foundation
import Alamofire
import SwiftyJSON

func YellowWarningData() {
    
    
    
    var dashCountYellowWarning: Int = 0
    var searchDataInfoYellow : String = ""
    var SearchYellow: String = ""
    //    var countDashGreenNumber:String = ""
    let defaults = UserDefaults.standard
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    
//    let dashCountYellowoverdue = defaults.string(forKey: "YellowCountOverdue") ?? "0"
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    //MARK: DEFI
    let myDefibrillators = "defibrillators?DashboardColorGroup=2"
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
            
            
            
            
            if let status = json["data"].arrayObject {
                
                for obj in status {
                    if let dict = obj as? NSDictionary {
                        
                        let defidashboardState = dict.value(forKey: "dashboardState")
                        let defidashboardStateString = String(describing: defidashboardState!)
                        
//                        print(defidashboardStateString)
                        
                        //warning = 3
                        if defidashboardStateString == "3"{
                            
//                            overdueYellow += 1
                            dashCountYellowWarning += 1
                            
//                            print("overdueYellow2", overdueYellow)
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
                            let url = getDocumentsDirectory().appendingPathComponent("NKyellowWarningData.json")
                            
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
//                        print("Yellow COUNT Warning:", dashCountYellowWarning)
                        
                        UserDefaults.standard.set(dashCountYellowWarning, forKey: "YellowCountWarning")
                        
//                        let myBackend = defaults.integer(forKey: "YellowCountOverdue")
//
//                        print("Yellow COUNT Overdue:", myBackend)
//
//
//                        let mynewcoutner = dashCountYellowWarning + myBackend
//
//                        print("Yellow COUNT TOTAL:", mynewcoutner)
//
//
//                        UserDefaults.standard.set(mynewcoutner, forKey: "YellowCount")
                    }
                }
            }
            
            //MARK: BUILD IF STATEMENT IF EMPTY FOR BOT SIDES
            
//            let myBackend = defaults.integer(forKey: "YellowCountOverdue")
//            
//            print("Yellow COUNT Overdue:", myBackend)
//            UserDefaults.standard.set(myBackend, forKey: "YellowCount")
        
            
            
        case .failure(let error):
            print(error)
            print("NKredData FILE ERROR")
            
        }
        
//        UserDefaults.standard.set("0", forKey: "YellowCountWarning")
    }
    
}
