//
//  MessagesData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 09.03.21.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: String?
    var context: String?
    var timestamp, eventTrackingID, sender: String?
    var defibrillatorID: String?
    var messageTimestamp: String?
    var communicatorID: String?
    var communicatorBatteryLevel, defibrillatorBatteryLevel, transmissionAttempts: Int?
    var cryptoHash, errorReportPart: String?
    var messagePartNumber: Int?
    var motionDetected: Bool?
    var lat, lng: String?
    var selfTestResult: String?
    var transmissions: Int?
    var signalStrength: Int?
    var success, aedVisibileOnBluetooth, isBatteryError, isUncriticalError: Bool?
    var isRedError: Bool?
    var category, message, firmwareVersion: String?
    var mcc, mnc, mno, bluetoothMACAddress, defibrillatorTimestamp: String?
    var imei, imsi, defibrillatorModel, communicatorModel, bluetoothChipsetStatus, cellularModemStatus: String?
    var defibrillatorBluetoothMACAddress, defibrillatorFirmwareVersion: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case context = "@context"
        case timestamp = "timestamp"
        case eventTrackingID = "eventTrackingId"
        case sender
        case defibrillatorID = "defibrillatorId"
        case messageTimestamp
        case communicatorID =  "communicatorId"
        case communicatorBatteryLevel, defibrillatorBatteryLevel, transmissionAttempts, cryptoHash, errorReportPart, messagePartNumber, motionDetected, lat, lng, selfTestResult, transmissions, signalStrength,success
        case aedVisibileOnBluetooth = "AEDVisibileOnBluetooth"
        case isBatteryError, isUncriticalError, isRedError, category, message //confirmation
        case mno = "MNO"
        case mcc = "MCC"
        case mnc = "MNC"
        case imei = "IMEI"
        case imsi = "IMSI"
        case bluetoothMACAddress, firmwareVersion, defibrillatorModel, communicatorModel, cellularModemStatus, defibrillatorTimestamp, bluetoothChipsetStatus
        case defibrillatorBluetoothMACAddress, defibrillatorFirmwareVersion
    }
}
enum SelfTestType: String, Codable {
    case daily = "DAILY"
    case monthly = "MONTHLY"
}
typealias Messages = [Message]


