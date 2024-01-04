//
//  BaseDataModels.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

//MARK: NK DATA TEST
//func getNKData(){
//    
//    
//    let defaults = UserDefaults.standard
////    var baseUser = ""
////    var basePass = ""
//    
//    
////    let email = defaults.string(forKey: "DataUIDUser")
////    let password = defaults.string(forKey: "DataPWDUser")
//    
//    
//    let AuthKey = defaults.string(forKey: "DATASTRING")
////    defaults.set(dataString, forKey: "DATASTRING")
//    
//    print("NEXT DATASTRING: ", AuthKey!)
////    baseUser = email!
////    basePass = password!
//    
//    let authKey = AuthKey!
//    
//    let myURL = "https://primedic.dev.cardi-link.cloud/api/communicators" //defaults.string(forKey: "myPortal")
////    let comLink = "users/"
//    let url = myURL // + comLink + baseUser
//    
////    let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
////
////    let base64Credentials = credentialData.base64EncodedString()
////
//    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
////        "Authorization": "Basic \(base64Credentials)",
//        "authkey" : authKey,
//        "Accept": "application/json",
//        "Content-Type": "application/json"
//    ]
//    )
//    
//    .responseData {response in
//        switch response.result {
//        case .success(let value):
//            
//            let json = JSON(value)
//            print(json)
////        }
//    case .failure(let error):
//        print(error)
//        print("NOOOOOO NK DATA")
//    }
//}
//
//}

//MARK: UserData
func getUserData(){
    
    var baseUser = ""
    let defaults = UserDefaults.standard
    
    
    let myBackend = defaults.string(forKey: "Backend")
    
    if myBackend == "NEW" {
        
        print("Backend: ", myBackend!)
        
        let email = defaults.string(forKey: "DataUIDUser")
        
        
        baseUser = email!
        print(baseUser)
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        
        let myUser = "users/byemail/"
        let url = myURL! + myUser + baseUser
        //        let url = myUser + baseUser
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            //        "Authorization": "Basic \(base64Credentials)",
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
                    
                    
                    if let username = json["data"]["name"].string {
                        print(username)
                        
                        let owner = json["data"]["id"]
                        print("@id:" ,owner)
                        let description = json["data"]["userDescription"]
                        print("Description:", description)
                        let emailUser = json["data"]["email"]
                        print("EMail:",emailUser)
                        let telephoneUser = json["data"]["telephone"]
                        print("Telephone:",telephoneUser)
                        let mobilePhoneUser = json["data"]["mobilephone"]
                        print("mobilePhone:",mobilePhoneUser)
                        let telegramUser = json["data"]["telegram"]
                        print("telegramUser:",telegramUser)
                        let homepageUser = json["data"]["homepage"]
                        print("homepageUser:",homepageUser)
                        
                        
                        UserDefaults.standard.set(json["data"]["name"].stringValue, forKey: "userOwner")
                        UserDefaults.standard.set(json["data"]["id"].stringValue, forKey: "userID")
                        UserDefaults.standard.set(json["data"]["userDescription"].string, forKey: "userDescription")
                        UserDefaults.standard.set(json["data"]["email"].stringValue, forKey: "userEmail")
                        UserDefaults.standard.set(json["data"]["telephone"].stringValue, forKey: "userTelephone")
                        UserDefaults.standard.set(json["data"]["mobilephone"].stringValue, forKey: "usermobilePhone")
                        UserDefaults.standard.set(json["data"]["telegram"].stringValue, forKey: "usertelegram")
                        UserDefaults.standard.set(json["data"]["homepage"].stringValue, forKey: "userhomepage")
                        
 
                        
                        
//                        UserDefaults.standard.set("OK", forKey: "WaitForIt")
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO NEW USER")
                }
            }
        
    } else {
        
        var baseUser = ""
        var basePass = ""
        
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        
        baseUser = email!
        basePass = password!
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "users/"
        let url = myURL! + comLink + baseUser
        
        let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
        let base64Credentials = credentialData.base64EncodedString()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        )
        
            .responseData {response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    if let ownerid = json["name"].string {
                        print("Name:",ownerid)
                        let owner = json["@id"]
                        print("@id:" ,owner)
                        let description = json["description"]["en"].string
                        print("Description:", description ?? "..")
                        let emailUser = json["email"]
                        print("EMail:",emailUser)
                        let telephoneUser = json["telephone"]
                        print("Telephone:",telephoneUser)
                        let mobilePhoneUser = json["mobilePhone"]
                        print("mobilePhone:",mobilePhoneUser)
                        let telegramUser = json["telegramUser"]
                        print("telegramUser:",telegramUser)
                        let homepageUser = json["homepageUser"]
                        print("homepageUser:",homepageUser)
                        
                        
                        UserDefaults.standard.set(json["name"].stringValue, forKey: "userOwner")
                        UserDefaults.standard.set(json["@id"].stringValue, forKey: "userID")
                        UserDefaults.standard.set(json["description"]["en"].string, forKey: "userDescription")
                        UserDefaults.standard.set(json["email"].stringValue, forKey: "userEmail")
                        UserDefaults.standard.set(json["telephone"].stringValue, forKey: "userTelephone")
                        UserDefaults.standard.set(json["mobilephone"].stringValue, forKey: "usermobilePhone")
                        UserDefaults.standard.set(json["telegram"].stringValue, forKey: "usertelegram")
                        UserDefaults.standard.set(json["homepage"].stringValue, forKey: "userhomepage")
                        
                    }
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD USER")
                }
            }
    }
}

