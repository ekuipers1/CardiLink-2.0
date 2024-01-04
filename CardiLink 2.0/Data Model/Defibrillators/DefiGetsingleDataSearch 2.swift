//
//  DefiGetsingleDataSearch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 03.12.21.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

func DefiGetsingleDataSearch() {
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//    
//    let defaults = UserDefaults.standard
//    
//    let backend = defaults.string(forKey: "Backend")
////    var selfTestCount: Int = 0
//    var mymin0: Int = 0
//    
//    var selftestData: String = ""
//    var selftestDataInfo : String = ""
//    
//    if backend == "NEW" {
//        
//        var baseUser = ""
//        print("Backend: ", backend!)
//        
//        let email = defaults.string(forKey: "DataUIDUser")
//        
//        
//        baseUser = email!
//        print(baseUser)
//        
//        let myURL = defaults.string(forKey: "myPortal")
//        let AuthKey = defaults.string(forKey: "DATASTRING")
//        let authKey = AuthKey!
//        let selectedDefi = defaults.string(forKey: "SelectedDefi")
//        
//        let myDefibrillators = "defibrillators?searchtext="
//        let url_defi = myURL! + myDefibrillators
//        let theone =  selectedDefi ?? ""
//        let url = url_defi + theone
//        //        let url = myUser + baseUser
//        
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//            //        "Authorization": "Basic \(base64Credentials)",
//            "authkey" : authKey,
//            "Accept": "application/json",
//            "Content-Type": "application/json"
//        ]
//        )
//        
//            .responseData {response in
//                switch response.result {
//                case .success(let value):
//                    
//                    let json = JSON(value)
//                    
//                    //                    print(json)
//                    
//                    for(index,subJson):(String, JSON) in json {
//                        print("defi:\(index) 2:\(subJson)")
//                        
//                        
//                        //                    subJson["dailySelfTest"].array?[0]
//                        
//                        let selftestid_empty =
//                        //                    subJson["dailySelfTest"].arrayValue
//                        subJson["selfTests"].arrayValue
//                        
//                        
//                        
//                        
//                        
//                        //                }
//                        
//                        if selftestid_empty == [] {
//                            print("EMPTY")
//                        } else {
//                            
//                            //                        let selftestNum = subJson["dailySelfTest"].count
//                            let selftestNum = subJson["selfTests"].count
//                            
//                            
//                            
//                            //                        let statusNum = status.count
//                            
//                            
//                            print("selfTestNum:\(selftestNum)")
//                            
//                            if selftestNum > 3 {
//                                
//                                if selftestNum == 1 {
// 
//                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                    }
//                                    
//                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                        
//                                        let timeZone = TimeZone(abbreviation: "GMT")!
//                                        if timeZone.isDaylightSavingTime(for: Date()) {
//                                            print("Yes, daylight saving time at a given date")
//                                        let myInt1 = Int(selftestdate_00)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                         
//                                        } else {
//                                            let myInt1 = Int(selftestdate_00)
//                                            let unixTimestamp = myInt1
//                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
//                                            let dateFormatter = DateFormatter()
//                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                            dateFormatter.locale = NSLocale.current
//                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                            let strDate = dateFormatter.string(from: date)
//                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                            
//                                        }
//                                    }
//                                    
//                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
//                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
//                                    }
//
//                                } else if selftestNum == 2 {
//                                    
//                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                        //                        print("selftestid_00",selftestid_00)
//                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                    }
//                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
//                                        //                        print("selftestid_01",selftestid_01)
//                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
//                                    }
//                                    
//                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                        
//                                        let myInt1 = Int(selftestdate_00)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                    }
//                                    if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
//                                        
//                                        let myInt1 = Int(selftestdate_01)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
//                                        
//                                    }
//                                    
//                                    //                            }
//                                    
//                                } else {
//                                    
//                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                        //                        print("selftestid_00",selftestid_00)
//                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                    }
//                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
//                                        //                        print("selftestid_01",selftestid_01)
//                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
//                                    }
//                                    if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
//                                        //                        print("selftestid_02",selftestid_02)
//                                        UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
//                                    }
//                                    
//                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
//                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
//                                    }
//                                    
//                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                        
//                                        let timeZone = TimeZone(abbreviation: "GMT")!
//                                        
//                                        if timeZone.isDaylightSavingTime(for: Date()) {
//                                        let myInt1 = Int(selftestdate_00)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                        
//                                        } else {
//                                            let myInt1 = Int(selftestdate_00)
//                                            let unixTimestamp = myInt1
//                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
//                                            let dateFormatter = DateFormatter()
//                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                            dateFormatter.locale = NSLocale.current
//                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                            let strDate = dateFormatter.string(from: date)
//                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                        }
//                                        
//                                    }
//                                    if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
//                                        
//                                        let myInt1 = Int(selftestdate_01)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
//                                        
//                                    }
//                                    if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
//                                        
//                                        let myInt1 = Int(selftestdate_02)
//                                        let unixTimestamp = myInt1
//                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                        let dateFormatter = DateFormatter()
//                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                        dateFormatter.locale = NSLocale.current
//                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                        let strDate = dateFormatter.string(from: date)
//                                        UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
//                                    }
//                                }
//                                
//                                
//                            
//                            let selfTestCount = 1
//                            //                        let statusNumminnumber1 = 0
//                            //                        let statusNummaxnumber1 = status2! - 1
//                            
//                            for _ in selfTestCount...selftestNum {
//                                
//                                print("FIRST GROUP BLOCK Before:\(mymin0)")
//                                
//                                let selftestid_00 = subJson["selfTests"].array?[mymin0]["uniqeSelfTestId"].string
//                                print("uniqeSelfTestId",selftestid_00 ?? "N/A")
//                                let selftestid = String(describing: selftestid_00!)
//                                
////                                let hasBatteryError_00 = subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool
////                                let hasBatteryErrorString = Bool(hasBatteryError_00!)
//                                let hasBatteryErrorString = String((subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool)!)
//                                
//                                let hasWarningsString = String((subJson["selfTests"].array?[mymin0]["hasWarnings"].bool)!)
//                                
//                                let hasRedErrorsString = String((subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool)!)
//                                
//                                
//                                let selfTestMessage = subJson["selfTests"].array?[mymin0]["selfTestMessage"].string
//                                print("uniqeSelfTestId",selfTestMessage ?? "N/A")
//                                let selfTestMessage_00 = String(describing: selfTestMessage ?? "N/A")
////
////                                    if let hasBatteryError_00 = subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool{
////                                        print("hasBatteryError",hasBatteryError_00)
////                                        let hasBatteryErrorString = String(hasBatteryError_00)
////
////                                        if let hasWarnings_00 = subJson["selfTests"].array?[mymin0]["hasWarnings"].bool{
////                                            print("hasWarnings",hasWarnings_00)
////                                            let hasWarningsString = String(hasWarnings_00)
//                                            
////                                            if let hasRedErrors_00 = subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool{
////                                                print("hasRedErrors",hasRedErrors_00)
////                                                let hasRedErrorsString = String(hasRedErrors_00)
//                                                
////                                                if let selfTestMessage_00 = subJson["selfTests"].array?[mymin0]["selfTestMessage"].string  {
////                                                    print("selfTestMessage",selfTestMessage_00)
//                                                    //                                                var hasRedErrorsString = String(hasRedErrors_00)
//                                                    
//                                                    
//                                                    //                            }selfTestMessage
//                                                    
//                                                    if let selftestdate_00 = subJson["selfTests"].array?[mymin0]["date"].int{
//                                                        
//                                                        let myInt1 = Int(selftestdate_00)
//                                                        let unixTimestamp = myInt1
//                                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                                        let dateFormatter = DateFormatter()
//                                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                                        dateFormatter.locale = NSLocale.current
//                                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                                        let strDate = dateFormatter.string(from: date)
//                                                        
//                                                        //                                }
//                                                        if let selftestType_00 = subJson["selfTests"].array?[mymin0]["selfTestType"].string{
//                                                            print("selfTestType",selftestType_00)
//                                                            
//                                                            print("strDate",strDate)
//                                                            
//                                                       
//                                                            print("uniqeSelfTestId",selftestid_00 ?? "N/A")
//                                                            
//                                                         
//                                                            
//                                                            //                            let selftestID = String(describing: selftestid_00)
//                                                            
//                                                            let stringid = """
//                                          "uniqeSelfTestId":
//                                          """
//                                                            selftestData.append("{" + stringid + "\""  + selftestid + "\"" + "," + " \"selfTestMessage\"" + " : " + "\"" + selfTestMessage_00 + "\"" +  "," + " \"hasRedErrors\"" + " : " + "\"" + hasRedErrorsString + "\"" +  "," + " \"hasBatteryError\"" + " : " + "\"" + hasBatteryErrorString + "\"" + "," + " \"hasWarningsString\"" + " : " + "\"" + hasWarningsString + "\"" + "," + " \"strDate\"" + " : " + "\"" + strDate + "\"" + "," + " \"selfTestType\"" + " : " + "\"" + selftestType_00 + "\"" + "}" + ",")
//                                                            
//                                                            selftestDataInfo = "[" + selftestData + "]"
//                                                            
//                                                            let greenData = selftestDataInfo
//                                                            let url = getDocumentsDirectory().appendingPathComponent("SelfTest.json")
//                                                            
//                                                            do {
//                                                                try greenData.write(to: url, atomically: true, encoding: .utf8)
//                                                                //MARK: Uncomment for debugging
//                                                                //                            let input = try String(contentsOf: url)
//                                                                //                            print(input)
//                                                            } catch {
//                                                                print(error.localizedDescription)
//                                                            }
//
//                                                            mymin0 += 1
//                                                            //                            print(selfTestCount)
//                                                            print("ST After:\(mymin0)")
////                                                        }
////                                                    }
////                                                }
////                                            }
////                                        }
//                                    }
//                                }
//                            }
//                            }  else {
//                            
//                            //                        let statusNummaxnumber1 = selftestNum - 1
//                            
//                            
//                            if selftestNum == 1 {
//                                //                            if let selftestid_00 = subJson["dailySelfTest"].array?[0]["uniqeSelfTestId"].string{
//                                if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_00",selftestid_00)
//                                    UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                }
//                                
//                                if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_00)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                }
//                                
//                                if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
//                                    UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
//                                }
//                                
//                                //@AppStorage("defridetailSelfTest00Type") var defridetailSelfTest00Type: String?
//                                
//                                
//                                
//                            } else if selftestNum == 2 {
//                                
//                                if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_00",selftestid_00)
//                                    UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                }
//                                if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_01",selftestid_01)
//                                    UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
//                                }
//                                
//                                if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_00)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                }
//                                if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_01)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
//                                    
//                                }
//                                
//                                //                            }
//                                
//                            } else {
//                                
//                                if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_00",selftestid_00)
//                                    UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
//                                }
//                                if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_01",selftestid_01)
//                                    UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
//                                }
//                                if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
//                                    //                        print("selftestid_02",selftestid_02)
//                                    UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
//                                }
//                                
//                                if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
//                                    UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
//                                }
//                                
//                                if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_00)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
//                                }
//                                if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_01)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
//                                    
//                                }
//                                if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
//                                    
//                                    let myInt1 = Int(selftestdate_02)
//                                    let unixTimestamp = myInt1
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//                                    let strDate = dateFormatter.string(from: date)
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
//                                }
//                            }
//                            
//                            }
//                        }
//                        //                }
//                        
//                        
//                        
//                        //                    if selftestid_empty == "" {
//                        //                        print("NOTHING")
//                        //                    }
//                        //TODO: Hanlde emnpty rows
//                        
//                        
//                        if let ownerid = subJson["ownerId"].string {
//                            print("Ownerid_N:",ownerid)
//                            UserDefaults.standard.set(ownerid, forKey: "defridetailOwner")
//                            let defiId = subJson["defiId"].stringValue
//                            print("DefiId_N:",defiId)
//                            UserDefaults.standard.set(defiId, forKey: "defridetailID")
//                            let ownerName = subJson["ownerName"].stringValue
//                            print("ownerName:",ownerName)
//                            UserDefaults.standard.set(ownerName, forKey: "defridetailownerName")
//                            let defiSerialId = subJson["serial"].stringValue
//                            print("defiId_SN:",defiSerialId)
//                            UserDefaults.standard.set(defiSerialId, forKey: "defridetailSerial")
//                            let description = subJson["description"].string
//                            print("Description:", description ?? "..")
//                            UserDefaults.standard.set(description, forKey: "defridetailDescription")
//                            
//                            let status = subJson["adminStatus"].dictionaryValue
//                            for (key, value) in status {
//
//                                if key == "status" {
//
//                                    let whatStatusImage = value
//                                    
//                                    switch whatStatusImage {
//                                    case 0:
//                                        UserDefaults.standard.set("heart_green", forKey: "statusImage")
//                                        UserDefaults.standard.set("Operational", forKey: "defridetailStatusValue")
//                                        
//                                    case 1:
//                                        UserDefaults.standard.set("heart_green", forKey: "statusImage")
//                                        UserDefaults.standard.set("Monitored", forKey: "defridetailStatusValue")
//
//                                        
//                                    case 2:
//                                        UserDefaults.standard.set("heart_red", forKey: "statusImage")
//                                        UserDefaults.standard.set("Defective", forKey: "defridetailStatusValue")
//
//                                        
//                                    case 3:
//                                        UserDefaults.standard.set("heart_red", forKey: "commstatusImage")
//                                        UserDefaults.standard.set("Disabled", forKey: "defridetailStatusValue")
//                                        
//                                    default:
//                                        UserDefaults.standard.set("aed", forKey: "statusImage")
//                                    }
//                                    
//                                    
//                                }
//                            }
//                            
//                            let adminStatus = subJson["dashboardState"].dictionaryValue
//                            for (key, value) in adminStatus {
//
//                                if key == "stateReason" {
//                                    print("BBO", value)
//                                    let whatStatus = value.string
//                                    UserDefaults.standard.set(whatStatus, forKey: "defridetailAdminStatusReason")
//                                }
//                                
//                                
//                                    if key == "dashboardState" {
//
//                                        let whatStatusImage = value
//                                        
//                                        switch whatStatusImage {
//                                        case 0:
//                                            UserDefaults.standard.set(0, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Available", forKey: "defridetailAdminStatusValue")
//                                                                                        
//                                        case 1:
//                                            UserDefaults.standard.set(1, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Overdue", forKey: "defridetailAdminStatusValue")
//   
//                                        case 2:
//                                            UserDefaults.standard.set(2, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Timeout", forKey: "defridetailAdminStatusValue")
//                                            
//                                        case 3:
//                                            UserDefaults.standard.set(1, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Warning", forKey: "defridetailAdminStatusValue")
//                                            
//                                        case 4:
//                                            UserDefaults.standard.set(2, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Error", forKey: "defridetailAdminStatusValue")
//
//                                            
//                                        case 5:
//                                            UserDefaults.standard.set(3, forKey: "defridetailAdminStatusColor")
//                                            UserDefaults.standard.set("Not monitored", forKey: "defridetailAdminStatusValue")
//                                            
//                                        default:
//                                            UserDefaults.standard.set("aed", forKey: "statusImage")
//                                        }
//                                        
//                                        
//                                    }
//                                }
////
////                                if key == "status" {
////
////                                    print("Status: ", value)
////
////                                    UserDefaults.standard.set(value.string, forKey: "defridetailAdminStatusValue")
////                                }
////                            }
//                            
//                            
//                            let pairedCommunicators = subJson["pairedCommunicator"].dictionaryValue
//                            for (key, value) in pairedCommunicators {
//                                
//                                if key == "communicatorId" {
//                                    print("Communicator Id: ", value)
//                                    
//                                    UserDefaults.standard.set(value.string, forKey: "defridetailpairingID")
//                                }
//                                
//                                if key == "communicatorSerial" {
//                                    
//                                    print("Communicator Serial: ", value)
//                                    
//                                    UserDefaults.standard.set(value.string, forKey: "defidetailpairingSerial")
//                                }
//                                
//                                if key == "pairingDate" {
//                                    
//                                    let initialBootupDate = value.stringValue
//
//                                    let myString = "\(initialBootupDate)"
//                                    let myInt: Int = Int(myString) ?? 0000
//                                    print("pairingDate: ", myInt)
//                                    let pcbProdDate = myInt //myString.int
//                                    let myInt1 = pcbProdDate//Int(value)
//                                    let unixTimestamp = myInt1 //value.int!
//
//                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
//                                    dateFormatter.locale = NSLocale.current
//                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //Specify your format that you want
//                                    let strDate = dateFormatter.string(from: date)
//                                    
//                                    print("StatusDate:", strDate)
//                                    
//                                    UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
//                                }
//                            }
//                        }
////                        }
////                        }
////                    }
//                }
//                case .failure(let error):
//                    print(error)
//                    print("NOOOOOO NEW DEFI DE")
//                    
//                }
//            }
//    }
}
