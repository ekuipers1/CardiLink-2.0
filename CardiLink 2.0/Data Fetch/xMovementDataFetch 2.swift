////
////  MovementDataFetch.swift
////  CardiLink 2.0
////
////  Created by Erik Kuipers on 03.11.21.
////
//
//import SwiftUI
//import Combine
//import Alamofire
//import SwiftyJSON
//import Foundation
//
//struct MyGeo {
//    var lonGPS = ""
//}
//
//func getmovementData() {
//    @State var myGeo = MyGeo()
//
//    let defaults = UserDefaults.standard
//    
//    let myURL = defaults.string(forKey: "myPortal")
//    let AuthKey = defaults.string(forKey: "DATASTRING")
//    let authKey = AuthKey!
//    let selectedDefi = defaults.string(forKey: "SelectedDefi")
//    
//    let myDefibrillators = "defibrillators/"
//    let url_defi = myURL! + myDefibrillators
//    let theone =  selectedDefi ?? ""
//    let url = url_defi + theone + "/movements"
//    
//    @State var latString: String = ""
//    @State var lonString: String = ""
//    @State var eventTimeString: String = ""
//    
////            var baseUser = ""
//    var blockCount: Int = 0
////            var mymin: Int = 0
//    var mymin0: Int = 0
//    var InnerBlockCount: Int = 0
//    
//    var blockCountTest: Int = 0
//    
//    
//        @AppStorage("test") var Commsss = ""
//    @AppStorage("defridetailID") var defiId: String?
////    @AppStorage("connection_ble") var stopscanning: String?
//    
////    UserDefaults.standard.set(defiId, forKey: "defridetailID")
////     var token:UUID?
////    var countGeoNumber: String = ""
//     
//    
//        var NK_GEOThisisit2: String = ""
//        var NK_GEODataInfo  : String = ""
//    
//    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        "authkey" : authKey,
//        "Accept": "application/json",
//        "Content-Type": "application/json",
//        "Connection" : "keep-alive"
//    ]
//    )
//    
//        .responseData {response in
//            switch response.result {
//            case .success(let value):
//                
//                let json = JSON(value)
//
//                for(index,_):(String, JSON) in json {
////                    print("NEWKEY:\(index) NEWVALUE:\(subJson)")
//
//                
//                    switch index {
//                      
//                    case "errorCode":
//                        print("errorCode")
//                        
//                    case "error":
//                        
//                        let error = json["error"]
//                        print("error: ", error)
//                        
//                    case "success":
//                        let success1 = json["success"].rawValue
//                        print("success: ", success1)
//                    case "data":
//                    
//                        
//                        
//                        
//                    if let status = json["data"].arrayObject {
//                        
//                        let statusNum = status.count
//                             
//                        
//                        print("statusNum:\(statusNum)")
//                        
////                        NSArray *nestedArray = @[@[@"1", @"2", @[@"3"]], @"4"];
//
//                        let flatMapped = status.compactMap { item in
//                          return item
//                        }
////                        print(flatMapped)
//                        
//                        let arrayWithoutOptionals = status.filter { item in
//                          return item != nil
//                        }
//                        
////                        print(arrayWithoutOptionals)
//                        
//                        let statusNumminnumber1 = 0
////                        let statusNummaxnumber1 = status2! - 1
//                        
//                        
//                        let statusNummaxnumber1 = statusNum - 1
//                        
//                        for _ in statusNumminnumber1...statusNummaxnumber1 {
//                            
//                            print("FIRST GROUP BLOCK Before:\(mymin0)")
//                            
////                            let adminfirstKeyTEST =  (Array(arrayLiteral: status[mymin0])[0] as AnyObject)
////                            print("FIRST GROUP BLOCK:\(adminfirstKeyTEST)")
//                            
//                            
////                            for _ in statusNumminnumber1...statusNummaxnumber1 {
//                                
//    //                            print(siutatus2!)
//                                 print("Before:\(mymin0)")
//                                
//                                let adminfirstKeyTEST2 =  (Array(arrayLiteral: status[mymin0])[0] as AnyObject)
//                                print("FIRST GROUP:\(adminfirstKeyTEST2)")
//                            
//                            
//                            
//                            //MARK: NEW NEW NEW
//                            
//                            
//                            
//                            
//                            
//                            
//                            //MARK: NEW NEW NEW
//                            
//                            
//                            
//                            
//                            
//                            
//
//                            
//                            
//
//                            //TODO: count the group --> adminfirstKeyTEST2 <-- and then loop it for results
//
//                            let howmany = adminfirstKeyTEST2.count
//                            print("FIRST GROUP COUNT :\(String(describing: howmany))")
//                            print(howmany as Any)
//                            
//                            if howmany == 0 {
//                                
//                                print("NOTHING")
//                                
//                            } else {
//                            
//                            
//                            let InnerBlockMin = 0
//                            let InnerBlockMax = howmany! - 1
//                            
//                            for _ in InnerBlockMin...InnerBlockMax {
////                                InnerBlockCount
//                                print("Inner BLOCK Before:\(InnerBlockCount)")
//                              
//    
//                                if InnerBlockCount > InnerBlockMax {
//                                    
//                                    print("STOP STOP STOP")
//                                    
//                                } else {
//                                
//                             
//                                    
//                                    
//                                    
//                                
//                            let nomnom = (Array(arrayLiteral: adminfirstKeyTEST2[InnerBlockCount])[0] as AnyObject)
//                            print("Inner BLOCK nomnom:\(String(describing: nomnom))")
//
//                                    
//                                     
//                                    
//                                    let json = JSON(nomnom)
//                                    //MARK: HERE!!!!!!!!
//                                    let lat = json["lat"].stringValue
//                                    let lon = json["lon"].stringValue
//                                    let eventTime = json["eventTime"].stringValue
//                                    let defiIdString = String(describing: defiId!)
//                                    
//                                    let blockCountNew = String(describing: howmany!)
//                                    
//                                    if  howmany == blockCountTest {
//                                    
//                                        print("SAME")
//                                        
//                                    } else {
//                                            
//                                        print("NOTSOMUCH")
//                                    }
//                                    
////                                    print("NEWLAT: ", username)
//                                    print("NEWLAT: ", lat)
//                                    
//                                    
//                                    
//                                    
//                                    
//                                    if lat == "" {
//                                        
//                                        print("STOP")
//                                    
//                                    } else {
//                                    
//                                    
//                                    
//                                    let stringid = """
//                                      "id":
//                                      """
//                                    
//                                    NK_GEOThisisit2.append("{" + stringid + "\""  + blockCountNew + "\"" + "," + " \"latitude\"" + " : "  + lat  + "," + " \"longitude\"" + " : "  + lon + "," + " \"status\"" + " : " + "\"" + eventTime  + "\"" + "}" + ",")
//                                    
//                                    NK_GEODataInfo = "[" + NK_GEOThisisit2 + "]"
//                                    
//                                    let NK_GEOData = NK_GEODataInfo
//                                        
//                                    let myfileName = "Movelatlon"
//                                    let myfileBlock = String(blockCount)
//                                        
//                                    let url = getDocumentsDirectory().appendingPathComponent("Movelatlon12.json")
////                                        let url = getDocumentsDirectory().appendingPathComponent(myfileName + myfileBlock + ".json")
//                                    do {
//                                        try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
//                                        //MARK: Uncomment for debugging
//                                        //                            let input = try String(contentsOf: url)
//                                        //                            print(input)
//                                    } catch {
//                                        print(error.localizedDescription)
//                                    }
//                                    
//                                        InnerBlockCount += 1
//                                        blockCount = +1
//                                        
//                                        
//                                        blockCountTest = adminfirstKeyTEST2.count
//                                        
//        //                                print(statusNum)
//                                        print("Inner BLOCK After:\(InnerBlockCount)")
//                                        
//                                            if InnerBlockCount > InnerBlockMax {
//                                                
//                                                InnerBlockCount = 0
//                                                
//                                            }
//                                    
//                                    }
//                                    
//
//                            }
//                            }
//                            }
//                            
//                            mymin0 += 1
//                            print(statusNum)
//                            print("FIRST GROUP BLOCK After:\(mymin0)")
//                          //action will be taken 5 times.
//                        }
//                        
//
//                        
//                        
//                        
//                        
//                        
////                        let adminfirstKey =  (Array(arrayLiteral: status[0])[0] as AnyObject)
////                        
////                        
////                        let status2 = adminfirstKey.count
////                                                
////                        print(status2!)
////                        
////                        let minnumber1 = 0
////                        let maxnumber1 = status2! - 1
////                        
////                        for _ in minnumber1...maxnumber1 {
////                            
//////                            print(siutatus2!)
////                             print("Before:\(mymin)")
////                            
////                            let adminfirstKeyTEST2 =  (Array(arrayLiteral: status[mymin])[0] as AnyObject)
////                            print("adminfirstKeyTEST2:\(adminfirstKeyTEST2)")
////                            
////                            let json = JSON(adminfirstKeyTEST2)
////                            
////                            let nomnom = (Array(arrayLiteral: adminfirstKey[mymin])[0] as AnyObject)
////                            print("nomnom:\(String(describing: nomnom))")
////                            
////                           
////                            for(index,subJson):(String, JSON) in json {
////                                print("adminfirstKeyTEST2:\(index) adminfirstKeyTEST2:\(subJson)")
////                            
////                                
////                                if index == "lat" {
////                                    
////                                    print("NEWlat: ", subJson)
////                                }
////                                
////                                if index == "lon" {
////                                    
////                                    print("NEWlon: ", subJson)
////                                }
////                                if index == "eventTime" {
////                                    
////                                    print("NEWeventTime: ", subJson)
////                                }
////                                
////    //                            let latitide = subJson["lat"].stringValue
////    //                            print("Latitude:\(latitide)")
////                            }
////                            
////                            
////                            mymin += 1
////                            print("After:\(mymin)")
////                          //action will be taken 5 times.
////                        }
////                        
////                        
//                        
////                        print("adminfirstKey:\(adminfirstKey)")
////
////                        let nomnom = (Array(arrayLiteral: adminfirstKey[0])[0] as AnyObject)
////                        print("nomnom:\(String(describing: nomnom))")
//////                        var tup = adminfirstKey.array[0]
////                        let nomnom2 = (Array(arrayLiteral: adminfirstKey[1])[0] as AnyObject)
////                        print("nomnom2:\(String(describing: nomnom2))")
////
////
////                        let json = JSON(nomnom2)
////
////                        for(index,subJson):(String, JSON) in json {
////                            print("nomnom2Index:\(index) nomnom2subJson:\(subJson)")
////
////
////                            if index == "lat" {
////
////                                print("lat: ", subJson)
////                            }
////
////                            if index == "lon" {
////
////                                print("lon: ", subJson)
////                            }
////                            if index == "eventTime" {
////
////                                print("eventTime: ", subJson)
////                            }
////
//////                            let latitide = subJson["lat"].stringValue
//////                            print("Latitude:\(latitide)")
////                        }
////                        if let name = nomnom2["lat"].string {
////                            print(name)
////                        }
//                        
//                        
////                        for (key) in nomnom
////                        {
////
////                        }
//                        
////                        let adminfirstKey2 =  (Array(arrayLiteral: status[0])[0] as! String)
////
////                        print(adminfirstKey2)
////
////                        for(index,subJson):(String, JSON) in adminfirstKey2 {
//                       //                            print("defi:\(index) 2:\(subJson)")
//                       //                        }
//                        
//                        
////                        for obj in adminfirstKey {
////                            if let dict = obj as? NSDictionary {
////
////                                print(dict)
////                            }
////                        }
////}
////                        for(index,subJson):(String, JSON) in status[0] {
////                            print("defi:\(index) 2:\(subJson)")
////                        }
//                        
//                        
//                        
////                        for fruit in status {
////           //WORKS               print(fruit)
////                            if let dict = fruit as? NSDictionary {
////
////                                print(dict)
////
////                                if dict.value(forKey: "lat") as? Double == nil {
////
////                                    print("EMPTY")
////
////                                } else {
////
////                                    count += 1
////                                    let countGeo = String(count)
////                                    countGeoNumber = countGeo
////                                    print(countGeo)
////                                }
////                        }
////                        }
//              
//                        
////                        for obj in status {
////                            if let dict = obj as? NSDictionary {
////
////                                print(dict)
////
////
////
////
////                                if dict.value(forKey: "lat") as? Double == nil {
////
////                                    print("EMPTY")
////
////                                } else {
////
////                                    count += 1
////                                    let countGeo = String(count)
//////                                    countGeoNumber = countGeo
////                                    print(countGeo)
////
////
////
////
//////                                    let defiId = dict.value(forKey: "defiId")
////                                    let defiIdString = String(describing: defiId!)
////                                    //                                print("ownerId2", defiIdString)
////
////                                    let lat = dict.value(forKey: "lat")
////                                    let latString = String(describing: lat!)
////
////                                    let lon = dict.value(forKey: "lon")
////                                    let lonString = String(describing: lon!)
////                                    //                                print("ownerId2", resultString)
////                                    //                                print("ownerId2", descriptionString)
////
////
////                                   let currentStatus = "available"
////
////                                    let stringid = """
////                                      "id":
////                                      """
////
////                                    NK_GEOThisisit2.append("{" + stringid + "\""  + defiIdString + "\"" + "," + " \"latitude\"" + " : "  + latString  + "," + " \"longitude\"" + " : "  + lonString + "," + " \"status\"" + " : " + "\"" + currentStatus  + "\"" + "}" + ",")
////
////                                    NK_GEODataInfo = "[" + NK_GEOThisisit2 + "]"
////
////                                    let NK_GEOData = NK_GEODataInfo
////                                    let url = getDocumentsDirectory().appendingPathComponent("Movelatlon.json")
////
////                                    do {
////                                        try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
////                                        //MARK: Uncomment for debugging
////                                        //                            let input = try String(contentsOf: url)
////                                        //                            print(input)
////                                    } catch {
////                                        print(error.localizedDescription)
////                                    }
////                                }
////                            }
////                        }
//                        
//                    }
//                    default:
//                        print("456")
//                    }
//                }
//                
//                
//            case .failure(let error):
//                print(error)
//                print("NOOOOOO NEW DEFI")
//                
//            }
//    }
////        return  true
//    }
////
////
////}