//MARK: DEFI HARDWARE
//func gethardwaredata_OLD() {
//    
////    var baseUser = ""
//    let defaults = UserDefaults.standard
//    
//    
//    let myBackend = defaults.string(forKey: "Backend")
//    
//    if myBackend == "NEW" {
//    
//        print("NEW gethardwaredata")
//        
//        
//    } else {
//    
//    
//    
//    let defaults = UserDefaults.standard
//    var baseUser = ""
//    var basePass = ""
//    
//    let email = defaults.string(forKey: "DataUIDUser")
//    let password = defaults.string(forKey: "DataPWDUser")
//    let selectedDefi = defaults.string(forKey: "SelectedDefi")
//    
//    baseUser = email!
//    basePass = password!
//    
//    let myURL = defaults.string(forKey: "myPortal")
//    let comLink = "defibrillators/"
//    let theone =  selectedDefi ?? ""
//    let hardware = "/hardware"
//    let url = myURL! + comLink + theone + hardware
//    
//    print("gethardwaredata", url)
//    let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//    
//    let base64Credentials = credentialData.base64EncodedString()
//    
//    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
//        "Authorization": "Basic \(base64Credentials)",
//        "Accept": "application/json",
//        "Content-Type": "application/json"
//    ]
//    )
//    
//    .responseData {response in
//        switch response.result {
//        case .success(let value):
//            
//            let json = JSON(value)
//            
//            for (index,subJson):(String, JSON) in json {
//                print("defi:\(index) 2:\(subJson)")
//            }
//            
//            if  let owner = json["@id"].string {
//                print("@id:" ,owner)
//                let harwareModel = json["model"].string
//                print("harwareModel:", harwareModel ?? "..")
//                let owner = json["@id"]
//                print("@id:" ,owner)
//                let description = json["description"]["en"].string
//                print("Description:", description ?? "..")
//                let languageSettings = json["languageSettings"].string
//                print("languageSettings:" ,languageSettings ?? "..")
//                let batchId = json["batchId"].string
//                print("batchId:" ,batchId ?? "..")
//                let productionDate = json["productionDate"].string
//                print("productionDate:" ,productionDate ?? "..")
//                let activationDate = json["activationDate"].string
//                print("activationDate:" ,activationDate ?? "..")
//                
//                let prodfinalDate = productionDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
//                
//                let activationfinalDate = activationDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
//                
//                UserDefaults.standard.set(json["model"].stringValue, forKey: "harwareModel")
//                UserDefaults.standard.set(json["@id"].stringValue, forKey: "harwareDefriID")
//                UserDefaults.standard.set(json["description"]["en"].string, forKey: "harwareDefriDescription")
//                UserDefaults.standard.set(json["languageSettings"].stringValue, forKey: "harwareLanguage")
//                UserDefaults.standard.set(json["batchId"].stringValue, forKey: "hardwareBatchID")
//                
//                UserDefaults.standard.set(prodfinalDate, forKey: "hardwareProddate")
//                UserDefaults.standard.set(activationfinalDate, forKey: "hardwareActicatonDate")
//                
//                
//                
//                let serialPCB = json["PCB"]["serialNumber"].string
//                print("serialPCB:", serialPCB ?? "..")
//                let batchPCB = json["PCB"]["batchId"].string
//                print("batchPCB:", batchPCB ?? "..")
//                let manufacturerPCB = json["PCB"]["manufacturer"].string
//                print("manufacturerPCB:", manufacturerPCB ?? "..")
//                let hardwarePCB = json["PCB"]["hardwareVersion"].string
//                print("hardwarePCB:", hardwarePCB ?? "..")
//                let firmwarePCB = json["PCB"]["firmwareVersion"].string
//                print("firmwarePCB:", firmwarePCB ?? "..")
//                let productionDatePCB = json["PCB"]["productionDate"].string
//                print("productionDatePCB:" ,productionDatePCB ?? "..")
//                
//                if productionDatePCB == nil {
//                    UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
//                    
//                } else {
//                    
//                    let prodfinalDatePCB = productionDatePCB?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
//                    UserDefaults.standard.set(prodfinalDatePCB, forKey: "productionDatePCB")
//                }
//                
//                UserDefaults.standard.set(json["PCB"]["serialNumber"].stringValue, forKey: "serialPCB")
//                UserDefaults.standard.set(json["PCB"]["batchId"].stringValue, forKey: "batchPCB")
//                UserDefaults.standard.set(json["PCB"]["manufacturer"].string, forKey: "manufacturerPCB")
//                UserDefaults.standard.set(json["PCB"]["hardwareVersion"].stringValue, forKey: "hardwarePCB")
//                UserDefaults.standard.set(json["PCB"]["firmwareVersion"].stringValue, forKey: "firmwarePCB")
//                
//                let modelElectrodes = json["electrodes"]["model"].string
//                print("modelElectrodes:",modelElectrodes ?? "..")
//                let batchElectrodes = json["electrodes"]["batchId"].string
//                print("batchElectrodes:", batchElectrodes ?? "..")
//                let experationDateElectrodes = json["electrodes"]["expirationDate"].string
//                print("experationDateElectrodes:" ,experationDateElectrodes ?? "..")
//                
//                if experationDateElectrodes == nil {
//                    UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
//                } else {
//                    let prodfinalDateBattery = experationDateElectrodes?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
//                    UserDefaults.standard.set(prodfinalDateBattery, forKey: "experationDateElectrodes")
//                }
//                
//                UserDefaults.standard.set(json["electrodes"]["model"].stringValue, forKey: "modelElectrodes")
//                UserDefaults.standard.set(json["electrodes"]["batchId"].stringValue, forKey: "batchElectrodes")
//                
//                
//                let modelBattery = json["battery"]["model"].string
//                print("modelBattery:",modelBattery ?? "..")
//                let batchBattery = json["battery"]["batchId"].string
//                print("batchBattery:", batchBattery ?? "..")
//                let productionDateBattery = json["battery"]["activationDate"].string
//                print("productionDateBattery:" ,productionDateBattery ?? "..")
//                
//                if productionDateBattery == nil {
//                    UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
//                } else {
//                    let prodfinalDateBattery = productionDateBattery?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
//                    UserDefaults.standard.set(prodfinalDateBattery, forKey: "activationsDateBattery")
//                }
//                
//                UserDefaults.standard.set(json["battery"]["model"].stringValue, forKey: "modelBattery")
//                UserDefaults.standard.set(json["battery"]["batchId"].stringValue, forKey: "batchBattery")
//                
//                let addressBLE = json["bluetooth"]["MACAddress"].string
//                print("addressBLE:",addressBLE ?? "..")
//                
//                UserDefaults.standard.set(json["bluetooth"]["MACAddress"].stringValue, forKey: "addressBLE")
//                
//                let geoLocationLat = json["geoLocation"]["lat"].double
//                print("geoLocationLat:",geoLocationLat ?? 33.814971)
//                let geoLocationLon = json["geoLocation"]["lng"].double
//                print("geoLocationLon:", geoLocationLon ?? -117.921279)
//                
//                UserDefaults.standard.set(json["geoLocation"]["lat"].stringValue, forKey: "geoLocationLat")
//                UserDefaults.standard.set(json["geoLocation"]["lng"].stringValue, forKey: "geoLocationLon")
//                
//                let geoAddressStreet = json["address"]["street"].string
//                print("geoAddressStreet:",geoAddressStreet ?? "N/A")
//                let geoAddressNumber = json["address"]["houseNumber"].string
//                print("geoAddressNumber:", geoAddressNumber ?? "N/A")
//                
//                let geoAddressFloor = json["address"]["floorLevel"].string
//                print("geoAddressFloor:", geoAddressFloor ?? "N/A")
//                let geoAddressPostal = json["address"]["postalCode"].string
//                print("geoAddressPostal:", geoAddressPostal ?? "N/A")
//                
//                
//                let geoAddressCity = json["address"]["city"]["en"].string
//                print("geoAddressCity:", geoAddressCity ?? "N/A")
//                
//                UserDefaults.standard.set(json["address"]["street"].stringValue, forKey: "geoAddressStreet")
//                UserDefaults.standard.set(json["address"]["houseNumber"].stringValue, forKey: "geoAddressNumber")
//                
//                UserDefaults.standard.set(json["address"]["floorLevel"].stringValue, forKey: "geoAddressFloor")
//                UserDefaults.standard.set(json["address"]["postalCode"].stringValue, forKey: "geoAddressPostal")
//                
//                
//                UserDefaults.standard.set(json["address"]["country"].stringValue, forKey: "geoAddressCountry")
//                UserDefaults.standard.set(json["address"]["city"]["en"].stringValue, forKey: "geoAddressCity")
//                UserDefaults.standard.set(json["address"]["comment"]["en"].stringValue, forKey: "geoAddressComment")
//                
//                UserDefaults.standard.set(json["geoFence"]["type"].stringValue, forKey: "geoFenceType")
//                UserDefaults.standard.set(json["geoFence"]["radius"].stringValue, forKey: "geoFenceRadius")
//                
//            }
//            
//            print("YESSSSSSS")
//            
//        case .failure(let error):
//            print(error)
//            print("NOOOOOO OLD DEO")
//            
//        }
//    }
//    }
//}


