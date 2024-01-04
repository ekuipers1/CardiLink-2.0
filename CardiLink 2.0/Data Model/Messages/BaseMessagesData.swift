//
//  BaseMessagesData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 12.05.23.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit
import SwiftUI

struct DefibrillatorMessagesResponse: Codable {
    let success: Bool
    let data: [DefibrillatorMessages]
}
struct DefibrillatorMessages: Codable, Identifiable {
    let id = UUID()
    let defibrillatorId: String
    let timeStamp: Double
    let messageId: String
    let messageType: String
    let transmissionAttempts: Int?
    let CommunicatorBatteryLevel: Int?
    let DefibrillatorBatteryLevel: Int?
    let pairingWasSuccessfull: Bool?
    let pairedCommunicatorId: String?
    let pairedCommunicatorSerial: String?
    let pairedDefibrillatorId: String?
    let pairedDefibrillatorSerial: String?
    let padExpirationDate: Int?
    let defibrillatorModel: String?
    let defibrillatorMacAddress: String?
    let batteryModel: String?
    let batterySerialNumber: String?
    let mainBatteryExpirationDate: Int?
    let activationDate: Int?
    let adminStatus: Int?
    let hasBatteryError: Bool?
    let hasRedErrors: Bool?
    let hasWarnings: Bool?
    let selfTestMessage: String?
    let defibrillatorWasVisibleViaBluetooth: Bool?
    let errorCategory: String?
    let errorMessage: String?
    let coverIsOpened: Bool?
    let aedInMotion: Bool?
    let gpsLat: Double?
    let gpsLon: Double?
    let operatorValue: String?
    let countryCode: String?
    let signalStrength: Int?
    let success: String?


    struct MessageTypeInfo {
            let text: String
            let color: Color
        }
    func formattedMessageType() -> MessageTypeInfo {
        
        switch messageType {
        case "DAILY":
            return MessageTypeInfo(text: "Daily", color: .Calming_Green)
        case "GPS":
            return MessageTypeInfo(text: "GPS", color: .Cardi_MapBlue)
        case "AEDCOVEROPEN":
            return MessageTypeInfo(text: "AED Cover Open", color: .Cardi_Yellow)
        case "SYNCED":
            return MessageTypeInfo(text: "Synced", color: .Calming_Green)
        case "PAIRED":
            return MessageTypeInfo(text: "Paired", color: .Calming_Green)
        case "ALARM":
            return MessageTypeInfo(text: "Alarm", color: .Cardi_Yellow)
        case "MONTHLY":
            return MessageTypeInfo(text: "Monthly", color: .Calming_Green)
        case "YEARLY":
            return MessageTypeInfo(text: "Yearly", color: .Calming_Green)
        case "NETWORKINGREPORT":
            return MessageTypeInfo(text: "Networking Report", color: .colorCardiOrange)
        case "BOOTUP":
            return MessageTypeInfo(text: "Bootup", color: .Cardi_Text)
        case "ERROR":
            return MessageTypeInfo(text: "ERROR", color: .colorCardiRed)
        case "AEDINMOTION":
            return MessageTypeInfo(text: "Motion", color: .Cardi_Yellow)
        default:
            return MessageTypeInfo(text: "Unknown", color: .Cardi_Text)
        }
    }
    func formattedTimestamp() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d yyyy hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.isLenient = true

            let date = Date(timeIntervalSince1970: timeStamp / 1000)
            return dateFormatter.string(from: date)
        }
    
}
func fetchDefibrillatorsMessages(completion: @escaping (DefibrillatorMessagesResponse?) -> Void) {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillatorsMessages = "messages?defibrillatorid="
    let theone =  selectedDefi ?? ""
    let url_defiMes = myURL! + myDefibrillatorsMessages + theone + "&pagesize=100"
    
    
    let headers: HTTPHeaders = [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
    
    AF.request(url_defiMes, headers: headers).responseDecodable(of: DefibrillatorMessagesResponse.self) { response in
        switch response.result {
        case .success(let defibrillators):
            completion(defibrillators)
        case .failure(let error):
            print(error)
            completion(nil)
        }
    }
}
