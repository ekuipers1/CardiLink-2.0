//
//  BaseDataFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import Combine
import Alamofire
import SwiftyJSON
import Foundation


class BaseDataFetch: ObservableObject, Identifiable {
    @Published var token:UUID?
    @Published var getit2:String?
    @Published var commComnter:Int?
    @Published var countGeoNumber:String?
    @Published var Thisisit2: String = ""
    @Published var YellowThisisit2: String = ""
    @Published var RedThisisit2: String = ""
    @Published var ServiceTicket: String = ""
    @AppStorage("saveit") var rememberMe = ""
    
    let defaults = UserDefaults.standard
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func login(email: String, password: String) -> Bool {
        self.token = UUID()
        
        var count: Int = 0
        let myBackend = defaults.string(forKey: "Backend")
        
        let email = defaults.string(forKey: "username")
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let withGps = defaults.string(forKey: "withGps")
        let myCommunicator = "communicators?PageSize=1500" //2000
        let url = myURL! + myCommunicator
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData { [self]response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let commcount = json["data"].arrayObject
                let commCountall = json["data"].arrayObject
                let myComInt = commCountall?.count
                commComnter = myComInt
                let myString = "\(commcount?.count ?? 0)"
                getit2 = myString
                
            case .failure(let error):
                print(error)
            }
        }
        
        let myDefibrillators = "defibrillators?GpsIsAvailable=True&PageSize=2500"
        let url_defi = myURL! + myDefibrillators
        var MapdataInfo: String = ""
        var NK_GEODataInfo  : String = ""
        
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                if let count = json["count"].int {
                    UserDefaults.standard.set(count, forKey: "withGps")
                }
                
                if let status = json["data"].arrayObject {
                    for obj in status {
                        if let dict = obj as? NSDictionary {
                            
                            if dict.value(forKey: "lat") as? Double == nil || dict.value(forKey: "lon") as? Double == 0 {
                                
                            } else {
                                
                                let dashboardStateGPS = dict.value(forKey: "dashboardState")
                                let Mystatus = String(describing: dashboardStateGPS!)
                                count += 1
                                let countGeo = String(count)
                                self.countGeoNumber = countGeo
                                let defiId = dict.value(forKey: "defiId")
                                let defiIdString = String(describing: defiId!)
                                let ownerSerial = dict.value(forKey: "serial")
                                let ownerSerialString = String(describing: ownerSerial!)
                                let lat = dict.value(forKey: "lat")
                                let latString = String(describing: lat!)
                                let lon = dict.value(forKey: "lon")
                                let lonString = String(describing: lon!)
                                let ownerId = dict.value(forKey: "ownerId")
                                let resultString = String(describing: ownerId!)
                                let ownerName = dict.value(forKey: "ownerName")
                                let ownerNameString = String(describing: ownerName!)
                                
                                let stringid = """
                                                  "idCode":
                                                  """
                                
                                let MPOwnerID = "{" + stringid
                                let MPOwnerIDResult = "\""  + ownerSerialString + "\""
                                let MPDash = ","  + "\"ownerSerial\"" + ":"
                                let MPdefiIdString = "\""  + defiIdString + "\""
                                let MPOwnerName = ","  + "\"ownerName\"" + ":"
                                let MPOwnerNameString = "\""  + ownerNameString + "\""
                                let MPOwner = ","  + "\"ownerid\"" + ":"
                                let MPOwnerString = "\""  + resultString + "\""
                                let MPlatitude = ","  + "\"latitude\"" + ":"
                                let MPlatitudeString = latString
                                let MPlongitude = ","  + "\"longitude\"" + ":"
                                let MPlongitudeString = lonString
                                let MPStatus = ","  + "\"status\"" + ":"
                                let MPStatusString = "\""  + Mystatus + "\"" + "},"
                                
                                
                                let allMapData = MPOwnerID + MPOwnerIDResult + MPDash + MPdefiIdString + MPOwnerName + MPOwnerNameString + MPOwner + MPOwnerString + MPlatitude + MPlatitudeString + MPlongitude + MPlongitudeString + MPStatus + MPStatusString
                                
                                MapdataInfo.append(allMapData)
                                
                                NK_GEODataInfo = "[" + MapdataInfo + "]"
                                
                                let NK_GEOData = NK_GEODataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("latlon.json")
                                
                                do {
                                    try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        return true
    }
    
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

struct defLocationdata {
    var defID: String
}

class Logger {
    
    static var logFile: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: Date())
        let fileName = "\(dateString).log"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    static func log(_ message: String) {
        guard let logFile = logFile else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timestamp = formatter.string(from: Date())
        guard let data = (timestamp + ": " + message + "\n").data(using: String.Encoding.utf8) else { return }
        
        if FileManager.default.fileExists(atPath: logFile.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } else {
            try? data.write(to: logFile, options: .atomicWrite)
        }
    }
}