//MARK: DefibFetcher
class DefibFetcher: ObservableObject {
    
    @Published var defiDataTest = [DefiData]()
    
    init(){
        load()
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myURL = defaults.string(forKey: "myPortal")
        
        let comLink = "defibrillators"
        
        let url = myURL! + comLink
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        //MARK: RESULT
            .responseData {response in
                
                
                let jsonString =  response.data
                if jsonString == nil {
                    print("COM OEPS")
                } else {
                    
                    do {
                        let comdata = try JSONDecoder().decode([DefiData].self, from: jsonString!)
                        self.defiDataTest = comdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣💣💣💣💣💣 DefibFetcher FILE ERROR")
                    }
                }
            }
    }
}


//MARK: ServiceTicketFetcherComs
class ServiceTicketFetcherComms: ObservableObject {
    
    
    
    
    
    
    
    
    @Published var fetchservicetickets = [SeriveTicket]()
    
    init(){
        
        let defaults = UserDefaults.standard
        
        let myBackend = defaults.string(forKey: "Backend")
        
        if myBackend == "NEW" {
            
            print("NEW SeriveTicket")
            
            
        } else {
            
            
            
            
            
            
            let defaults = UserDefaults.standard
            let activeMap = defaults.string(forKey: "callServiceTickets")
            
            if activeMap == "YES" {
                print("YES SERVICE")
                
                load()
                
            } else {
                
                print("NO SERVICE ")
                
            }
        }
        
        
        func load() {
            
            let defaults = UserDefaults.standard
            var baseUser = ""
            var basePass = ""
            
            let email = defaults.string(forKey: "DataUIDUser")
            let password = defaults.string(forKey: "DataPWDUser")
            let selectedDefi = defaults.string(forKey: "commdetailID")
            
            baseUser = email ?? ""
            basePass = password ?? ""
            
            let myURL = defaults.string(forKey: "myPortal") ?? ".."
            let comLink = "communicators/"
            let theone =  selectedDefi ?? ""
            let tickets = "/serviceTickets"
            let url = myURL +  comLink + theone + tickets
            
            
            
            print("ServiceTicketFetcherComms", url)
            
            let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            
            let base64Credentials = credentialData.base64EncodedString()
            
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            //MARK: RESULT
                .responseData {response in
                    
                    let jsonString =  response.data
                    
                    if jsonString == nil {
                        print("OEPS")
                    } else {
                        
                        do {
                            
                            let serviceTickets = try JSONDecoder().decode([SeriveTicket].self, from: jsonString!)
                            self.fetchservicetickets = serviceTickets
                            
                            if serviceTickets.isEmpty {
                                UserDefaults.standard.set("YES", forKey: "NoServiceTicketsForComms")
                            } else {
                                UserDefaults.standard.set("NO", forKey: "NoServiceTicketsForComms")
                            }
                            
                        } catch {
                            //handle error
                            print(error)
                            print("💣 ServiceTicketFetcherComms FILE ERROR")
                        }
                        
                        
                    }
                }
        }
    }
}



