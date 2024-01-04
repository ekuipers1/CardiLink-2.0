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
    let overview = defaults.string(forKey: "Overview")
    var mymin0: Int = 0
    var timetest: String  = ""
    var selftestData: String = ""
    var selftestDataInfo : String = ""
    var baseUser = ""
    let email = defaults.string(forKey: "username")
    baseUser = email!
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
            for(index,subJson):(String, JSON) in json {
                let selftestid_empty =
                subJson["selfTests"].arrayValue
                if selftestid_empty == [] {
                } else {
                    let selftestNum = subJson["selfTests"].count
                    
                    if selftestNum > 3 {
                        if selftestNum == 1 {
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                let myInt1 = Int(selftestdate_00)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                            }
                            
                        } else if selftestNum == 2 {
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                            }
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                let myInt1 = Int(selftestdate_00) //Int(message_defibrillatorTimestamp!)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
                                
                                let myInt1 = Int(selftestdate_01)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            
                        } else {
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                            }
                            if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
                            }
                            if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                            }
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                let myInt1 = Int(selftestdate_00)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
                                let myInt1 = Int(selftestdate_01) //Int(message_defibrillatorTimestamp!)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current // Use the current system timezone
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
                                let myInt1 = Int(selftestdate_02) //Int(message_defibrillatorTimestamp!)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current // Use the current system timezone
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                        }
                        
                        let selfTestCount = 1
                        
                        for _ in selfTestCount...selftestNum {
                            let selftestid_00 = subJson["selfTests"].array?[mymin0]["uniqeSelfTestId"].string
                            let selftestid = String(describing: selftestid_00!)
                            let hasBatteryErrorString = String((subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool)!)
                            UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasBatteryError"].bool)!), forKey: "defridetailhasBatteryErrorOverview")
                            let hasWarningsString = String((subJson["selfTests"].array?[mymin0]["hasWarnings"].bool)!)
                            UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasWarnings"].bool)!), forKey: "defridetailSelfTesthasWarningsOverview")
                            let hasRedErrorsString = String((subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool)!)
                            UserDefaults.standard.set(String((subJson["selfTests"].array?[mymin0]["hasRedErrors"].bool)!), forKey: "defridetailSelfTesthasRedErrorsOverview")
                            let selfTestMessage = subJson["selfTests"].array?[mymin0]["selfTestMessage"].string
                            let selfTestMessage_00 = String(describing: selfTestMessage ?? "No Additional Info")
                            UserDefaults.standard.set(selfTestMessage_00, forKey: "message_selfTestResult")
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[mymin0]["date"].int{
                                
                                let myInt1 = Int(selftestdate_00)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                timetest = strDate
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                                
                                if let selftestType_00 = subJson["selfTests"].array?[mymin0]["selfTestType"].string{
                                    let stringid = """
                                          "uniqeSelfTestId":
                                          """
                                    
                                    let STID = "{" + stringid
                                    let STIDResult = "\""  + selftestid + "\""
                                    let STMessage = ","  + "\"selfTestMessage\"" + ":"
                                    let STMessageResult = "\""  + selfTestMessage_00 + "\""
                                    let STRed = ","  + "\"hasRedErrors\"" + ":"
                                    let STRedResult = "\""  + hasRedErrorsString + "\""
                                    let STBat = ","  + "\"hasBatteryError\"" + ":"
                                    let STBatResult = "\""  + hasBatteryErrorString + "\""
                                    let STWarning = ","  + "\"hasWarningsString\"" + ":"
                                    let STWarningResult = "\""  + hasWarningsString + "\""
                                    let STDate = ","  + "\"strDate\"" + ":"
                                    let STDateResult = "\""  + timetest + "\""
                                    let STType = ","  + "\"selfTestType\"" + ":"
                                    let STTypeResult = "\""  + selftestType_00 + "\"" + "},"
                                    
                                    let allSelftest = STID + STIDResult + STMessage + STMessageResult + STRed + STRedResult + STBat + STBatResult + STWarning + STWarningResult + STDate + STDateResult + STType + STTypeResult
                                    
                                    selftestData.append(allSelftest)
                                    selftestDataInfo = "[" + selftestData + "]"
                                    
                                    let greenData = selftestDataInfo
                                    let url = getDocumentsDirectory().appendingPathComponent("SelfTest.json")
                                    
                                    do {
                                        try greenData.write(to: url, atomically: true, encoding: .utf8)
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    mymin0 += 1
                                   
                                    
                                }
                            }
                        }
                    }  else {
                        
                        if selftestNum == 1 {
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                
                                let myInt1 = Int(selftestdate_00)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                            }
                            
                        } else if selftestNum == 2 {
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                            }
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                
                                let myInt1 = Int(selftestdate_00)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                            }
                            if let selftestdate_01 = subJson["statusNum"].array?[1]["date"].int{
                                let myInt1 = Int(selftestdate_01)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                                
                            }
                            
                        } else {
                            
                            if let selftestid_00 = subJson["selfTests"].array?[0]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Value")
                            }
                            if let selftestid_01 = subJson["selfTests"].array?[1]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_01, forKey: "defridetailSelfTest01Value")
                            }
                            if let selftestid_02 = subJson["selfTests"].array?[2]["uniqeSelfTestId"].string{
                                UserDefaults.standard.set(selftestid_02, forKey: "defridetailSelfTest02Value")
                            }
                            if let selftestid_00 = subJson["selfTests"].array?[0]["selfTestType"].string{
                                UserDefaults.standard.set(selftestid_00, forKey: "defridetailSelfTest00Type")
                            }
                            
                            if let selftestdate_00 = subJson["selfTests"].array?[0]["date"].int{
                                
                                let timeZone = TimeZone(abbreviation: "GMT")!
                                if timeZone.isDaylightSavingTime(for: Date()) {
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
                                    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp / 1000 + 3600))
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                    dateFormatter.locale = NSLocale.current
                                    dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                    let strDate = dateFormatter.string(from: date)
                                    UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest00Date")
                                }
                            }
                            if let selftestdate_01 = subJson["selfTests"].array?[1]["date"].int{
                                
                                let myInt1 = Int(selftestdate_01)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest01Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                                
                            }
                            if let selftestdate_02 = subJson["selfTests"].array?[2]["date"].int{
                                
                                
                                let myInt1 = Int(selftestdate_02)
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailSelfTest02Date")
                                
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                                
                            }
                        }
                        
                    }
                }
                
                if let ownerid = subJson["ownerId"].string {
                    UserDefaults.standard.set(ownerid, forKey: "defridetailOwner")
                    let defiId = subJson["defiId"].stringValue
                    UserDefaults.standard.set(defiId, forKey: "defridetailID")
                    let defiModel = subJson["model"].stringValue
                    UserDefaults.standard.set(defiModel, forKey: "defridetailModel")
                    let ownerName = subJson["ownerName"].stringValue
                    UserDefaults.standard.set(ownerName, forKey: "defridetailownerName")
                    let defiSerialId = subJson["serial"].stringValue
                    UserDefaults.standard.set(defiSerialId, forKey: "defridetailSerial")
                    let description = subJson["description"].string
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
                                
                            case 6:
                                UserDefaults.standard.set(6, forKey: "defridetailAdminStatusColor")
                                UserDefaults.standard.set("Serviced", forKey: "defridetailAdminStatusValue")
                                
                            default:
                                UserDefaults.standard.set("aed", forKey: "statusImage")
                            }
                        }
                    }
                    let pairedCommunicators = subJson["pairedCommunicator"].dictionaryValue
                    for (key, value) in pairedCommunicators {
                        
                        if key == "communicatorId" {
                            let mycommid = value.string
                            UserDefaults.standard.set(mycommid, forKey: "defridetailpairingID")
                            
                            if overview == "YES" {
                                let mycommid = value.string
                                UserDefaults.standard.set(mycommid, forKey: "OVERVIEWCOMMID")
                                CommGetsingleDataOverview()
                                getCommhardwaredata()
                            }
                            
                        }
                        
                        if key == "communicatorSerial" {
                            UserDefaults.standard.set(value.string, forKey: "defidetailpairingSerial")
                        }
                        
                        if key == "pairingDate" {
                            
                            let initialBootupDate = value.stringValue
                            let myString = "\(initialBootupDate)"
                            let myInt: Int = Int(myString) ?? 0000
                            let pcbProdDate = myInt
                            let myInt1 = pcbProdDate
                            let unixTimestamp = myInt1
                            if myInt == 0 {
                                UserDefaults.standard.set("N/A", forKey: "defridetailpairingDate")
                                
                            } else {
                                
                                let date = Date(timeIntervalSince1970: TimeInterval(myInt1 / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                                let strDate = dateFormatter.string(from: date)
                                UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                                if TimeZone.current.isDaylightSavingTime(for: Date()) {
                                }
                                
                            }
                        }
                    }
                }
                
            }
        case .failure(let error):
            print(error)
            
        }
    }
    
}


