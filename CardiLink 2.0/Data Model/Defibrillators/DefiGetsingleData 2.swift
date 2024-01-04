//
//  DefiGetsingleData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 05.03.21.
//

import Foundation
import Alamofire
import SwiftyJSON


func DefiGetsingleData() {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    let defaults = UserDefaults.standard
    
    let backend = defaults.string(forKey: "Backend")
    let overview = defaults.string(forKey: "Overview")
    
    
    //    var selfTestCount: Int = 0
    var mymin0: Int = 0
    var timetest: String  = ""
    
    var selftestData: String = ""
    var selftestDataInfo : String = ""
    
    if backend == "NEW" {
        
        var baseUser = ""
        print("Backend: ", backend!)
        
        let email = defaults.string(forKey: "DataUIDUser")
        
        
        baseUser = email!
        print(baseUser)
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        let myDefibrillators = "defibrillators/"
        let url_defi = myURL! + myDefibrillators
        let theone =  selectedDefi ?? ""
        let url = url_defi + theone
        //        let url = myUser + baseUser
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            //        "Authorization": "Basic \(base64Credentials)",
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
                    
                    //                    print(json)
                    
                    for(index,subJson):(String, JSON) in json {
                        print("defi:\(index) 2:\(subJson)")
                        
                        
                        //                    subJson["dailySelfTest"].array?[0]
                        
                        let selftestid_empty =
                        //                    subJson["dailySelfTest"].arrayValue
                        subJson["selfTests"].arrayValue
                        
                        if selftestid_empty == [] {
                            print("THISISIT")
//                            UserDefaults.standard.set("N/A", forKey: "defridetailSelfTest00Date")
//                            UserDefaults.standard.set("N/A", forKey: "defridetailSelfTest01Date")
//                            UserDefaults.standard.set("N/A", forKey: "defridetailSelfTest02Date")
                        } else {
                            
                            let selftestNum = subJson["selfTests"].count
                            
                            print("selfTestNum:\(selftestNum)")
                            
                            if selftestNum > 3 {
                                
                                if selftestNum == 1 {
                                    //                            if let selftestid_00 = subJson["dailySelfTest"].array?[0]["uniqeSelfTestId"].string{
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                            
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                                    }
                                    
                                } else if selftestNum == 2 {
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_01",selftestid_01)
                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                            
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        } else {
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        }
                                        
                                    }
                                    
                                    //                            }
                                    
                                } else {
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_01",selftestid_01)
                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                                    }
                                    if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_02",selftestid_02)
                                        UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
                                    }
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        } else {
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        }
                                    }
                                    if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_02)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                        }else {
                                            let myInt1 = Int(selftestdate_02)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                        }
                                    }
                                }
                                
                                
                                
                                let selfTestCount = 1
                                
                                for _ in selfTestCount...selftestNum {
                                    
                                    print("FIRST GROUP BLOCK Before:\(mymin0)")
                                    
                                    let selftestid_00 = subJson["selfTests"].array?[mymin0]["uniqeSelfTestId"].string
//                                    print("uniqeSelfTestId",selftestid_00 ?? "N/A")
                                    let selftestid = String(describing: selftestid_00!)
                                    
                                    let hasBatteryErrorString = String((subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool)!)
                                    
                                    UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool)!), forKey: "defridetailhasBatteryErrorOverview")
                                    
                                    let hasWarningsString = String((subJson["selfTests"].array?[mymin0]["hasWarnings"].bool)!)
                                    UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasWarnings"].bool)!), forKey: "defridetailSelfTesthasWarningsOverview")
//                                    print("defridetailSelfTesthasWarningsOverview",hasWarningsString ?? "N/A")
                                    
                                    let hasRedErrorsString = String((subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool)!)
                                    UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool)!), forKey: "defridetailSelfTesthasRedErrorsOverview")
                                    
                                    
                                    let selfTestMessage = subJson["selfTests"].array?[mymin0]["selfTestMessage"].string