//MARK: ServiceTicketFetcher
class ServiceTicketFetcher: ObservableObject {
    
    @Published var fetchservicetickets = [SeriveTicket]()
    
    init(){
        let defaults = UserDefaults.standard
        let activeMap = defaults.string(forKey: "callServiceTickets")
        
        if activeMap == "YES" {
            print("YES SERVICE")
            
            load()
            
        } else {
            
            print("NO SERVICE ")
            
        }
    }
    
    
    func load() {
        
        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        let myURL = defaults.string(forKey: "myPortal") ?? ".."
        let comLink = "defibrillators/"
        let theone =  selectedDefi ?? ""
        let tickets = "/serviceTickets"
        let url = myURL +  comLink + theone + tickets
        
        
        
        print("ServiceTicketFetcher", url)
        
        let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
        let base64Credentials = credentialData.base64EncodedString()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        //MARK: RESULT
            .responseData {response in
                
                let jsonString =  response.data
                if jsonString == nil {
                    print("OEPS")
                } else {
                    
                    do {
                        let serviceTickets = try JSONDecoder().decode([SeriveTicket].self, from: jsonString!)
                        self.fetchservicetickets = serviceTickets
                        
                        if serviceTickets.isEmpty {
                            UserDefaults.standard.set("YES", forKey: "NoServiceTicketsForDefi")
                        } else {
                            UserDefaults.standard.set("NO", forKey: "NoServiceTicketsForDefi")
                        }
                        
                    } catch {
                        //handle error
                        print(error)
                        print("💣 ServiceTicketFetcher FILE ERROR")
                    }
                }
            }
    }
}

//MARK: CommsFetcher
class CommsFetcher: ObservableObject {
    
    @Published var fetchedcoms = [acme]()
    
    init(){
        load()
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        
        
        var baseUser = ""
        var basePass = ""
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        if baseUser == ""  {
            print("COM POOP")
        } else {
            
            
            let myURL = defaults.string(forKey: "myPortal")
            let comLink = "communicators?includeStatus=monitoring"
            let url = myURL! + comLink
            let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let base64Credentials = credentialData.base64EncodedString()
            
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            //MARK: RESULT
                .responseData {response in
                    
                    let jsonString =  response.data
                    if jsonString == nil {
                        print("COM OEPS")
                    } else {
                        
                        do {
                            let comdata = try JSONDecoder().decode([acme].self, from: jsonString!)
                            self.fetchedcoms = comdata
                        } catch {
                            //handle error
                            print(error)
                            print("💣 CommsFetcher FILE ERROR")
                        }
                    }
                }
        }
    }
}



//MARK:NKGREENDATA
class GetCommDataNK: ObservableObject {
    
