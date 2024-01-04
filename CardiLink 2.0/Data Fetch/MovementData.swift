//
//  MovementData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 27.04.22.
//

import SwiftUI
import Combine
import Alamofire
import SwiftyJSON
import Foundation

struct MyGeo {
    var lonGPS = ""
}

func getmovementData() {
    @State var myGeo = MyGeo()
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone + "/movements"
    
    @State var latString: String = ""
    @State var lonString: String = ""
    @State var eventTimeString: String = ""
    @State var myIndexState: String = ""
    @State var indexString: String = ""
    
    var mymin0: Int = 0
    var indexNumber: Int = 1
    
    @AppStorage("test") var Commsss = ""
    @AppStorage("move_dateTime") var move_dateTime: String?
    @AppStorage("defridetailID") var defridetailID: String?
    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    
    var MovementData: String = ""
    var NK_GEODataInfo  : String = ""
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    )
    
    .responseData { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            for(index,_):(String, JSON) in json {
                switch index {
                    
                case "errorCode":
                    print("errorCode")
                    
                case "error":
                    let error = json["error"]
                case "success":
                    let success1 = json["success"].rawValue
                case "data":
                    
                    if let status = json["data"].arrayObject {
                        if status.count == 0{
                            UserDefaults.standard.set("No", forKey: "Moving")
                        } else {
                            
                            let statusNum = status.count
                            UserDefaults.standard.set("Yes", forKey: "Moving")
                            
                            let statusNummaxnumber1 = statusNum - 1
                            
                            let adminfirstKeyTEST2 =  (Array(arrayLiteral: status[mymin0])[0] as AnyObject)
                            
                            let json = JSON(adminfirstKeyTEST2)
                            
                            if let status = json["geoLocations"].arrayObject {
                                var moveCountminnumber1 = 0
                                
                                for obj in status {
                                    if let dict = obj as? NSDictionary {
                                        
                                        var moveMaxString = ""
                                        
                                        let MoveCountMax = status.count - 1
                                        
                                        switch moveCountminnumber1 {
                                        case 0:
                                            moveMaxString = String("MIN")
                                        case MoveCountMax:
                                            moveMaxString = String("MAX")
                                        default:
                                            moveMaxString = String("0")
                                        }
                                        
                                        let blockCountNew = String(describing: indexNumber)
                                        
                                        let resultString = String(describing: defridetailOwner ?? "..")
                                        
                                        let ownerNameString = String(describing: defridetailownerName ?? "..")
                                        
                                        let defiIdString = String(describing: defridetailID ?? "..")
                                        
                                        let newLAT = dict.value(forKey: "lat")
                                        let newLON = dict.value(forKey: "lon")
                                        let eventLatLon = dict.value(forKey: "eventTime")
                                        let unixTimestamp = eventLatLon
                                        
                                        let timeZone = TimeZone(abbreviation: "GMT")!
                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp as! Int / 1000 + 3600))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "move_dateTime")
                                            
                                        }else {
                                            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp as! Int / 1000 + 3600))
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                            dateFormatter.locale = NSLocale.current
                                            dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
                                            let strDate = dateFormatter.string(from: date)
                                            UserDefaults.standard.set(strDate, forKey: "move_dateTime")
                                            
                                        }
                                        
                                        let newDateTimString = String(describing:move_dateTime!)
                                        
                                        let newLATString = String(describing: newLAT!)
                                        let newLONString = String(describing: newLON!)
                 
                                        if newLATString == "" || newLATString == "<null>" {
                                            
                                        } else {
                                            
                                            let stringid = """
                                                          "idCode":
                                                          """
                                            
                                            let GMID = "{" + stringid
                                            let GMBlockCount = "\""  + blockCountNew + "\""
                                            let GMOwnerId = ","  + "\"ownerid\"" + ":"
                                            let GMOwnerIdResult = "\""  + resultString + "\""
                                            let SGTime = ","  + "\"eventTime\"" + ":"
                                            let SGTimeResult = "\""  + newDateTimString + "\""
                                            let GMOwnerSerial = ","  + "\"ownerSerial\"" + ":"
                                            let GMOwnerSerialResult = "\""  + defiIdString + "\""
                                            let GMOwnerName = ","  + "\"ownerName\"" + ":"
                                            let GMOwnerNameResult = "\""  + ownerNameString + "\""
                                            let GMLatitude = ","  + "\"latitude\"" + ":"
                                            let GMLatitudeResult = newLATString
                                            let GMLongitude = ","  + "\"longitude\"" + ":"
                                            let GMLongitudeResult = newLONString
                                            let GMStatus = ","  + "\"status\"" + ":"
                                            let GMStatusResult = "\""  + moveMaxString + "\"" + "},"
                                            
                                            
                                            let allGetMovementData = GMID + GMBlockCount + GMOwnerId + GMOwnerIdResult + SGTime + SGTimeResult + GMOwnerSerial + GMOwnerSerialResult + GMOwnerName + GMOwnerNameResult + GMLatitude + GMLatitudeResult + GMLongitude + GMLongitudeResult + GMStatus + GMStatusResult
                                            
                                            MovementData.append(allGetMovementData)
                                            
                                            NK_GEODataInfo = "[" + MovementData + "]"
                                            
                                            let NK_GEOData = NK_GEODataInfo
                                            
                                            let url = getDocumentsDirectory().appendingPathComponent("Movelatlon.json")
                                            do {
                                                try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
                                                moveCountminnumber1 += 1
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                            
                            indexNumber += 1
                            mymin0 += 1
                            UserDefaults.standard.set(mymin0, forKey: "lastMovementEntry")
                            UserDefaults.standard.set("Yes", forKey: "MovingLoadingDone")
                            UserDefaults.standard.set(statusNummaxnumber1, forKey: "NoMoveMents")
                            
                            if statusNummaxnumber1 == 0  {
                                UserDefaults.standard.set(statusNummaxnumber1, forKey: "NoMoveMents")
                                
                            }
                            
                        }
                    }
                default:
                    print("")
                    
                }
            }

        case .failure(let error):
            print(error)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


