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
    @AppStorage("test") var Commsss = ""
    @Published var token:UUID?
    @Published var defriAll:String?
    @Published var getit:String?
    @Published var getit2:String?
    @Published var getit3:String?
    @Published var commComnter:Int?
    @Published var getitService:String?
    @Published var countGeoNumber:String?
    @Published var countGreenNumber:String?
    @Published var countYellowNumber:String?
    @Published var countRedNumber:String?
    @Published var countDashGreenNumber:String?
    @Published var countDashYellowNumber:String?
    @Published var countDashRedNumber:String?
    @Published var countDashServiceTicketNumber:String?
    @Published var countNKService:String?
    @Published var baseUser:String?
    @Published var ALL:String?
    @Published var ALL2:JSON?
    
    @Published var latcombo:String?
    
    @Published var mylat:Double?
    @Published var mylon:Double?
    @Published var TEST:String?
    
    //    @Published var Thisisit: [String] = []
    @Published var Thisisit2: String = ""
    
    //    @Published var YellowThisisit: [String] = []
    @Published var GreenThisisit2: String = ""
    
    //    @Published var YellowThisisit: [String] = []
    @Published var YellowThisisit2: String = ""
    
    //    @Published var RedThisisit: [String] = []
    @Published var RedThisisit2: String = ""
    
    //    @Published var ServiceTicket: [String] = []
    @Published var ServiceTicket: String = ""
    
    @Published var latloninof: String = ""
    @Published var greenDataInfo : String = ""
    @Published var yellowDataInfo : String = ""
    @Published var redDataInfo : String = ""
    @Published var serviceDataInfo : String = ""
    
    @Published var lattest: [Double] = []
    @Published var lontest: [Double] = []
    
    
    @AppStorage("saveit") var rememberMe = ""
    //    @Published var cleanUser : String = ""
    
    let defaults = UserDefaults.standard
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func login(email: String, password: String) -> Bool {
        self.token = UUID()
        
        var count: Int = 0
        var countRed: Int = 0
        var countYellow: Int = 0
        var countGreen: Int = 0
        var countService: Int = 0
        
        var dashCountGreen: Int = 0
        var dashCountYellow: Int = 0
        var dashCountRed: Int = 0
        var dashCountServiceTickets: Int = 0
        
        //
        var baseUser = ""
        //
        
        print(email)
        print(password)
        
        let myBackend = defaults.string(forKey: "Backend")
        
        //MARK: NK START
        
        if myBackend == "NEW" {

            print("Backend: ", myBackend!)

            let email = defaults.string(forKey: "DataUIDUser")


            baseUser = email!
            print(baseUser)

            
            let defaults = UserDefaults.standard
            let myURL = defaults.string(forKey: "myPortal")
            let AuthKey = defaults.string(forKey: "DATASTRING")
            print("NEXT DATASTRING: ", AuthKey!)
            let authKey = AuthKey!
            
            
            //MARK: COMMUNICATORS
            let myCommunicator = "communicators?PageSize=500"
            let url = myURL! + myCommunicator
            print("COMMURL", url)
            
//            let URL_Comm = "https://primedic.dev.cardi-link.cloud/api/communicators"
//            let url_comm = URL_Comm

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
                    
            
//                    commComnter = commCountall
                    let myComInt = commCountall?.count
                    commComnter = myComInt
                    
                    let myString = "\(commcount?.count ?? 0)"
                    getit2 = myString
                    print("COMMCOUNT", myString)
//                    print("COMMCOUNTNEW", myComInt)

            case .failure(let error):
                print(error)
                print("NOOOOOO NEW COM")
            }
        }
            
            //MARK: DEFI
            let myDefibrillators = "defibrillators?PageSize=500"
            let url_defi = myURL! + myDefibrillators
            AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "authkey" : authKey,
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            
            .responseData { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    let commcount = json["data"].arrayObject
                    let myString = "\(commcount?.count ?? 0)"
                    self.countGreenNumber = myString

                    
                    self.countYellowNumber = "0"
                    self.countRedNumber = "0"
//                    self.countGeoNumber = "0"
                    self.getitService = "0"
                    
                    self.countNKService = "0"
                    
                    if let status = json["data"].arrayObject {

                    for obj in status {
                        if let dict = obj as? NSDictionary {

//                            let id = dict.value(forKey: "ownerId")
//                            print("STATUSID:", id!)

//                            let pair1 = dict.allKeys(for: "adminStatus")
//                            print("adminStatus1:", pair1)
                            
                            let pair = dict.value(forKey: "adminStatus")
                     
                            if let dict = pair as? NSDictionary {
                                let id = dict.value(forKey: "date")
                                print("UnixStatusDate-Base:", id!)
                                
                                let unixTimestamp = id!
                                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp as! Int / 1000))
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
                                dateFormatter.locale = NSLocale.current
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
                                let strDate = dateFormatter.string(from: date)
                                
                                print("StatusDate:", strDate)
                                
                                let id2 = dict.value(forKey: "status")
                                print("StatusStaus:", id2!)
                                
                            }

                            
                            
                        }
                    }
                    }

                    
                    
                    
            case .failure(let error):
                print(error)
                print("NOOOOOO NEW ADMIN")
            }
        }
            
            