    @Published var fetchcommData = [commData]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("NKCommData FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("NKCommData FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([commData].self, from: mydata)
                        self.fetchcommData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 NKCommData FILE ERROR")
                    }
                    
                }
            } else {
                print("NKCommData FILE NOT AVAILABLE")
                
            }
        }
    }
}



class TESTCommsFetcher: ObservableObject {
    
    //    @Published var fetchedcoms = [acme]()
    @Published var fetchcommData = [commData]()
    
    init(){
        load()
    }
    
    func load() {
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let myDefibrillators = "communicators"
        let url_defi = myURL! + myDefibrillators
        let AuthKey = defaults.string(forKey: "DATASTRING")
        //        print("NEXT DATASTRING: ", AuthKey!)
        let authKey = AuthKey!
        
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
                    
                    for (index,subJson):(String, JSON) in json {
                        
                        //                    print("defi:\(index) 2:")
                        
                        
                        if index == "data" {
                            
                            
                            
//                            print("QQ", subJson)
                            
                            
                            //                        self.fetchcommData = try JSONDecoder().decode([commData].self, from: subJson)//= subJson
                            
                            let jsonString =  subJson.string
                            let data = jsonString!.data(using: .utf8)!
                            //                        for (index,subJson):(String, JSON) in jsonString {
                            //                            print("defi:\(index) 2:\(subJson)")
                            //
                            print(data)
                            
                            do {
                                let comdata = try JSONDecoder().decode([commData].self, from: data)
                                self.fetchcommData = comdata
                                
                                print(comdata)
                            } catch {
                                //handle error
                                print(error)
                                print("💣 NKCommData FILE ERROR")
                            }
                            
                        }

                    }
                    
                case .failure(let error):
                    print(error)
                    print("NOOOOOO OLD DEFI DE")
                    
                }
            }
    }
}

//MARK: MessagesFetcher
class MessagesFetcher: ObservableObject {
    @Published var fetchmessages = [Message]()
    
    init(){
        let defaults = UserDefaults.standard
        let activeMap = defaults.string(forKey: "messageload")
        
        if activeMap == "YES" {
            print("YES MESSAGE")
            
            load()
            
        } else {
            print("NO MESSAGE ")
        }
    }
    
    
    func load() {
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        let selectedComm = defaults.string(forKey: "commdetailID")
        
        let selectedcomdefi = defaults.string(forKey: "DefiComm")
        
        var baseUser = ""
        var basePass = ""
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        if baseUser == ""  {
            print("⛔️")
        } else {
            
            let myURL = defaults.string(forKey: "myPortal")
            let deficom = selectedcomdefi ?? ""
            let theonecomm = selectedComm ?? ""
            let theone =  selectedDefi ?? ""
            let comLink = "/messages"
            var newurl = ""
            
            if deficom == "defibrillators/" {
                
                let url = myURL! + deficom + theone + comLink
                newurl = url
                
            } else {
                
                let url = myURL! + deficom + theonecomm + comLink
                newurl = url
            }
            
            let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            
            let base64Credentials = credentialData.base64EncodedString()
            print(newurl)
            
            AF.request(newurl, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            //MARK: RESULT
                .responseData {response in
                    
                    let jsonString =  response.data
                    
                    if jsonString == nil {
                        print("🛑")
                    } else {
                        
                        do {
                            let messagedata = try JSONDecoder().decode([Message].self, from: jsonString!)
                            self.fetchmessages = messagedata
                        } catch {
                            //handle error
                            print(error)
                            print("💣 MessagesFetcher FILE ERROR")
                        }
                    }
                }
        }
    }
}

func getDocumentsDiretory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//MARK: MOVEMENTMAPDATAALL
class GetMovementsAll: ObservableObject {
    @Published var fetchlatlon = [PlaceDefi]()
//    @Published var fetchlatlon = [MoveLatLonAvailable]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("OLD MOVEMENT FILE AVAILABLE")
                
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("OLD MOVEMENT FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.fetchlatlon = selftestdata
                        
//                        let rate = selftestdata.filter { $0.idCode == "6" }
//                        self.fetchlatlon = rate
//                        print(rate)
                        
                        
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MOVEMENT GEOFILE FILE ERROR")
                    }
                }
            } else {
                print("second")
                print("SECOND FILE NOT AVAILABLE")
                
            }
        }
    }
}


//MARK: MOVEMENTMAPDATA
class GetMovements: ObservableObject {
    
    @AppStorage("lastMovementEntry") var lastMovementEntry: String?
    
    @Published var fetchlatlon = [PlaceDefi]()
//    @Published var fetchlatlon = [MoveLatLonAvailable]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("OLD MOVEMENT FILE AVAILABLE")
                
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("OLD MOVEMENT FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.fetchlatlon = selftestdata
                        
                        
                        let howManyDoWeHave = lastMovementEntry
//                        print("SECOND MOVE NOVALUE", howManyDoWeHave)
                        
                        if howManyDoWeHave == nil {
                            
                            self.fetchlatlon = selftestdata
                        } else {
                        
//                            print("SECOND MOVE VALUE", howManyDoWeHave)
                            
                        let rate = selftestdata.filter { $0.idCode == lastMovementEntry }
                        self.fetchlatlon = rate
//                        print(rate)
                        }
                        
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MOVEMENT GEOFILE FILE ERROR")
                    }
                }
            } else {
                
//                UserDefaults.standard.set("NO", forKey: "NoMoveInfo")
                
                print("first")
                print("FIRST FILE NOT AVAILABLE")
            }
        }
    }
}


