//
//  MessagesDataFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 12.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON

func getMessagesDetailData() {
    
    let defaults = UserDefaults.standard
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let myURL = defaults.string(forKey: "myPortal")
    let authKey = AuthKey!
    let myDefibrillatorsMessages = "messages/"
    let theone =  defaults.string(forKey: "selectedMessage")!
    let url_defiMes = myURL! + myDefibrillatorsMessages + theone
    
    AF.request(url_defiMes, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                if let ownerid = subJson["messageId"].string {
                    let coverIsOpened = subJson["coverIsOpened"].bool
                    UserDefaults.standard.set(coverIsOpened, forKey: "message_CoverOpen")
                    let message_bateryErrors = subJson["hasBatteryError"].bool
                    UserDefaults.standard.set(message_bateryErrors, forKey: "message_bateryErrors")
                    let message_redErrors = subJson["hasRedErrors"].bool
                    UserDefaults.standard.set(message_redErrors, forKey: "message_redErrors")
                    let message_warnings = subJson["hasWarnings"].bool
                    UserDefaults.standard.set(message_warnings, forKey: "message_warnings")
                    let selfTestMessage = subJson["selfTestMessage"].string
                    UserDefaults.standard.set(selfTestMessage, forKey: "message_selfTestResult")
                    let defibrillatorWasVisibleViaBluetooth = subJson["defibrillatorWasVisibleViaBluetooth"].bool
                    UserDefaults.standard.set(defibrillatorWasVisibleViaBluetooth, forKey: "message_aedVisibileOnBluetooth")
                    let defibrillatorModel = subJson["defibrillatorModel"].string
                    UserDefaults.standard.set(defibrillatorModel, forKey: "message_defibrillatorModel")
                    let defibrillatorMacAddress = subJson["defibrillatorMacAddress"].string
                    UserDefaults.standard.set(defibrillatorMacAddress, forKey: "message_defibrillatorMacAddress")
                    let padExpirationDate = subJson["padExpirationDate"].int
                    if padExpirationDate == nil {
                        UserDefaults.standard.set("Unknown", forKey: "message_padExpirationDate")
                    } else {
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myInt1 = padExpirationDate //Int(message_defibrillatorTimestamp!)
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "message_padExpirationDate")
                        } else {
                            
                            let myInt1 = padExpirationDate
                            let unixTimestamp = myInt1
                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp! / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDate = dateFormatter.string(from: date)
                            UserDefaults.standard.set(strDate, forKey: "message_padExpirationDate")
                        }
                    }
                    let batteryModel = subJson["batteryModel"].string
                    UserDefaults.standard.set(batteryModel, forKey: "message_batteryModel")
                    
                    let batterySerialNumber = subJson["batterySerialNumber"].string
                    UserDefaults.standard.set(batterySerialNumber, forKey: "message_batterySerialNumber")
                    
                    let mainBatteryExpirationDate = subJson["mainBatteryExpirationDate"].int
                    
                    if mainBatteryExpirationDate == nil {
                        UserDefaults.standard.set("Unknown", forKey: "message_mainBatteryExpirationDate")
                        
                    } else {
                        
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myBatteryExpirationDate = mainBatteryExpirationDate
                            let unixTimestampBatteryExpirationDate = myBatteryExpirationDate
                            let dateBatteryExpirationDate = Date(timeIntervalSince1970: TimeInterval(unixTimestampBatteryExpirationDate! / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDateBatteryExpirationDate = dateFormatter.string(from: dateBatteryExpirationDate)
                            UserDefaults.standard.set(strDateBatteryExpirationDate, forKey: "message_mainBatteryExpirationDate")
                        } else {
                            let myBatteryExpirationDate = mainBatteryExpirationDate
                            let unixTimestampBatteryExpirationDate = myBatteryExpirationDate
                            let dateBatteryExpirationDate = Date(timeIntervalSince1970: TimeInterval(unixTimestampBatteryExpirationDate! / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDateBatteryExpirationDate = dateFormatter.string(from: dateBatteryExpirationDate)
                            UserDefaults.standard.set(strDateBatteryExpirationDate, forKey: "message_mainBatteryExpirationDate")
                        }
                    }
                    
                    let mainBatteryactivationDate = subJson["activationDate"].int
                    if mainBatteryactivationDate == nil {
                        UserDefaults.standard.set("Unknown", forKey: "message_activationDate")
                        
                    } else {
                        
                        let timeZone = TimeZone(abbreviation: "GMT")!
                        if timeZone.isDaylightSavingTime(for: Date()) {
                            let myBatteryactivationDate = mainBatteryactivationDate
                            let unixTimestampBatteryactivationDate = myBatteryactivationDate
                            let dateBatteryactivationDate = Date(timeIntervalSince1970: TimeInterval(unixTimestampBatteryactivationDate! / 1000))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDateBatteryactivationDate = dateFormatter.string(from: dateBatteryactivationDate)
                            UserDefaults.standard.set(strDateBatteryactivationDate, forKey: "message_activationDate")
                        } else {
                            let myBatteryactivationDate = mainBatteryactivationDate
                            let unixTimestampBatteryactivationDate = myBatteryactivationDate
                            let dateBatteryactivationDate = Date(timeIntervalSince1970: TimeInterval(unixTimestampBatteryactivationDate! / 1000 + 3600))
                            let dateFormatter = DateFormatter()
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            dateFormatter.locale = NSLocale.current
                            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                            let strDateBatteryactivationDate = dateFormatter.string(from: dateBatteryactivationDate)
                            UserDefaults.standard.set(strDateBatteryactivationDate, forKey: "message_activationDate")
                        }
                    }
                    
                    let gpsLat = subJson["gpsLat"].double
                    UserDefaults.standard.set(gpsLat, forKey: "message_lat")
                    
                    let gpsLon = subJson["gpsLon"].double
                    UserDefaults.standard.set(gpsLon, forKey: "message_lng")
                    
                    let pairingWasSuccessfull = subJson["pairingWasSuccessfull"].bool
                    UserDefaults.standard.set(pairingWasSuccessfull, forKey: "message_success")
                    
                    let pairedCommunicatorSerial = subJson["pairedCommunicatorSerial"].string
                    UserDefaults.standard.set(pairedCommunicatorSerial, forKey: "message_pairedCommunicatorSerial")
                    
                    let pairedDefibrillatorSerial = subJson["pairedDefibrillatorSerial"].string
                    UserDefaults.standard.set(pairedDefibrillatorSerial, forKey: "message_pairedDefibrillatorSerial")
                    
                    let CommunicatorBatteryLevel = subJson["CommunicatorBatteryLevel"].int
                    UserDefaults.standard.set(CommunicatorBatteryLevel, forKey: "message_communicatorBatteryLevel")
                    
                    let DefibrillatorBatteryLevel = subJson["DefibrillatorBatteryLevel"].int
                    UserDefaults.standard.set(DefibrillatorBatteryLevel, forKey: "message_defibrillatorBatteryLevel")
                    
                    
                    let mobileoperator = subJson["operator"].string
                    UserDefaults.standard.set(mobileoperator, forKey: "message_mno")
                    
                    let mobilecountryCode = subJson["countryCode"].string
                    UserDefaults.standard.set(mobilecountryCode, forKey: "message_mcc")
                    
                    let mobilecsignalStrength = subJson["signalStrength"].int
                    UserDefaults.standard.set(mobilecsignalStrength, forKey: "message_signalStrength")
                    
                    let message_imei = subJson["imei"].string
                    UserDefaults.standard.set(message_imei, forKey: "message_imei")
                    
                    let message_imsi = subJson["imsi"].string
                    UserDefaults.standard.set(message_imei, forKey: "message_imsi")
                    
                    let message_bluetoothMACAddress = subJson["bluetoothMacAddress"].string
                    UserDefaults.standard.set(message_bluetoothMACAddress, forKey: "message_bluetoothMACAddress")
                    
                    let message_bluetoothChipsetStatus = subJson["bluetoothChipsetStatus"].bool
                    UserDefaults.standard.set(message_bluetoothChipsetStatus, forKey: "message_bluetoothChipsetStatus")
                    
                    let aedInMotion = subJson["aedInMotion"].bool
                    UserDefaults.standard.set(aedInMotion, forKey: "aedInMotion")
                    
                    let errorCategory = subJson["errorCategory"].string
                    UserDefaults.standard.set(errorCategory, forKey: "message_category")
                    
                    let errorMessage = subJson["errorMessage"].string
                    UserDefaults.standard.set(errorMessage, forKey: "message_message")
                    
                }
            }
        case .failure(let error):
            print(error)
   
        }
    }
}
