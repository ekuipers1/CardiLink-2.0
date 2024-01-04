//
//  BluetoothManger.swift
//  BLE_NK
//
//  Created by Erik Kuipers on 19.10.21.
//

import SwiftUI
import Foundation
import CoreBluetooth

let Mytest = CBUUID(string: "2A03")
let UserD = CBUUID(string: "181C")

fileprivate var ledMask: UInt8 = 0
fileprivate let digitalBits = 2

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var cbCentralManager : CBCentralManager!
    var peripheral : CBPeripheral?
    
    @State private var showingAlert = false
    
    override init() {
        super.init()
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        cbCentralManager.delegate = self
        
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On.")
            central.scanForPeripherals(withServices: nil, options: nil)
        case .unsupported:
            UserDefaults.standard.set("Is Unsupported.", forKey: "ble_state")
        case .unauthorized:
            UserDefaults.standard.set("Is Unauthorized.", forKey: "ble_state")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name != nil else {return}

        @AppStorage("connection_ble") var stopscanning: String?
        
        if stopscanning == "False" {
            if peripheral.name!.contains("HCII-") || peripheral.name!.contains("NINA-") {
                cbCentralManager.stopScan()
                cbCentralManager.connect(peripheral, options: nil)
                self.peripheral = peripheral
            } else {
            }
        }    else {
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        @Binding var isOn: Bool

        peripheral.discoverServices([UserD])
        peripheral.delegate = self
    
    }
    
    func disconnect(peripheral: CBPeripheral) {
        cbCentralManager.cancelPeripheralConnection(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected : \(peripheral.name ?? "No Name")")
        cbCentralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        @AppStorage("MYPIN") var newpin: String?
        
        if characteristic.uuid == Mytest {
            
            let data = (characteristic.value)!
            let strHex = newpin
            let responstringHex = (data.hexEncodedString())
            
            if strHex!.toHexEncodedString() == responstringHex {
                cbCentralManager.cancelPeripheralConnection(peripheral)
                UserDefaults.standard.set("True", forKey: "connection_ble")
                
            } else {
                UserDefaults.standard.set("False", forKey: "connection_ble")
            }
        }
        if error != nil {
            
            print("error :")
            return
        }
    }
    
    func setDigitalOutput(_ index: Int, on: Bool, characteristic  :CBCharacteristic) {
        
        @AppStorage("MYPIN") var newpin: String?
        
        let cafe: Data? = newpin!.data(using: .utf8)
        let bytes: Data = cafe!
        
        self.peripheral?.writeValue(cafe!, for: characteristic, type: .withResponse)
        
        if cafe! == bytes {
            
            UserDefaults.standard.set(peripheral?.name, forKey: "bteName")
            UserDefaults.standard.set("OK", forKey: "ConnectionSuccess")
            
            self.peripheral?.readValue(for: characteristic)
            
        } else {
            print("NOPS")
            UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
            UserDefaults.standard.set("NOPS", forKey: "name")
            UserDefaults.standard.set("NO", forKey: "ConnectionSuccess")
        }
        
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        } else {
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if let charac = service.characteristics {
            for characteristic in charac {
                
                if characteristic.uuid == Mytest {
                    setDigitalOutput(1, on: true, characteristic: characteristic)
                    
                    peripheral.readValue(for: characteristic)
                    peripheral.setNotifyValue(true, for: characteristic)
                    
                }
            }
        }
        
    }
    
}