////MARK:MAPDATA
//class GetMovements: ObservableObject {
//
////    @Published var fetchlatlon = [MoveLatLonAvailable]()
//    @Published var fetchlatlon = [PlaceDefi]()
//
//    init(){
//
//        load()
//    }
//
//    func load() {
//
//        do {
//
//            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
//            if FileManager.default.fileExists(atPath: filename.path) {
//                print("MOVE FILE AVAILABLE")
//
//                let mydata = try! Data(contentsOf: filename)
//
//                if mydata.isEmpty {
//                    print("MOVE FILE AVAILABLE BUT EMPTY")
//                } else {
//
//                    do {
//                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
//                        self.fetchlatlon = selftestdata
//                    } catch {
//                        //handle error
//                        print(error)
//                        print("💣 MOVE GEOFILE FILE ERROR")
//                    }
//                }
//            } else {
//                print("MOVE FILE NOT AVAILABLE")
//            }
//        }
//    }
//}

class GetMessagesDataNK: ObservableObject {
    
    @Published var fetchMessagesDataNK = [DataNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("MESSAGES FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("MESSAGES FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let messageDataNK = try JSONDecoder().decode([DataNK].self, from: mydata)
                        self.fetchMessagesDataNK = messageDataNK
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MESSAGES FILE ERROR")
                    }
                    
                }
            } else {
                print("MESSAGES FILE NOT AVAILABLE")
                
            }
        }
    }
}

class GetMessagesDataNKOverview: ObservableObject {
    
    @Published var fetchMessagesDataNK = [DataNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("OVERMESSAGES FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("OVERMESSAGES FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let messageDataNK = try JSONDecoder().decode([DataNK].self, from: mydata)
                        self.fetchMessagesDataNK = messageDataNK
                    } catch {
                        //handle error
                        print(error)
                        print("💣 OVERMESSAGES FILE ERROR")
                    }
                    
                }
            } else {
                print("OVERMESSAGES FILE NOT AVAILABLE")
                
            }
        }
    }
}




class GetMessagesDataNKComm: ObservableObject {
    
    @Published var fetchMessagesDataNKComm = [DataNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("MESSAGES DATA FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("MESSAGES DATA FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let messageDataNK = try JSONDecoder().decode([DataNK].self, from: mydata)
                        self.fetchMessagesDataNKComm = messageDataNK
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MESSAGES DATA FILE ERROR")
                    }
                    
                }
            } else {
                print("MESSAGES DATA FILE NOT AVAILABLE")
                
            }
        }
    }
}


class GetLatLon: ObservableObject {
    
    @Published var fetchlatlon = [LatLonAvailable]()

    
    init(){
        
        load()
    }
    
    func load() {
        
//            let defaults = UserDefaults.standard
//            let userCenterLat = defaults.string(forKey: "UserCenterLocationLat")
//            let userCenterLat2 = defaults.double(forKey: "UserCenterLocationLat")
//            let userCenterLon = defaults.string(forKey: "UserCenterLocationLon")
//            let userCenterLon2 = defaults.double(forKey: "UserCenterLocationLon")
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("latlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("GEOFILE FILE AVAILABLE")
                
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("GEOFILE FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        
                        
//                        print("FILTERGEO", userCenterLat ?? 0.000)
//                        print("FILTERGEO1", userCenterLon ?? 0.000)
  
                        //MARK: ORIGINAL
                        let selftestdata = try JSONDecoder().decode([LatLonAvailable].self, from: mydata)
                        self.fetchlatlon = selftestdata

                        //MARK: NEW START
//                        let userCenterLatTop =  userCenterLat2 + 3.000
//                        let userCenterLatBottom =  userCenterLat2 - 3.000
//
//                        let userCenterLonLeft =  userCenterLon2 - 3.000
//                        let userCenterLonRight = userCenterLon2 + 3.000
//
//
//                        print("userCenterLatTop", userCenterLatTop)
//                        print("userCenterLatBottom", userCenterLatBottom)
//
//                        print("userCenterLonLeft", userCenterLonLeft)
//                        print("userCenterLonRight", userCenterLonRight)
//
//
//                        let rate = selftestdata.filter { $0.latitude > userCenterLatBottom  && $0.latitude < userCenterLatTop}
//                        let rate2 = rate.filter { $0.longitude > userCenterLonLeft  && $0.longitude < userCenterLonRight}
//                        print("FILTERGEO2", rate2)
//
//
//
//                        print("FILTERGEO2 COUNT",rate2.count)
//
//                        if rate2.count >= 100 {
//                            let sortedData = rate2.sorted { $0.latitude > $1.latitude }
//                            print("FILTERGEO2 SORT",sortedData)
//
//
//
//                            let userCenterLatTop1 =  userCenterLat2 + 1.500
//                            let userCenterLatBottom1 =  userCenterLat2 - 1.500
//
//                            let userCenterLonLeft1 =  userCenterLon2 - 1.500
//                            let userCenterLonRight1 = userCenterLon2 + 1.500
//
//
//                            let sortedData1 = selftestdata.filter { $0.latitude > userCenterLatBottom1  && $0.latitude < userCenterLatTop1}
//                            let sortedData2 = sortedData1.filter { $0.longitude > userCenterLonLeft1  && $0.longitude < userCenterLonRight1}
////                            print("FILTERGEO2", sortedData2)
//                            print("FILTERGEO2 COUNT",sortedData2.count)
//                            //14.839473
//                            //FILTERGEO 13.7
//                            //FILTERGEO1 100.5
//
////                            self.fetchlatlon = sortedData2
//                        }
//
//
////                        self.fetchlatlon = rate2
//
//
//
//
//
                        
                        
                        //MARK: NEW END
                        
                        
                    } catch {
                        //handle error
                        print(error)
                        print("💣 GEOFILE FILE ERROR")
                    }
                }
            } else {
                print("GEOFILE FILE NOT AVAILABLE")
            }
        }
    }
}