//                                    print("uniqeSelfTestId",selfTestMessage ?? "N/A")
                                    let selfTestMessage_00 = String(describing: selfTestMessage ?? "No Additional Info")
                                    UserDefaults.standard.set(selfTestMessage_00, forKey: "message_selfTestResult")
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[mymin0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            timetest = strDate
                                            
                                        } else {
                                            
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            timetest = strDate
                                            
                                        }
                                        
                                        
                                        
                                        
                                        if let selftestType_00 = subJson["selfTests"].array?[mymin0]["selfTestType"].string{
//                                            print("selfTestType",selftestType_00)
                                            
//                                            print("strDate",timetest)
                                            
                                            
//                                            print("uniqeSelfTestId",selftestid_00 ?? "N/A")
                                            
                                            
                                            
                                            //                            let selftestID = String(describing: selftestid_00)
                                            
                                            let stringid = """
                                          "uniqeSelfTestId":
                                          """
                                            selftestData.append("{" + stringid + "\""  + selftestid + "\"" + "," + " \"selfTestMessage\"" + " : " + "\"" + selfTestMessage_00 + "\"" +  "," + " \"hasRedErrors\"" + " : " + "\"" + hasRedErrorsString + "\"" +  "," + " \"hasBatteryError\"" + " : " + "\"" + hasBatteryErrorString + "\"" + "," + " \"hasWarningsString\"" + " : " + "\"" + hasWarningsString + "\"" + "," + " \"strDate\"" + " : " + "\"" + timetest + "\"" + "," + " \"selfTestType\"" + " : " + "\"" + selftestType_00 + "\"" + "}" + ",")
                                            
                                            selftestDataInfo = "[" + selftestData + "]"
                                            
                                            let greenData = selftestDataInfo
                                            let url = getDocumentsDirectory().appendingPathComponent("SelfTest.json")
                                            
                                            do {
                                                try greenData.write(to: url, atomically: true, encoding: .utf8)
                                                //MARK: Uncomment for debugging
                                                //                            let input = try String(contentsOf: url)
                                                //                            print(input)
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                            
                                            mymin0 += 1
                                            //                            print(selfTestCount)
                                            print("ST After:\(mymin0)")
                                            //                                                        }
                                            //                                                    }
                                            //                                                }
                                            //                                            }
                                            //                                        }
                                        }
                                    }
                                }
                            }  else {
                                
                                //                        let statusNummaxnumber1 = selftestNum - 1
                                
                                
                                if selftestNum == 1 {
                                    //                            if let selftestid_00 = subJson["dailySelfTest"].array?[0]["uniqeSelfTestId"].string{
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                            
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                                    }
                                    
                                    //@AppStorage("defridetailSelfTest00Type") var defridetailSelfTest00Type: String?
                                    
                                    
                                    
                                } else if selftestNum == 2 {
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_01",selftestid_01)
                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                            
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        } else {
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        }
                                        
                                    }
                                    
                                    //                            }
                                    
                                } else {
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_00",selftestid_00)
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                                    }
                                    if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_01",selftestid_01)
                                        UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                                    }
                                    if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
                                        //                        print("selftestid_02",selftestid_02)
                                        UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
                                    }
                                    
                                    if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                        UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                                    }
                                    
                                    if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                            
                                        }else {
                                            let myInt1 = Int(selftestdate_00)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                        }
                                    }
                                    if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        } else {
                                            let myInt1 = Int(selftestdate_01)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                        }
                                        
                                    }
                                    if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            print("Yes, daylight saving time at a given date")
                                            let myInt1 = Int(selftestdate_02)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                        }else {
                                            let myInt1 = Int(selftestdate_02)
                                            let unixTimestamp = myInt1
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        //                }
                        
                        
                        
                        //                    if selftestid_empty == "" {
                        //                        print("NOTHING")
                        //                    }
                        //TODO: Hanlde emnpty rows
                        
                        
                        if let ownerid = subJson["ownerId"].string {
                            print("Ownerid_N:",ownerid)
                            UserDefaults.standard.set(ownerid, forKey: "defridetailOwner")
                            let defiId = subJson["defiId"].stringValue
                            print("DefiId_N:",defiId)
                            UserDefaults.standard.set(defiId, forKey: "defridetailID")
                            
                            let defiModel = subJson["model"].stringValue
                            print("DefiModel_N:",defiModel)
                            UserDefaults.standard.set(defiModel, forKey: "defridetailModel")
                            
                            let ownerName = subJson["ownerName"].stringValue
                            print("ownerName:",ownerName)
                            UserDefaults.standard.set(ownerName, forKey: "defridetailownerName")
                            let defiSerialId = subJson["serial"].stringValue
                            print("defiId_SN:",defiSerialId)
                            UserDefaults.standard.set(defiSerialId, forKey: "defridetailSerial")
                            let description = subJson["description"].string
                            print("Description:", description ?? "..")
                            UserDefaults.standard.set(description, forKey: "defridetailDescription")
                            
                            let status = subJson["adminStatus"].dictionaryValue
                            for (key, value) in status {
                                
                                if key == "status" {
                                    
                                    let whatStatusImage = value
                                    
                                    switch whatStatusImage {
                                    case 0:
                                        UserDefaults.standard.set("heart_green", forKey: "statusImage")
                                        UserDefaults.standard.set("Operational", forKey: "defridetailStatusValue")
                                        
                                    case 1:
                                        UserDefaults.standard.set("heart_green", forKey: "statusImage")
                                        UserDefaults.standard.set("Monitored", forKey: "defridetailStatusValue")
                                        
                                        
                                    case 2:
                                        UserDefaults.standard.set("heart_red", forKey: "statusImage")
                                        UserDefaults.standard.set("Defective", forKey: "defridetailStatusValue")
                                        
                                        
                                    case 3:
                                        UserDefaults.standard.set("heart_red", forKey: "commstatusImage")
                                        UserDefaults.standard.set("Disabled", forKey: "defridetailStatusValue")
                                        
                                    default:
                                        UserDefaults.standard.set("aed", forKey: "statusImage")
                                    }
                                    
                                    
                                }
                            }
                            
                            let adminStatus = subJson["dashboardState"].dictionaryValue
                            for (key, value) in adminStatus {
                                
                                if key == "stateReason" {
                                    print("BBO", value)
                                    let whatStatus = value.string
                                    UserDefaults.standard.set(whatStatus, forKey: "defridetailAdminStatusReason")
                                }
                                
                                
                                if key == "dashboardState" {
                                    
                                    let whatStatusImage = value
                                    
                                    switch whatStatusImage {
                                    case 0:
                                        UserDefaults.standard.set(0, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Available", forKey: "defridetailAdminStatusValue")
                                        
                                    case 1:
                                        UserDefaults.standard.set(1, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Overdue", forKey: "defridetailAdminStatusValue")
                                        
                                    case 2:
                                        UserDefaults.standard.set(2, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Timeout", forKey: "defridetailAdminStatusValue")
                                        
                                    case 3:
                                        UserDefaults.standard.set(3, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Warning", forKey: "defridetailAdminStatusValue")
                                        
                                    case 4:
                                        UserDefaults.standard.set(4, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Error", forKey: "defridetailAdminStatusValue")
                                        
                                        
                                    case 5:
                                        UserDefaults.standard.set(5, forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("Not monitored", forKey: "defridetailAdminStatusValue")
                                        
                                    default:
                                        UserDefaults.standard.set("aed", forKey: "statusImage")
                                    }
                                    
                                    
                                }
                            }
                            //NEW
                            let pairedCommunicators = subJson["pairedCommunicator"].dictionaryValue
                            for (key, value) in pairedCommunicators {
                                
                                //MARK: communicatorId
                                if key == "communicatorId" {
                                    print("Communicator Id: ", value)
                                    
                                    UserDefaults.standard.set(value.string, forKey: "defridetailpairingID")
                                    
                                    
                                    UserDefaults.standard.set(value.string, forKey: "OVERVIEWCOMMID")
                                    
                                    
                                    
                                }
                                
                                if key == "communicatorSerial" {
                                    
                                    print("Communicator Serial: ", value)
                                    
                                    UserDefaults.standard.set(value.string, forKey: "defidetailpairingSerial")
                                }
                                
                                if key == "pairingDate" {
                                    
                                    let initialBootupDate = value.stringValue
                                    
                                    let myString = "\(initialBootupDate)"
                                    let myInt: Int = Int(myString) ?? 0000
                                    print("pairingDate: ", myInt)
                                    let pcbProdDate = myInt //myString.int
                                    let myInt1 = pcbProdDate//Int(value)
                                    let unixTimestamp = myInt1 //value.int!
                                    
                                    if myInt == 0 {
                                        
                                        UserDefaults.standard.set("N/A", forKey: "defridetailpairingDate")
                                        
                                    } else {
                                    
                                    
                                    let timeZone = TimeZone(abbreviation: "GMT")!
                                    if timeZone.isDaylightSavingTime(for: Date()) {
                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000))
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                        dateFormatter.locale = NSLocale.current
                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //Specify your format that you want
                                        let strDate = dateFormatter.string(from: date)
                                        
                                        print("StatusDate:", strDate)
                                        
                                        UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                                    }else {
                                        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 7200))
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                        dateFormatter.locale = NSLocale.current
                                        dateFormatter.dateFormat = "MMM d, yyyy h:mm a" //Specify your format that you want
                                        let strDate = dateFormatter.string(from: date)
                                        
                                        print("StatusDate:", strDate)
                                        
                                        UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                                    }
                                    }
                                }
                            }
                        }
                        
                        if overview == "YES" {
                            
                            CommGetsingleDataOverview()
                            getSIMcardDataOverview()
                            getCommhardwaredata()

                            
                        }
                        
                        //                        }
                        //                        }
                        //                    }
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW DEFI GETSINGLEDATA")
                    UserDefaults.standard.set("YES", forKey: "WaitForItOverview")
                    
                }
            }
        
//        getmovementData()
        
    } else {
        
        
        //        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        
        var dailytest00: String = ""
        var dailytest01: String = ""
        var dailytest02: String = ""
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        print("NOT:\(String(describing: selectedDefi))")
        
        baseUser = email!
        basePass = password!
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "defibrillators/"
        let theone =  selectedDefi ?? ""
        let seltest = "?maxDailySelfTests=3"
        let url = myURL! + comLink + theone + seltest
        
        let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
        let base64Credentials = credentialData.base64EncodedString()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
            .responseData {response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    for (index,subJson):(String, JSON) in json {
                        print("defi:\(index) 2:\(subJson)")
                        
                        
                        if let description4 = json["pairedCommunicators"].arrayObject {
//                            print("QQ", description4)
//                            print("QQ", description4.count)
                            for obj in description4 {
                                if let dict = obj as? NSDictionary {
                                    // Now reference the data you need using:
                                    let id = dict.value(forKey: "communicatorId")
                                    let pair = dict.value(forKey: "pairingDate")
                                    print("communicatorId", id ?? ".." , "pairingDate", pair ?? ".." )
                                    UserDefaults.standard.set(id, forKey: "defridetailpairingID")
                                    UserDefaults.standard.set(pair, forKey: "defridetailpairingDate")
                                }
                            }
                            
                        } else {
                            
                            let defibrillatorId =  json["pairedCommunicators"].arrayValue.map {$0["communicatorId"].stringValue}
                            print("CommunicatorId Id:", defibrillatorId as Any)
                            //org
                            if defibrillatorId == []  {
                                print("defibrillatorId EMPTY")
                                UserDefaults.standard.set("N/A", forKey: "defridetailpairingID")
                            } else {
                                
                                print("defibrillatorId EMPTY")
                                UserDefaults.standard.set(defibrillatorId[0], forKey: "defridetailpairingID")
                            }
                            
                            let pairingDateDefi =  json["pairedCommunicators"].arrayValue.map {$0["pairingDate"].string}
                            print("Pairing Date Comm:", pairingDateDefi as Any)
                            
                            if pairingDateDefi == []  {
                                UserDefaults.standard.set("N/A", forKey: "defridetailpairingDate")
                                print("EMPTY")
                            } else {
                                
                                let z1eroKey = pairingDateDefi[0]
                                print("Defi Date:\(z1eroKey ?? "..")")
                                let zerofinalDate = z1eroKey?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                                print("0 Defi Date:\(zerofinalDate ?? "..")")
                                UserDefaults.standard.set(zerofinalDate, forKey: "defridetailpairingDate")
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    if let ownerid = json["ownerId"].string {
                        print("Ownerid:",ownerid)
                        let owner = json["@id"]
                        print("@id:" ,owner)
                        let description = json["description"]["en"].string
                        print("Description:", description ?? "..")
                        
                        let status = json["status"].dictionaryValue
                        print("Status:",status as Any)
                        
                        let sorted = status.sorted(by: { $0.key > $1.key })
                        print("Status 2:",sorted as Any)
                        
                        
                        let firstKey =  Array(arrayLiteral: sorted[0])[0].key
                        print("Current Status Date:\(firstKey)")
                        let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                        print("Current Status Status:\(firstValue)")
                        
                        let whatStatusImage = firstValue
                        
                        switch whatStatusImage {
                        case "available":
                            UserDefaults.standard.set("heart_green", forKey: "statusImage")
                            
                        case "overdue":
                            UserDefaults.standard.set("heart_yellow", forKey: "statusImage")
                            
                        case "warning":
                            UserDefaults.standard.set("heart_yellow", forKey: "statusImage")
                            
                        case "preError":
                            UserDefaults.standard.set("heart_yellow", forKey: "commstatusImage")
                            
                        case "error":
                            UserDefaults.standard.set("heart_red", forKey: "statusImage")
                            
                        case "timeout":
                            UserDefaults.standard.set("heart_red", forKey: "statusImage")
                            
                        case "unknown":
                            UserDefaults.standard.set("heart_yellow", forKey: "statusImage")
                            
                        default:
                            UserDefaults.standard.set("aed", forKey: "statusImage")
                        }
                        
                        let adminStatus = json["adminStatus"].dictionaryValue
                        print("AdminStatus:",adminStatus as Any)
                        
                        let adminsorted = adminStatus.sorted(by: { $0.key > $1.key })
                        print("AdminStatus Sorted:",adminsorted as Any)
                        
                        let adminfirstKey =  Array(arrayLiteral: adminsorted[0])[0].key
                        print("Admin Status Date:\(adminfirstKey)")
                        let adminfirstValue =  Array(arrayLiteral: adminsorted[0])[0].value
                        print("Admin Status Status:\(adminfirstValue)")
                        
                        
                        
                        UserDefaults.standard.set(json["ownerId"].stringValue, forKey: "defridetailOwner")
                        UserDefaults.standard.set(json["@id"].stringValue, forKey: "defridetailID")
                        UserDefaults.standard.set(json["description"]["en"].string, forKey: "defridetailDescription")
                        UserDefaults.standard.set(firstValue.string, forKey: "defridetailStatusValue")
                        UserDefaults.standard.set(adminfirstValue.string, forKey: "defridetailAdminStatusValue")
                        
                        let dailySelfTests = json["dailySelfTests"].dictionaryValue
                        
                        print(dailySelfTests.count)
                        
                        
                        let selftestCount = dailySelfTests.count
                        
                        switch selftestCount {
                        case 1:
                            let sortedSelfTest = dailySelfTests.sorted(by: { $0.key > $1.key })
                            
                            let zeroKey =  Array(arrayLiteral: sortedSelfTest[0])[0].key
                            print("0 SELFTEST Date:\(zeroKey)")
                            let zerofinalDate = zeroKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let zeroValue =  Array(arrayLiteral: sortedSelfTest[0])[0].value
                            print("0 SELFTEST Link:\(zeroValue)")
                            
                            let zerolinkvalue =  Array(zeroValue)[0].1
                            print("0 SELFTEST:\(zerolinkvalue)")
                            
                            dailytest00 = zerolinkvalue.stringValue
                            
                            UserDefaults.standard.set(zerofinalDate, forKey: "defridetailSelfTest00Date")
                            UserDefaults.standard.set(dailytest00, forKey: "defridetailSelfTest00Value")
                            
                        case 2:
                            let sortedSelfTest = dailySelfTests.sorted(by: { $0.key > $1.key })
                            
                            let zeroKey =  Array(arrayLiteral: sortedSelfTest[0])[0].key
                            print("0 SELFTEST Date:\(zeroKey)")
                            let zerofinalDate = zeroKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let zeroValue =  Array(arrayLiteral: sortedSelfTest[0])[0].value
                            print("0 SELFTEST Link:\(zeroValue)")
                            
                            let zerolinkvalue =  Array(zeroValue)[0].1
                            print("0 SELFTEST:\(zerolinkvalue)")
                            
                            dailytest00 = zerolinkvalue.stringValue
                            
                            UserDefaults.standard.set(zerofinalDate, forKey: "defridetailSelfTest00Date")
                            UserDefaults.standard.set(dailytest00, forKey: "defridetailSelfTest00Value")
                            
                            
                            let firstKey =  Array(arrayLiteral: sortedSelfTest[1])[0].key
                            print("1 SELFTEST Date:\(firstKey)")
                            let firstfinalDate = firstKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let firstValue =  Array(arrayLiteral: sortedSelfTest[1])[0].value
                            print("1 SELFTEST Link:\(firstValue)")
                            
                            let firstlinkvalue =  Array(firstValue)[0].1
                            print("1 SELFTEST:\(firstlinkvalue)")
                            
                            dailytest01 = firstlinkvalue.stringValue
                            
                            UserDefaults.standard.set(firstfinalDate, forKey: "defridetailSelfTest01Date")
                            UserDefaults.standard.set(dailytest01, forKey: "defridetailSelfTest01Value")
                            
                        case 3:
                            
                            let sortedSelfTest = dailySelfTests.sorted(by: { $0.key > $1.key })
                            
                            let zeroKey =  Array(arrayLiteral: sortedSelfTest[0])[0].key
                            print("0 SELFTEST Date:\(zeroKey)")
                            let zerofinalDate = zeroKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let zeroValue =  Array(arrayLiteral: sortedSelfTest[0])[0].value
                            print("0 SELFTEST Link:\(zeroValue)")
                            
                            let zerolinkvalue =  Array(zeroValue)[0].1
                            print("0 SELFTEST:\(zerolinkvalue)")
                            
                            dailytest00 = zerolinkvalue.stringValue
                            
                            UserDefaults.standard.set(zerofinalDate, forKey: "defridetailSelfTest00Date")
                            UserDefaults.standard.set(dailytest00, forKey: "defridetailSelfTest00Value")
                            
                            
                            let firstKey =  Array(arrayLiteral: sortedSelfTest[1])[0].key
                            print("1 SELFTEST Date:\(firstKey)")
                            let firstfinalDate = firstKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let firstValue =  Array(arrayLiteral: sortedSelfTest[1])[0].value
                            print("1 SELFTEST Link:\(firstValue)")
                            
                            let firstlinkvalue =  Array(firstValue)[0].1
                            print("1 SELFTEST:\(firstlinkvalue)")
                            
                            dailytest01 = firstlinkvalue.stringValue
                            
                            UserDefaults.standard.set(firstfinalDate, forKey: "defridetailSelfTest01Date")
                            UserDefaults.standard.set(dailytest01, forKey: "defridetailSelfTest01Value")
                            
                            let secondKey =  Array(arrayLiteral: sortedSelfTest[2])[0].key
                            print("2 SELFTEST Date:\(secondKey)")
                            let secondfinalDate = secondKey.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                            
                            let secondValue =  Array(arrayLiteral: sortedSelfTest[2])[0].value
                            print("2 SELFTEST Link:\(secondValue)")
                            
                            let secondlinkvalue =  Array(secondValue)[0].1
                            print("2 SELFTEST:\(secondlinkvalue)")
                            
                            dailytest02 = secondlinkvalue.stringValue
                            
                            UserDefaults.standard.set(secondfinalDate, forKey: "defridetailSelfTest02Date")
                            UserDefaults.standard.set(dailytest02, forKey: "defridetailSelfTest02Value")
                            
                        case 0:
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest00Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest00Value")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest01Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest01Value")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest02Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest03Value")
                            
                        default:
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest00Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest00Value")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest01Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest01Value")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest02Date")
                            UserDefaults.standard.set(" N/A ", forKey: "defridetailSelfTest03Value")
                        }
                        
                    }
                    
                    print("YESSSSSSS")
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD DEFI DE")
                    
                }
            }
        
        
        
    }
    
    
    
}

