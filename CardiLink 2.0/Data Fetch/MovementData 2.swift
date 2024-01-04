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
    
    //            var baseUser = ""
//    var MoveCount: Int = 0
    //            var mymin: Int = 0
    var mymin0: Int = 0
//    var mymin1: Int = 0
    var indexNumber: Int = 1
    
//    var InnerBlockCount: Int = 0
    
//    var blockCountTest: Int = 0
//    let statusNumminnumber1: Int = 0
    
//    var myMoveCounter: Int = 0
    
    @AppStorage("test") var Commsss = ""
    
    
    @AppStorage("move_dateTime") var move_dateTime: String?
    @AppStorage("defridetailID") var defridetailID: String?
    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    
    var NK_GEOThisisit2: String = ""
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
                    //                  print("NEWKEY:\(index) NEWVALUE:\(subJson)")
                    
                    
                    switch index {
                        
                    case "errorCode":
                        print("errorCode")
                        
                    case "error":
                        
                        let error = json["error"]
                        print("error: ", error)
                        
                    case "success":
                        let success1 = json["success"].rawValue
                        print("success: ", success1)
                    case "data":
                        
                        
                        
                        
                        if let status = json["data"].arrayObject {
                            
                            
                            print("MAYBE:\(status.count)")
                            
                            
                            if status.count == 0{
                              
                                
                                UserDefaults.standard.set("No", forKey: "Moving")
//                                let backend = defaults.string(forKey: "Backend")
                                print("GETMOVE NO")
                                
                            } else {
                            
                            let statusNum = status.count
                            UserDefaults.standard.set("Yes", forKey: "Moving")
 
                                print("statusNum:\(statusNum)")
                                print("GETMOVE YES")
          
                            let statusNummaxnumber1 = statusNum - 1
                                
//                            //MARK: Loop Start
//                            for _ in statusNumminnumber1...statusNummaxnumber1 {

                                print("FIRST GROUP BLOCK Before:\(mymin0)")
                                

                                print("Before:\(mymin0)")
                                
                                let adminfirstKeyTEST2 =  (Array(arrayLiteral: status[mymin0])[0] as AnyObject)
//                                let adminfirstKeyTEST2 =  (Array(arrayLiteral: status[0])[0] as AnyObject)
                                print("FIRST GROUP:\(adminfirstKeyTEST2)")
                                
                                
                                let json = JSON(adminfirstKeyTEST2)
                              print("JSON:\(json)")
                                

                                //MARK: 1
                                if let status = json["geoLocations"].arrayObject {
                                    var moveCountminnumber1 = 0
                                    
                                    for obj in status {
                                        if let dict = obj as? NSDictionary {
                                            
                                            var moveMaxString = ""
                                            
                                            let MoveCountMax = status.count - 1

                                                print("moveCountminnumber1:\(moveCountminnumber1)")
                                                print("MoveCountMax:\(MoveCountMax)")

                                            switch moveCountminnumber1 {
                                            case 0:
                                                moveMaxString = String("MIN")
                                            case MoveCountMax:
                                                moveMaxString = String("MAX")
                                            default:
                                                moveMaxString = String("0")
                                            }

                                            let blockCountNew = String(describing: indexNumber)
                                            
                                            
                                           // let ownerid = (subJson["ownerId"].string ?? "..")
                                            let resultString = String(describing: defridetailOwner ?? "..")
                                            
                                            
                                            
                                            let ownerNameString = String(describing: defridetailownerName ?? "..")
                                            
                                            let defiIdString = String(describing: defridetailID ?? "..")
                                            
                                            
                                            let newLAT = dict.value(forKey: "lat")
                                            let newLON = dict.value(forKey: "lon")
                                            let eventLatLon = dict.value(forKey: "eventTime")
                                            print("eventLatLon:\(String(describing: eventLatLon))")
                                            print("MoveLat:\(String(describing: newLAT))")
                                            
//                                            let newDataMove = eventLatLon
//                                            print("pairingDate: ", newDataMove!)
//                                            let myString = "\(String(describing: eventLatLon))"
//                                            let myInt: Int = Int(myString) ?? 0000
//                                            print("pairingDate: ", myInt)
//                                            let pcbProdDate = myInt //myString.int
//                                            let myInt1 = pcbProdDate//Int(value)
                                            let unixTimestamp = eventLatLon //value.int!
//
                                            
                                            let timeZone = TimeZone(abbreviation: "GMT")!
                                            if timeZone.isDaylightSavingTime(for: Date()) {
                                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp as! Int / 1000 + 3600))
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                                dateFormatter.locale = NSLocale.current
                                                dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a" //Specify your format that you want
                                                let strDate = dateFormatter.string(from: date)
                                                
                                                print("eventLatLon:", strDate)
                                                UserDefaults.standard.set(strDate, forKey: "move_dateTime")
                                                
//                                                UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                                            }else {
                                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp as! Int / 1000 + 7200))
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                                dateFormatter.locale = NSLocale.current
                                                dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a" //Specify your format that you want
                                                let strDate = dateFormatter.string(from: date)
                                                
                                                print("eventLatLon:", strDate)
                                                UserDefaults.standard.set(strDate, forKey: "move_dateTime")
//                                                UserDefaults.standard.set(strDate, forKey: "defridetailpairingDate")
                                            }
                                            
                 
                                            let newDateTimString = String(describing:move_dateTime!)
        
                                            let newLATString = String(describing: newLAT!)
                                            let newLONString = String(describing: newLON!)

                                            print("MoveLatFinal:\(String(describing: newLATString))")
                                            
                                            if newLATString == "" || newLATString == "<null>" {
                                                
                                                print("STOPMOVELAT")
                                                
                                            } else {

                                                let stringid = """
                                                          "idCode":
                                                          """
                                                 
//                                                NK_GEOThisisit2.append("{" + stringid + "\""  + blockCountNew + "\"" + "," + " \"ownerid\"" + " : " + "\"" + resultString + "\"" + "," + " \"ownerSerial\"" + " : " + "\"" + defiIdString  + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString + "\"" + "," + " \"latitude\"" + " : "  + newLATString  + "," + " \"longitude\"" + " : "  + newLONString + "," + " \"status\"" + " : " + "\"" + moveMaxString  + "\"" + "}" + ",")
                                                
                                                NK_GEOThisisit2.append("{" + stringid + "\""  + blockCountNew + "\"" + "," + " \"ownerid\"" + " : " + "\"" + resultString + "\"" + "," + " \"eventTime\"" + " : " + "\"" + newDateTimString + "\"" + "," + " \"ownerSerial\"" + " : " + "\"" + defiIdString  + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString + "\"" + "," + " \"latitude\"" + " : "  + newLATString  + "," + " \"longitude\"" + " : "  + newLONString + "," + " \"status\"" + " : " + "\"" + moveMaxString  + "\"" + "}" + ",")
                                                
                                                
                                                
                                                

                                                NK_GEODataInfo = "[" + NK_GEOThisisit2 + "]"
                                                
                                                let NK_GEOData = NK_GEODataInfo

                                                let url = getDocumentsDirectory().appendingPathComponent("Movelatlon.json")
                                                do {
                                                    try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
                                                    moveCountminnumber1 += 1
                                                } catch {
                                                    print("NODATA")
                                                    print(error.localizedDescription)
                                                }
//                                            }
                                            }
                                            
                                        }
                                    }
                                }
                            
                                indexNumber += 1
                                mymin0 += 1
//                                statusNumminnumber1 = statusNummaxnumber1 - 1
                                print("COUNTER MOVE:\(statusNummaxnumber1)")
                                print("IN COUNT:\(mymin0)")
                                
                                UserDefaults.standard.set(mymin0, forKey: "lastMovementEntry")
                                UserDefaults.standard.set("Yes", forKey: "MovingLoadingDone")
                                UserDefaults.standard.set(statusNummaxnumber1, forKey: "NoMoveMents")
                                
                                if statusNummaxnumber1 == 0  {
//                                if statusNummaxnumber1 == 0  &&  mymin0 == 1 {
                                
                                    UserDefaults.standard.set(statusNummaxnumber1, forKey: "NoMoveMents")
                                    
                                }
                                
                                //action will be taken 5 times.
//                            }
                                //MARK: Loop END

                            }
                        }
                    default:
                        print("456")
                    
                    }
                }
                
                
            case .failure(let error):
                print(error)
                print("MOVE FILE ERROR")
                
            }
        }
    //        return  true
}