//MARK:SERVICEDATA
class GetServiceData: ObservableObject {
    
    @Published var fetchserviceData = [DataServiceElement]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("service.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("SERVICE FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("SERVICE FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataServiceElement].self, from: mydata)
                        self.fetchserviceData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 SERVICE FILE ERROR")
                    }
                    
                }
            } else {
                print("SERVICE FILE NOT AVAILABLE")
                
            }
        }
    }
}

//MARK:NKServiceDATA
class GetServiceDataNK: ObservableObject {
    
    @Published var fetchserviceNKData = [DataServiceNKElement]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("SERVICE FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("SERVICE FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataServiceNKElement].self, from: mydata)
                        self.fetchserviceNKData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 SERVICE FILE ERROR")
                    }
                    
                }
            } else {
                print("SERVICE FILE NOT AVAILABLE")
                
            }
        }
    }
}


//MARK:NKGREENDATA
class GetGreenDataNK: ObservableObject {
    
    @Published var fetchgreenData = [DataGreenElementNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKgreenData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("NKGREEN FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("NKGREEN FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataGreenElementNK].self, from: mydata)
                        self.fetchgreenData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 NKGREEN FILE ERROR")
                    }
                    
                }
            } else {
                print("NKGREEN FILE NOT AVAILABLE")
                
            }
        }
    }
}



//MARK:GREENDATA
class GetGreenData: ObservableObject {
    
    @Published var fetchgreenData = [DataGreenElement]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("greenData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("GREEN FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("GREEN FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataGreenElement].self, from: mydata)
                        self.fetchgreenData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 GREEN FILE ERROR")
                    }
                    
                }
            } else {
                print("GREEN FILE NOT AVAILABLE")
                
            }
        }
    }
}

//MARK:YELLOWDATA
class GetYellowDataNK: ObservableObject {
    
    @Published var fetchyellowData = [DataYellowElementNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKyellowData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("NKYELLOW FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("NKYELLOW FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataYellowElementNK].self, from: mydata)
                        self.fetchyellowData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 NKYELLOW FILE ERROR")
                    }
                    
                }
            } else {
                print("NKYELLOW FILE NOT AVAILABLE")
                
            }
        }
    }
}


//MARK:YELLOWDATA
class GetYellowData: ObservableObject {
    
    @Published var fetchyellowData = [DataYellowElement]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("yellowData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("YELLOW FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("YELLOW FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataYellowElement].self, from: mydata)
                        self.fetchyellowData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 YELLOW FILE ERROR")
                    }
                    
                }
            } else {
                print("YELLOW FILE NOT AVAILABLE")
                
            }
        }
    }
}



////MARK:YELLOWDATA
//class GetYellowDataNK: ObservableObject {
//
//    @Published var fetchyellowData = [DataYellowElement]()
//
//    init(){
//
//        load()
//    }
//
//    func load() {
//
//        do {
//
//            let filename = getDocumentsDiretory().appendingPathComponent("yellowData.json")
//            if FileManager.default.fileExists(atPath: filename.path) {
//                print("YELLOW FILE AVAILABLE")
//                let mydata = try! Data(contentsOf: filename)
//
//                if mydata.isEmpty {
//                    print("YELLOW FILE AVAILABLE BUT EMPTY")
//                } else {
//
//                    do {
//                        let selftestdata = try JSONDecoder().decode([DataYellowElement].self, from: mydata)
//                        self.fetchyellowData = selftestdata
//                    } catch {
//                        //handle error
//                        print(error)
//                        print("💣 YELLOW FILE ERROR")
//                    }
//
//                }
//            } else {
//                print("YELLOW FILE NOT AVAILABLE")
//
//            }
//        }
//    }
//}


//MARK:NKREDDATA
class GetRedDataNK: ObservableObject {
    