//            let myDefibrillators = "defibrillators/"
//            let url_defi = myURL! + myDefibrillators
//            let theone =  selectedDefi ?? ""
//            let url = url_defi + theone + "/homelocation"
//
//            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//                "authkey" : authKey,
//                "Accept": "application/json",
//                "Content-Type": "application/json"
//            ]
//            )
            
            
            
            
            
            
            
//MARK: GREEN NK LIST
            var GreenThisisit2: String = ""
            var greenDataInfo : String = ""

            print("app folder path is \(NSHomeDirectory())")

            AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "authkey" : authKey,
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            
            //MARK: RESULT
            .responseData {response in
                
                
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    if let status = json["data"].arrayObject {
                        
                        for obj in status {
                            if let dict = obj as? NSDictionary {
                                
                                let defidashboardState = dict.value(forKey: "dashboardState")
                                let defidashboardStateString = String(describing: defidashboardState!)
                                
                                print(defidashboardStateString)
                                
                                if defidashboardStateString == "0" {
                                    dashCountGreen += 1
                                    print("dashCountGreen", dashCountGreen)
                                    
                                    
                                let ownerId = dict.value(forKey: "ownerId")
                                let resultString = String(describing: ownerId!)
        //                                print("ownerId2", resultString)
                                
                                let ownerName = dict.value(forKey: "ownerName")
                                let defiOwnerName = String(describing: ownerName ?? "N/A")
                                
                                let defiId = dict.value(forKey: "defiId")
                                let defiIdString = String(describing: defiId!)
        //                                print("ownerId2", defiIdString)
                                
                                
                                let defiSerial = dict.value(forKey: "serial")
                                let defiSerialString = String(describing: defiSerial!)

                                let description = dict.value(forKey: "description")
                                    
                                    
                                    
                                let descriptionString = String(describing: description!)
                                    
                                    
//                                    let newString = owner.replacingOccurrences(of: "\n \n", with: "")
                                    print("newString:", descriptionString)

                                    let newString3 = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()
                                    print("newString1:", newString3)

                                let stringid = """
                                              "ownerId":
                                              """
                                
                                GreenThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString + "\"" + "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "," + " \"defiId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                                
                                greenDataInfo = "[" + GreenThisisit2 + "]"
                                
                                let greenData = greenDataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("NKgreenData.json")
                                
                                do {
                                    try greenData.write(to: url, atomically: true, encoding: .utf8)
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print(error.localizedDescription)
                                }
                                } else {
                                    
                                }
                                // MARK: ✅ SAVE dashCountGreen END
                                let dashCountGreen = String(dashCountGreen)
                                self.countDashGreenNumber = dashCountGreen
                                print("Green COUNT:", dashCountGreen)
                                
                                
                                
                                // MARK: ⚠️ SAVE YELLOW START
//                                if defidashboardStateString == "2" || defidashboardStateString == "4" {
                                if defidashboardStateString == "1" || defidashboardStateString == "3" {
                                    
                                dashCountYellow += 1
                                    
                                    
                                let ownerId = dict.value(forKey: "ownerId")
                                let resultString = String(describing: ownerId!)
        //                                print("ownerId2", resultString)
                                
                                let ownerName = dict.value(forKey: "ownerName")
                                let defiOwnerName = String(describing: ownerName ?? "N/A")
                                
                                let defiId = dict.value(forKey: "defiId")
                                let defiIdString = String(describing: defiId!)
        //                                print("ownerId2", defiIdString)
                                
                                
                                let defiSerial = dict.value(forKey: "serial")
                                let defiSerialString = String(describing: defiSerial!)

                                let description = dict.value(forKey: "description")
                                let descriptionString = String(describing: description!)
        //                                print("ownerId2", descriptionString)
                                
                                    let newString3 = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()
                                    print("newString1:", newString3)
                                    
                                    
                                let stringid = """
                                              "ownerId":
                                              """
                                
                                    self.YellowThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString + "\"" + "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "," + " \"defiId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                                
                                    self.yellowDataInfo = "[" + self.YellowThisisit2 + "]"
                                
                                    let yellowData = self.yellowDataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("NKyellowData.json")
                                
                                do {
                                    try yellowData.write(to: url, atomically: true, encoding: .utf8)
                                    //MARK: Uncomment for debugging
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print(error.localizedDescription)
                                }
                                } else {
                                    
                                }
                                // MARK: ⚠️ SAVE YELLOW END
                                let dashCountYellow = String(dashCountYellow)
                                self.countDashYellowNumber = dashCountYellow
                                print("Yellow COUNT:", dashCountYellow)
                                
                                // MARK: ❌ SAVE RED START
                                if defidashboardStateString == "2" || defidashboardStateString == "4" {
//                                    if defidashboardStateString == "1" || defidashboardStateString == "3" {
                                    
                                dashCountRed += 1
                                    
                                    
                                let ownerId = dict.value(forKey: "ownerId")
                                let resultString = String(describing: ownerId!)
        //                                print("ownerId2", resultString)
                                
                                let ownerName = dict.value(forKey: "ownerName")
                                let defiOwnerName = String(describing: ownerName ?? "N/A")
                                
                                let defiId = dict.value(forKey: "defiId")
                                let defiIdString = String(describing: defiId!)
        //                                print("ownerId2", defiIdString)
                                
                                
                                let defiSerial = dict.value(forKey: "serial")
                                let defiSerialString = String(describing: defiSerial!)

                                let description = dict.value(forKey: "description")
                                let descriptionString = String(describing: description!)

                                    let newString3 = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()
                                    print("newString1:", newString3)
                                    
                                let stringid = """
                                              "ownerId":
                                              """
                                
                                    self.RedThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"dashboardState\"" + " : " + "\"" + defidashboardStateString + "\"" + "," +  " \"ownerName\"" + " : " + "\"" + defiOwnerName + "\"" + "," + " \"serialId\"" + " : " + "\"" + defiSerialString + "\"" + "," + " \"defiId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                                
                                    self.redDataInfo = "[" + self.RedThisisit2 + "]"
                                
                                    let redData = self.redDataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("NKredData.json")
                                
                                do {
                                    try redData.write(to: url, atomically: true, encoding: .utf8)
                                    //MARK: Uncomment for debugging
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print(error.localizedDescription)
                                }
                                } else {
                                    
                                }
                                // MARK: ❌ SAVE RED END
                                let dashCountRed = String(dashCountRed)
                                self.countDashRedNumber = dashCountRed
                                print("Red COUNT:", dashCountRed)

  
                                }
                                
                        }
                        
                        UserDefaults.standard.set("OK", forKey: "WaitForIt")
                    }
//                    }
                
                case .failure(let error):
                    print(error)
                    print("NKredData FILE ERROR")
                    
                }
            }

            
            var NK_GEOThisisit2: String = ""
            var NK_GEODataInfo  : String = ""
            
            AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "authkey" : authKey,
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            
            // MARK: 🌍 SAVE LATLON START
            .responseData {response in
                
                
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    if let status = json["data"].arrayObject {
                        
                        for obj in status {
                            if let dict = obj as? NSDictionary {
                                

                                if dict.value(forKey: "lat") as? Double == nil {
                                    
                                    print("EMPTY")
                                    
                                } else {
                                
                                    
                                    let dashboardStateGPS = dict.value(forKey: "dashboardState")
//                                    var Mystatus = dashboardStateGPS.
                                    
                                    
                                    let Mystatus = String(describing: dashboardStateGPS!)
                                    print("Mystatus", Mystatus)
                                    

                                        
                                    count += 1
                                    let countGeo = String(count)
                                    self.countGeoNumber = countGeo
                                    print("MYGEO", countGeo)
                                
                                let defiId = dict.value(forKey: "defiId")
                                let defiIdString = String(describing: defiId!)
//                                print("ownerId2", defiIdString)
                                    
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

                                    NK_GEOThisisit2.append("{" + stringid + "\""  + ownerSerialString + "\"" + "," + " \"ownerSerial\"" + " : " + "\"" + defiIdString  + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString  + "\"" + "," + " \"ownerid\"" + " : " + "\"" + resultString  + "\"" + "," + " \"latitude\"" + " : "  + latString  + "," + " \"longitude\"" + " : "  + lonString + "," + " \"status\"" + " : " + "\"" + Mystatus  + "\"" + "}" + ",")

                                NK_GEODataInfo = "[" + NK_GEOThisisit2 + "]"
                                    
                                let NK_GEOData = NK_GEODataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("latlon.json")
                                
                                do {
                                    try NK_GEOData.write(to: url, atomically: true, encoding: .utf8)
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print(error.localizedDescription)
                                }
                                    }
                            
                            }
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("LATLON FILE ERROR")
                    
                }
            }
            
            
            
            
            //MARK: NK COMM DATA
            var CommThisisit2: String = ""
            
            var commDataInfo : String = ""

            print("app folder path is \(NSHomeDirectory())")
            

            let urlComList = myURL! + myCommunicator
            
            AF.request(urlComList, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                    
                    if let status = json["data"].arrayObject {
                        
                        for obj in status {
                            if let dict = obj as? NSDictionary {
                                
                                let commId = dict.value(forKey: "commId")
                                let defiIdString = String(describing: commId!)
//                                print("commId", defiIdString)
                                
                                let ownerId = dict.value(forKey: "ownerId")
                                let resultString = String(describing: ownerId!)
//                                print("comownerId", resultString)
                                
                                let ownerName = dict.value(forKey: "ownerName")
                                let ownerNameString = String(describing: ownerName ?? "N/A")
                                

                                let ownerSerial = dict.value(forKey: "serial")
                                let resultSerial = String(describing: ownerSerial!)
                                
                                let description = dict.value(forKey: "description")
                                let descriptionString = String(describing: description!)
        //                        print("comdescription", descriptionString)
                                
                                let newString3 = descriptionString.components(separatedBy: .whitespacesAndNewlines).joined()
                                print("newString1:", newString3)
                                
                                
                                let stringid = """
                                              "ownerId":
                                              """
                                
                                CommThisisit2.append("{" + stringid + "\""  + resultString + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString + "\"" + "," + " \"commSerial\"" + " : " + "\"" + resultSerial + "\"" + "," + " \"commId\"" + " : " + "\"" + defiIdString + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                                
                                commDataInfo = "[" + CommThisisit2 + "]"
                                
                                let commData = commDataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("NKCommData.json")
                                
                                do {
                                    try commData.write(to: url, atomically: true, encoding: .utf8)
                                    //MARK: Uncomment for debugging
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print("COM ERROR", error.localizedDescription)
                                }
                            }
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW COMM")
                    
                }
            
            
            }
            
            
            
            
            //MARK: NK SERVICETICKETS

            var ServiceTicketFile: String = ""
            var serviceDataInfo : String = ""

            @AppStorage("move_dateTime") var move_dateTime: String?
            print("app folder path is \(NSHomeDirectory())")
//            var stmin0: Int = 0

            let urlServiceList = myURL! + "servicetickets"
            
            AF.request(urlServiceList, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                    
                    if let status = json["data"].arrayObject {
                        
                        for obj in status {
                            if let dict = obj as? NSDictionary {
                                
                                let stId = dict.value(forKey: "id")
                                let stIdString = String(describing: stId!)
//                                print("commId", defiIdString)
                                
//                                let ownerId = dict.value(forKey: "ownerId")
//                                let resultString = String(describing: ownerId ?? "N/A")
//                                print("comownerId", resultString)
                                
                                let title = dict.value(forKey: "title")
                                let titleString = String(describing: title ?? "N/A")
                                

                                let status = dict.value(forKey: "status")
                                let statusString = String(describing: status!)
                                
                                if statusString == "0" || statusString == "1" || statusString == "3" || statusString == "4" || statusString == "5" || statusString == "6" || statusString == "7" || statusString == "8" || statusString == "9" || statusString == "10" {
//                                    if defidashboardStateString == "1" || defidashboardStateString == "3" {
                                    
                                dashCountServiceTickets += 1
                                
                                
                                
                                let priority = dict.value(forKey: "priority")
                                let priorityString = String(describing: priority!)
                                
                                let additionalInfo = dict.value(forKey: "additionalInfo")
                                let additionalInfoString = String(describing: additionalInfo!)

                                let myAffected = (dict.value(forKey: "affected") as! NSArray).object(at: 0) as! NSDictionary
                                
                                
                                let defiSerial = myAffected.value(forKey: "defibrillatorSerial") as? String
                                let defibrillatorSerialString = String(describing: defiSerial ?? "NA")
                                print(defibrillatorSerialString)
                                
                                let defiId = myAffected.value(forKey: "defibrillatorId") as? String
                                let defibrillatorIdString = String(describing: defiId ?? "NA")
                                print(defibrillatorIdString)
                                
                                let comSerial = myAffected.value(forKey: "communicatorSerial") as? String
                                let comSerialString = String(describing: comSerial ?? "NA")
                                print(comSerialString)
                                
                                let comId = myAffected.value(forKey: "communicatorId") as? String
                                let comIdString = String(describing: comId ?? "NA")
                                print(comIdString)

                                let eventLatLon = dict.value(forKey: "statusDate")
                                let unixTimestamp = eventLatLon
                                    
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
                                    
                                    
                                let stringid = """
                                              "id":
                                              """
                                
                                
                                ServiceTicketFile.append("{" + stringid + "\""  + stIdString + "\"" + "," + " \"title\"" + " : " + "\"" + titleString + "\"" + "," + " \"status\"" + " : " + "\"" + statusString + "\"" + "," + " \"priority\"" + " : " + "\"" + priorityString + "\"" + ","  + " \"eventTime\"" + " : " + "\"" + newDateTimString + "\"" + "," + " \"DefibrillatorSerial\"" + " : " + "\"" + defibrillatorSerialString + "\"" + "," + " \"DefibrillatorId\"" + " : " + "\"" + defibrillatorIdString + "\"" + "," + " \"CommunicatorSerial\"" + " : " + "\"" + comSerialString + "\"" + "," + " \"CommunicatorId\"" + " : " + "\"" + comIdString + "\""  + "," + " \"additionalInfo\"" + " : " + "\"" + additionalInfoString + "\"" + "}" + ",")

                                serviceDataInfo = "[" + ServiceTicketFile + "]"
                                
                                let stData = serviceDataInfo
                                let url = self.getDocumentsDirectory().appendingPathComponent("ServiceTicketsNK.json")
                                
                                do {
                                    try stData.write(to: url, atomically: true, encoding: .utf8)
                                    //MARK: Uncomment for debugging
                                    //                            let input = try String(contentsOf: url)
                                    //                            print(input)
                                } catch {
                                    print("SERVICE ERROR", error.localizedDescription)
                                }
                                } else {
                                    
                                }
                                // MARK:SAVE ST END
                                let dashCountServiceTickets = String(dashCountServiceTickets)
                                self.countDashServiceTicketNumber = dashCountServiceTickets
                                print("ST COUNT:", dashCountServiceTickets)
                        }
                    }
//                        UserDefaults.standard.set("OK", forKey: "WaitForIt")
                    
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW SERVICE")
                    
                }
            
            
            }
            
            


        } else {
        
            //MARK:  START OLD
        defaults.set(email, forKey: "DataUIDUser")
        defaults.set(password, forKey: "DataPWDUser")
        
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "defibrillators?includeWithAdminStatus=monitored"
        let url = myURL! + comLink
        
        let credentialData = "\(email):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
        let base64Credentials = credentialData.base64EncodedString()
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            //            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
                .responseData { [self]response in
//                .responseJSON { [self] response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print("app folder path is \(NSHomeDirectory())")
                
                print("DEFITOT:", json.count)
                let countall = String(json.count)
                
                
                getit = countall
                
                for(_,subJson):(String, JSON) in json {
                    
                    // MARK: 🔢 COUNTER START
                    
                    let status = subJson["status"].dictionaryValue
                    
                    let sorted = status.sorted(by: { $0.key > $1.key })
                    let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                    
                    
                    // MARK: ✅ SAVE Green START
                    if firstValue == "available" {
                        
                        countGreen += 1
                        
                        print("countGreen", countGreen)

                        let owner = subJson["@id"].stringValue
                        
                        let description = (subJson["description"]["en"].string ?? "..")
                        print("Green Description:", description )
                        let ownerid = (subJson["ownerId"].string ?? "..")
                        print("Green Owner:",ownerid )
                        print("Green ID:\(owner)")
                        
                        let newString = owner.replacingOccurrences(of: "\n \n", with: "")
                        print("newString:", newString)
                        
                        let newString1 = newString.replacingOccurrences(of: "\n", with: "")
                        print("newString1:", newString1)
                        
                        let newString2 = newString1.replacingOccurrences(of: "\n\n", with: "")
                        print("newString2:", newString2)
                        
                        let newString3 = newString2.replacingOccurrences(of: "\n\n\n", with: "")
                        print("newString3:", newString3)
                        
//                        let trimmedString = description.components(separatedBy: .newlines).joined()
                        
                        
                        let stringid = """
                                      "id":
                                      """
                        
                        GreenThisisit2.append("{" + stringid + "\""  + owner + "\"" + "," + " \"ownerId\"" + " : " + "\"" + ownerid + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                        
                        greenDataInfo = "[" + GreenThisisit2 + "]"
                        
                        let greenData = greenDataInfo
                        let url = self.getDocumentsDirectory().appendingPathComponent("greenData.json")
                        
                        do {
                            try greenData.write(to: url, atomically: true, encoding: .utf8)
                            //MARK: Uncomment for debugging
                            //                            let input = try String(contentsOf: url)
                            //                            print(input)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        
                    } else {
                        
                        
                        
                    }
                    // MARK: ✅ SAVE Green END
                    let countGreen = String(countGreen)
                    self.countGreenNumber = countGreen
                    print("Green COUNT:", countGreen)
                    
                    
                    //                    if firstValue == "available" {
                    //                        countGreen += 1
                    //                    } else {
                    //
                    //                    }
                    //
                    //                    let countGreen = String(countGreen)
                    //                    self.countGreenNumber = countGreen
                    
                    // MARK: ⚠️ SAVE YELLOW START
                    if firstValue == "overdue" || firstValue == "preError" || firstValue == "warning" {
                        
                        countYellow += 1
                        
                        let owner = subJson["@id"].stringValue
                        
                        let description = (subJson["description"]["en"].string ?? "..")
                        print("Yellow Description:", description )
                        let ownerid = (subJson["ownerId"].string ?? "..")
                        print("Yellow Owner:",ownerid )
                        print("Yellow ID:\(owner)")
                        
                        let newString = owner.replacingOccurrences(of: "\n \n", with: "")
                        print("newString:", newString)
                        
                        let newString1 = newString.replacingOccurrences(of: "\n", with: "")
                        print("newString1:", newString1)
                        
                        let newString2 = newString1.replacingOccurrences(of: "\n\n", with: "")
                        print("newString2:", newString2)
                        
                        let newString3 = newString2.replacingOccurrences(of: "\n\n\n", with: "")
                        print("newString3:", newString3)
                        
                     
//                        let trimmedString = description.components(separatedBy: .newlines).joined()
                        
                        
                        let stringid = """
                        "id":
                        """
                        
                        YellowThisisit2.append("{" + stringid + "\""  + owner + "\"" + "," + " \"ownerId\"" + " : " + "\"" + ownerid + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                        
                        yellowDataInfo = "[" + YellowThisisit2 + "]"
                        
                        let yellowData = yellowDataInfo
                        let url = self.getDocumentsDirectory().appendingPathComponent("yellowData.json")
                        
                        do {
                            try yellowData.write(to: url, atomically: true, encoding: .utf8)
                            //MARK: Uncomment for debugging
                            //                            let input = try String(contentsOf: url)
                            //                            print(input)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    } else {
                        
                    }
                    // MARK: ⚠️ SAVE YELLOW END
                    let countYellow = String(countYellow)
                    self.countYellowNumber = countYellow
                    print("YELLOW COUNT:", countYellow)
                    
                    // MARK: ❌ SAVE RED START
                    
                    if firstValue == "timeout" || firstValue == "unknown" || firstValue == "error" {
                        
                        //                        print("RED First:\(countRed)")
                        countRed += 1
                        
                        let owner = subJson["@id"].stringValue
                        let description = (subJson["description"]["en"].string ?? "..")
                        print("RED Description:", description )
                        let ownerid = (subJson["ownerId"].string ?? "..")
                        
                        let newString = owner.replacingOccurrences(of: "\n \n", with: "")
                        print("newString:", newString)
                        
                        let newString0 = newString.replacingOccurrences(of: "\n ", with: "")
                        print("newString1:", newString0)
                        
                        let newString1 = newString0.replacingOccurrences(of: "\n", with: "")
                        print("newString1:", newString1)
                        
                        let newString2 = newString1.replacingOccurrences(of: "\n\n", with: "")
                        print("newString2:", newString2)
                        
                        let newString3 = newString2.replacingOccurrences(of: "\n\n\n", with: "")
                        print("newString3:", newString3)
                        
//                        let trimmedString = description.components(separatedBy: .newlines).joined()
//
//                        print("RED Description:", trimmedString )
                        let stringid = """
                        "id":
                        """
                        
                        RedThisisit2.append("{" + stringid + "\""  + owner + "\"" + "," + " \"ownerId\"" + " : " + "\"" + ownerid + "\"" + "," + " \"description\"" + " : " + "\"" + newString3 + "\"" + "}" + ",")
                        redDataInfo = "[" + RedThisisit2 + "]"
                        
                        let redData = redDataInfo
                        let url = self.getDocumentsDirectory().appendingPathComponent("redData.json")
                        
                        do {
                            try redData.write(to: url, atomically: false, encoding: .utf8)
                            //MARK: Uncomment for debugging
                            //                            let input = try String(contentsOf: url)
                            //                            print(input)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    } else {
                        
                    }
                    // MARK: ❌ SAVE RED END
                    let countRed = String(countRed)
                    self.countRedNumber = countRed
                    print("RED COUNT:", countRed)
                    
                    // MARK: 🔢 COUNTER END
                    
                    
                    let geoLocation = subJson["geoLocation"].dictionaryValue
                    // MARK: 🌍 GEO INFO START
                    
                    if geoLocation.count == 0 {
                        
                    } else {
                        
                        
                        print("firstValue:", firstValue)
                        
                        count += 1
                        
                        let countGeo = String(count)
                        self.countGeoNumber = countGeo
                        let geoLocationLat = subJson["geoLocation"]["lat"].double
                        let geoLocationLon = subJson["geoLocation"]["lng"].double
                        let owner = subJson["@id"].stringValue
                        let currentStatus = firstValue.stringValue
                        let defiOwner =  subJson["ownerId"].stringValue
                        
                        //MARK: GET THE LOCATION
                        
                        let latdoub: Double = geoLocationLat ?? 0
//                        let latstring: String = String(format: "%f ", latdoub)
                        let latstring: String = String(format: "%.4f ", latdoub)

                        
                        
                        let londoub: Double = geoLocationLon ?? 0
//                        let lonstring: String = String(format: "%f", londoub)
                        let lonstring: String = String(format: "%.4f", londoub)
                        
                        let ownerNameString = ""
                        let ownerSerialString = ""
                        
                        let stringid = """
                        "idCode":
                        """
                        
//                        let stringid = """
//                        "id":
//                        """
                        
                        Thisisit2.append("{" + stringid + "\""  + owner + "\"" + "," + " \"ownerid\"" + " : " + "\"" + defiOwner  + "\"" + "," + " \"ownerName\"" + " : " + "\"" + ownerNameString  + "\"" + "," + " \"ownerSerial\"" + " : " + "\"" + ownerSerialString  + "\"" + "," + " \"latitude\"" + " : "  + latstring  + "," + " \"longitude\"" + " : "  + lonstring + "," + " \"status\"" + " : " + "\"" + currentStatus  + "\"" + "}" + ",")

                        latloninof = "[" + Thisisit2 + "]"
                        
                    }
                    
                    let owner = subJson["@id"].stringValue
                    print("DEFI:", json.count)
                    
                    self.defriAll = owner
                    self.baseUser = email
                    
                }
                
                let str = latloninof
                let url = self.getDocumentsDirectory().appendingPathComponent("latlon.json")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    //MARK: Uncomment for debugging
                    //                    let input = try String(contentsOf: url)
                    //                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
                // MARK: 🌍 GEO INFO END
                UserDefaults.standard.set("YES", forKey: "activeMap")
                
            case .failure(let error):
                print(error)
            }
        }
        
        let comLinkCom = "communicators"
        let urlCom = myURL! + comLinkCom
        
        AF.request(urlCom, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData(completionHandler: { [self] (data)  in
            
            let json = try! JSON(data: data.data!)
            
            print(json.index)
            print("COMM:", json.count)
            
            let countall = String(json.count)
            let commCountall = Int(json.count)
            
            getit2 = countall
            commComnter = commCountall
        })
        //OLD
        let comLinkService = "serviceTickets?"
        let urlService = myURL! + comLinkService
        
        print(urlService)
        AF.request(urlService, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            //            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData(completionHandler: { [self] (data)  in
            
            let json = try! JSON(data: data.data!)
            
            print(json.index)
            print("SERVICE:", json.count)
            
            for(_,subJson):(String, JSON) in json {
                
                let status = subJson["status"].dictionaryValue
                
                let sorted = status.sorted(by: { $0.key > $1.key })
                let firstValue =  Array(arrayLiteral: sorted[0])[0].value
                
                let firstValueDate =  Array(arrayLiteral: sorted[0])[0].key
                print("Current Status Date:\(firstValueDate)")
                
                
                // MARK: 🎟 SAVE SERVICET START
                if firstValue == "new" || firstValue == "analysis" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceSentToService" || firstValue == "cloud.cardilink.defibrillator.RMA.created" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceReturnedToCustomer" || firstValue == "cloud.cardilink.defibrillator.RMA.functionalDeviceChecks" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceRepaired" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceRepairStarted" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceReceivedFromCustomer" || firstValue == "cloud.cardilink.defibrillator.RMA.deviceBackAtCustomer" || firstValue == "cloud.cardilink.communicator.RMA.deviceSentToService" || firstValue ==
                    "cloud.cardilink.communicator.RMA.created" || firstValue == "cloud.cardilink.communicator.RMA.deviceReturnedToCustomer" || firstValue == "cloud.cardilink.communicator.RMA.functionalDeviceChecks" || firstValue == "cloud.cardilink.communicator.RMA.deviceRepaired" || firstValue == "cloud.cardilink.communicator.RMA.deviceRepairStarted" || firstValue == "cloud.cardilink.communicator.RMA.deviceReceivedFromCustomer" || firstValue == "cloud.cardilink.communicator.RMA.deviceBackAtCustomer" {
                    
                    countService += 1
                    
                    let status = firstValue.stringValue
                    let statusDate = (firstValueDate)
                    let ownerid = subJson["@id"].stringValue
                    let description = (subJson["title"]["en"].string ?? "..")
                    let additionalInfo = (subJson["additionalInfo"]["en"].string ?? "..")
                    
                    
                    
                    //MARK: TO FIND EXTRA TEXT
                    //                    let components = additionalInfo.components(separatedBy: "\n\n\n").filter { $0 != "" }
                    //                    print("components:", components)
                    //MARK: END TO FIND EXTRA TEXT
                    
                    let newString = additionalInfo.replacingOccurrences(of: "\n \n", with: "")
                    print("newString:", newString)
                    
                    let newString1 = newString.replacingOccurrences(of: "\n", with: "")
                    print("newString1:", newString1)
                    
                    let newString2 = newString1.replacingOccurrences(of: "\n\n", with: "")
                    print("newString2:", newString2)
                    
                    let newString3 = newString2.replacingOccurrences(of: "\n\n\n", with: "")
                    print("newString3:", newString3)
                    
                    
                    
                    
                    
                    
                    
                    let trimmedString = description.components(separatedBy: .newlines).joined()
                    
                    let stringid = """
                    "id":
                    """
                    
                    ServiceTicket.append("{" + stringid + "\""  + ownerid + "\"" + "," + " \"ownerId\"" + " : " + "\"" + newString3 + "\"" + "," + " \"description\"" + " : " + "\"" + trimmedString + "\"" + "," + " \"status\"" + " : " + "\"" + status + "\"" + "," + " \"statusDate\"" + " : " + "\"" + statusDate + "\"" + "}" + ",")
                    serviceDataInfo = "[" + ServiceTicket + "]"
                    
                    
                    let serviceData = serviceDataInfo
                    
                    let url = self.getDocumentsDirectory().appendingPathComponent("service.json")
                    
                    do {
                        try serviceData.write(to: url, atomically: false, encoding: .utf8)
                        //MARK: Uncomment for debugging
                        //                        let input = try String(contentsOf: url)
                        //                        print(input)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    
                }
                // MARK: 🎟 SAVE SERVICET END
                let countall = String(countService)
                getitService = countall
                
            }
            
        })
        }
        return  true
    }
   
    
    func logout(){
        
        defaults.set("", forKey: "DataUIDUser")
        defaults.set("", forKey: "DataPWDUser")
        defaults.set("NO", forKey: "callServiceTickets")
        defaults.set("No", forKey: "Moving")
        
        if rememberMe == "NO" {
            
            defaults.set(false, forKey: "rememberme")
            defaults.set("", forKey: "username")
            defaults.set("", forKey: "userpwd")
            
        } else {
            
        }
        
        ServiceTicket = ""
        RedThisisit2 = ""
        YellowThisisit2 = ""
        Thisisit2 = ""
        self.token = nil
        
    }
    
}

////MARK: DEF
//func getDefInfo (){
//
//    let defaults = UserDefaults.standard
//
//    let email = defaults.string(forKey: "DataUIDUser")
//    let password = defaults.string(forKey: "DataPWDUser")
//    let Email = (email!)
//    let Password = (password!)
//
//    let myURL = defaults.string(forKey: "myPortal")
//    let comLink = "defibrillators"
//    let url = myURL! + comLink
//
//    let credentialData = "\(Email):\(Password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//
//    let base64Credentials = credentialData.base64EncodedString()
//    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        //            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        "Authorization": "Basic \(base64Credentials)",
//        "Accept": "application/json",
//        "Content-Type": "application/json"
//    ]
//    )
//
//    .responseData(completionHandler: { [] (data)  in
//
//        let json = try! JSON(data: data.data!)
//
//        print(json.index)
//        print("COUNT:", json.count)
//
//        UserDefaults.standard.set(json.count, forKey: "DefCount")
//
//    })
//
//}
//
//
////MARK: COM
//func getComInfo (){
//
//    let defaults = UserDefaults.standard
//
//    let email = defaults.string(forKey: "DataUIDUser")
//    let password = defaults.string(forKey: "DataPWDUser")
//
//    let myURL = defaults.string(forKey: "myPortal")
//
//    let Email = (email!)
//    let Password = (password!)
//
//    let comLink = "communicators"
//
//    let url = myURL! + comLink
//
//
//    let credentialData = "\(Email):\(Password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//
//    let base64Credentials = credentialData.base64EncodedString()
//    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        //            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        "Authorization": "Basic \(base64Credentials)",
//        "Accept": "application/json",
//        "Content-Type": "application/json"
//    ]
//    )
//
//    .responseData(completionHandler: { [] (data)  in
//
//        let json = try! JSON(data: data.data!)
//        print(json.index)
//        print("COUNT:", json.count)
//        UserDefaults.standard.set(json.count, forKey: "CommCount")
//
//    })
//}

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

