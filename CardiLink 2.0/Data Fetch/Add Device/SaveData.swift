//
//  SaveData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.09.23.
//

import Foundation
import Alamofire
import SwiftyJSON


func ADIspublicAvailable(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIsPubliclyAccessible"
    let finalURL = url_defi + (currentDefie ?? "0000000000") + endit
    
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "aedisPubAvailable")
    let myString = String(myBool)
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADIOkforShare(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIsPubliclyPermitted"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "isOKforShare")
    let myString = String(myBool)
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADMotionDetectionMode(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceMotionDetectionMode"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myString = UserDefaults.standard.string(forKey: "motionConfig")
    let parameters = myString
    let postData = parameters?.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADOutsideBuilding(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIsOutsideTheBuilding"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "AEDOutsideBuilding")
    let myString = String(myBool)
    
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADInsideCabinet(){
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIsInsideACabinet"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "AEDIsInsideCabinet")
    let myString = String(myBool)
    
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADCabinetWithPin(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceCabinetIsEquippedWithPinLock"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "AEDisYesPinSelected")
    let myString = String(myBool)
    
    print("AEDisYesPinSelected", myString )
    
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADCabinetPinNumber(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DevicePinlockKey"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let aedCabinetPin = UserDefaults.standard.string(forKey: "AEDcabinetPin") else {
        print("Error: AED cabinet pin not found in user defaults.")
        return
    }
    
    let parameters = "\"\(aedCabinetPin)\""
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
    
}
func ADAvailable247(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIs24-7Available"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "is247Available")
    let myString = String(myBool)
    
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
func ADDeviceIsInitiallyOk(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let endit = "/DeviceIsInitiallyOk"
    let finalURL = url_defi + (currentDefie ?? "0000") + endit
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let myBool = UserDefaults.standard.bool(forKey: "DeviceIsInitiallyOk")
    let myString = String(myBool)
    
    let parameters = myString
    let postData = parameters.data(using: .utf8)
    
    print("DeviceIsInitiallyOk", myString )
    
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}