    @Published var fetchredData = [DataRedElementNK]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("NKredData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("NKRED FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("NKRED FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataRedElementNK].self, from: mydata)
                        self.fetchredData = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 NKRED FILE ERROR")
                    }
                    
                }
            } else {
                print("NKRED FILE NOT AVAILABLE")
                
            }
        }
    }
}



//MARK:REDDATA
class GetRedData: ObservableObject {
    let defaults = UserDefaults.standard
    private var showingAlert = false
    @Published var fetchredData = [DataRedElement]()
    
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("redData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("RED FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("RED FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([DataRedElement].self, from: mydata)
                        self.fetchredData = selftestdata
                        //all fine with jsonData here
                    } catch {
                        //handle error
                        print(error)
                        print("💣 RED FILE ERROR")
                        defaults.set("NO", forKey: "validJsonData")
                        
                    }
                    
                }
                
            } else {
                print("RED FILE NOT AVAILABLE")
            }
        }
    }
}


//MARK: SelfTestFetcher
class SelftestFetcher: ObservableObject {
    @Published var fetchselftests = [SelfTest]()
    
    init(){
        let defaults = UserDefaults.standard
        let activeMap = defaults.string(forKey: "selftestload")
        
        if activeMap == "YES" {
            print("YES SELFTEST")
            
            load()
            
        } else {
            
            print("NO SELFTEST ")
            
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "DataUIDUser")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        
        var baseUser = ""
        var basePass = ""
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        if baseUser == ""  {
            print("⛔️")
        } else {
            
            let myURL = defaults.string(forKey: "myPortal")
            let defies = "defibrillators/"
            let theone =  selectedDefi ?? ""
            let comLink = "/selfTests"
            let url = myURL! + defies + theone + comLink
            
            
            let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            
            let base64Credentials = credentialData.base64EncodedString()
            
            print("🐋:\(url)")
            
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            //MARK: RESULT
                .responseData {response in
                    
                    let jsonString =  response.data
                    if jsonString == nil {
                        print("🚫")
                    } else {
                        
                        do {
                            let selftestdata = try JSONDecoder().decode([SelfTest].self, from: jsonString!)
                            self.fetchselftests = selftestdata
                            
                        } catch {
                            //handle error
                            print(error)
                            print("💣 SelftestFetcher FILE ERROR")
                        }
                        
                    }
                }
        }
    }
}


//MARK: COMM SIM STATUS
func getCommSimStatus() {
    
    let defaults = UserDefaults.standard
    var baseUser = ""
    var basePass = ""
    
    let email = defaults.string(forKey: "DataUIDUser")
    let password = defaults.string(forKey: "DataPWDUser")
    let selectedSim = defaults.string(forKey: "SIMCardid")
    
    
    baseUser = email!
    basePass = password!
    
    let myURL = defaults.string(forKey: "myPortal")
    let sim = "simcards/"
    let theone =  selectedSim ?? ""
    let status = "/status"
    let url = myURL! + sim + theone + status
    
    print("simcards/status", url)
    let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
    
    let base64Credentials = credentialData.base64EncodedString()
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "Authorization": "Basic \(base64Credentials)",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
               
    ).responseString { response in
        debugPrint("Response: \(response)")
        print((response))
        
        let mystring = ("\(response)")
        
        UserDefaults.standard.set(mystring, forKey: "SIMCardActive")
        
    }
}

class A: ObservableObject {
    
    @Published var showAlert = false
    
    func buttonTapped() {
        //handle request and then set to true to show the alert
        self.showAlert = true
    }
    
}


//TODO: What do we do with movements

func MovementData(){
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone + "/movements"
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
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
                
                
                if let username = json["data"]["name"].string {
                    print(username)
                    
                    let owner = json["data"]["id"]
                    print("@id:" ,owner)
                    let description = json["data"]["userDescription"]
                    print("Description:", description)
                    let emailUser = json["data"]["email"]
                    print("EMail:",emailUser)
                    let telephoneUser = json["data"]["telephone"]
                    print("Telephone:",telephoneUser)
                    let mobilePhoneUser = json["data"]["mobilephone"]
                    print("mobilePhone:",mobilePhoneUser)
                    let telegramUser = json["data"]["telegram"]
                    print("telegramUser:",telegramUser)
                    let homepageUser = json["data"]["homepage"]
                    print("homepageUser:",homepageUser)
                    
                    
                    UserDefaults.standard.set(json["data"]["name"].stringValue, forKey: "userOwner")
                    UserDefaults.standard.set(json["data"]["id"].stringValue, forKey: "userID")
                    UserDefaults.standard.set(json["data"]["userDescription"].string, forKey: "userDescription")
                    UserDefaults.standard.set(json["data"]["email"].stringValue, forKey: "userEmail")
                    UserDefaults.standard.set(json["data"]["telephone"].stringValue, forKey: "userTelephone")
                    UserDefaults.standard.set(json["data"]["mobilephone"].stringValue, forKey: "usermobilePhone")
                    UserDefaults.standard.set(json["data"]["telegram"].stringValue, forKey: "usertelegram")
                    UserDefaults.standard.set(json["data"]["homepage"].stringValue, forKey: "userhomepage")
                }
                
            case .failure(let error):
                print(error)
                print("NOOOOOO NEW USER")
            }
        }
}

