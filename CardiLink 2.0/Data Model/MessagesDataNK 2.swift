//
//  MessagesDataNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 22.11.21.
//

import Foundation


// MARK: - MessagesNK
//struct MessagesNK: Decodable {
//    //    let id: String
//    //    let success: Bool
//    //    let error: NSNull
//    //    let errorCode: Int
//    let data: [DataNK]
//}

// MARK: - Datum
struct DataNK: Codable, Identifiable{
    //struct DataNK: Codable, Identifiable {
    
    var id: String?
    var timeStamp: String?
//    var messageId: String?
    var messageType: String?
    var transmissionAttempts: String?
//    var transmissionAttempts: Int?
//    var errorCategory: String?
//    var errorMessage: String?
//    var aedInMotion, imei, imsi, bluetoothChipsetStatus: String?
//    var bluetoothMACAddress, gpsLat, gpsLon: String?
//    var padExpirationDate: String?
//    var defibrillatorModel: String?
//    var defibrillatorMACAddress, batteryModel, batterySerialNumber: String?
//    var mainBatteryExpirationDate: String?
//    var activationDate: String?
//    var adminStatus: String?
//    var hasBatteryError, hasRedErrors, hasWarnings: Bool?
//    var selfTestMessage: String?
//    var defibrillatorWasVisibleViaBluetooth, coverIsOpened: Bool?
//    var pairingWasSuccessfull, pairedCommunicatorID, pairedCommunicatorSerial, pairedDefibrillatorID: String?
//    var pairedDefibrillatorSerial: String?
    
//    enum CodingKeys: String, CodingKey {
//
//        case id = "messageId"
//        //        case defibrillatorID
//        case timeStamp
////        case messageId
//        case messageType
//        case transmissionAttempts
//        case errorCategory
//        case errorMessage
//        case aedInMotion, imei, imsi, bluetoothChipsetStatus
//        case bluetoothMACAddress, gpsLat, gpsLon
//        case padExpirationDate
//        case defibrillatorModel
//        case defibrillatorMACAddress, batteryModel, batterySerialNumber
//        case mainBatteryExpirationDate
//        case activationDate
//        case adminStatus
//        case hasBatteryError, hasRedErrors, hasWarnings
//        case selfTestMessage
//        case defibrillatorWasVisibleViaBluetooth, coverIsOpened
//        case pairingWasSuccessfull, pairedCommunicatorID, pairedCommunicatorSerial, pairedDefibrillatorID
//        case pairedDefibrillatorSerial
//    }
    
}


//MARK:MESSAGESNK
