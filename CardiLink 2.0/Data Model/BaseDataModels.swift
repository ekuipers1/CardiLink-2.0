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


func getUserData(){
    
    var baseUser = ""
    let defaults = UserDefaults.standard
    let email = defaults.string(forKey: "username")
    baseUser = email ?? ""
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myUser = "users/byemail/"
    let url = myURL! + myUser + baseUser
    
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
                let owner = json["data"]["id"]
                let description = json["data"]["userDescription"]
                let emailUser = json["data"]["email"]
                let telephoneUser = json["data"]["telephone"]
                let mobilePhoneUser = json["data"]["mobilephone"]
                let telegramUser = json["data"]["telegram"]
                let homepageUser = json["data"]["homepage"]
                
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
        }
    }
    
}


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
        .responseData {response in
            
            let jsonString =  response.data
            if jsonString == nil {
            } else {
                do {
                    let comdata = try JSONDecoder().decode([DefiData].self, from: jsonString!)
                    self.defiDataTest = comdata
                } catch {
                    print(error)
                }
            }
        }
    }
}
class ServiceTicketFetcherComms: ObservableObject {
    
    @Published var fetchservicetickets = [SeriveTicket]()
    
    init(){
        
        let defaults = UserDefaults.standard
        let myBackend = defaults.string(forKey: "Backend")
        if myBackend == "NEW" {
        } else {
            let defaults = UserDefaults.standard
            let activeMap = defaults.string(forKey: "callServiceTickets")
            if activeMap == "YES" {
                load()
            } else {
            }
        }
        
        func load() {
            
            let defaults = UserDefaults.standard
            var baseUser = ""
            var basePass = ""
            let email = defaults.string(forKey: "username")
            let password = defaults.string(forKey: "DataPWDUser")
            let selectedDefi = defaults.string(forKey: "commdetailID")
            
            baseUser = email ?? ""
            basePass = password ?? ""
            
            let myURL = defaults.string(forKey: "myPortal") ?? ".."
            let comLink = "communicators/"
            let theone =  selectedDefi ?? ""
            let tickets = "/serviceTickets"
            let url = myURL +  comLink + theone + tickets
            
            let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let base64Credentials = credentialData.base64EncodedString()
            
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            
            .responseData {response in
                let jsonString =  response.data
                if jsonString == nil {
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
                        print(error)
                    }
                    
                }
            }
        }
    }
}
class ServiceTicketFetcher: ObservableObject {
    
    @Published var fetchservicetickets = [SeriveTicket]()
    
    init(){
        let defaults = UserDefaults.standard
        let activeMap = defaults.string(forKey: "callServiceTickets")
        if activeMap == "YES" {
            load()
        } else {
        }
    }
    
    
    func load() {
        let defaults = UserDefaults.standard
        var baseUser = ""
        var basePass = ""
        
        let email = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        let myURL = defaults.string(forKey: "myPortal") ?? ".."
        let comLink = "defibrillators/"
        let theone =  selectedDefi ?? ""
        let tickets = "/serviceTickets"
        let url = myURL +  comLink + theone + tickets
        
        let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData {response in
            
            let jsonString =  response.data
            if jsonString == nil {
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
                    print(error)
                }
            }
        }
    }
}
class CommsFetcher: ObservableObject {
    
    @Published var fetchedcoms = [acme]()
    
    init(){
        load()
    }
    
    func load() {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "DataPWDUser")
        
        var baseUser = ""
        var basePass = ""
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        if baseUser == ""  {
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
            .responseData {response in
                
                let jsonString =  response.data
                if jsonString == nil {
                } else {
                    do {
                        let comdata = try JSONDecoder().decode([acme].self, from: jsonString!)
                        self.fetchedcoms = comdata
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
class GetCommDataNK: ObservableObject {
    
    @Published var fetchcommData = [commData]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([commData].self, from: mydata)
                        self.fetchcommData = selftestdata
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
        }
    }
}
class MessagesFetcher: ObservableObject {
    @Published var fetchmessages = [Message]()
    
    init(){
        let defaults = UserDefaults.standard
        let activeMap = defaults.string(forKey: "messageload")
        if activeMap == "YES" {
            load()
        } else {
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "DataPWDUser")
        let selectedDefi = defaults.string(forKey: "SelectedDefi")
        let selectedComm = defaults.string(forKey: "commdetailID")
        
        let selectedcomdefi = defaults.string(forKey: "DefiComm")
        
        var baseUser = ""
        var basePass = ""
        
        baseUser = email ?? ""
        basePass = password ?? ""
        
        if baseUser == ""  {
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
            AF.request(newurl, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                "Authorization": "Basic \(base64Credentials)",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Connection" : "keep-alive"
            ]
            )
            .responseData {response in
                let jsonString =  response.data
                if jsonString == nil {
                } else {
                    do {
                        let messagedata = try JSONDecoder().decode([Message].self, from: jsonString!)
                        self.fetchmessages = messagedata
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
class GetMovementsAll: ObservableObject {
    @Published var fetchlatlon = [PlaceDefi]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.fetchlatlon = selftestdata
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
        }
    }
}
class GetMovements: ObservableObject {
    
    @AppStorage("lastMovementEntry") var lastMovementEntry: String?
    @Published var fetchlatlon = [PlaceDefi]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.fetchlatlon = selftestdata
                        let howManyDoWeHave = lastMovementEntry
                        if howManyDoWeHave == nil {
                            self.fetchlatlon = selftestdata
                        } else {
                            let rate = selftestdata.filter { $0.idCode == lastMovementEntry }
                            self.fetchlatlon = rate
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
        }
    }
}
class GetMessagesDataNK: ObservableObject {
    
    @Published var fetchMessagesDataNK = [MessageData]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let messageDataNK = try JSONDecoder().decode([MessageData].self, from: mydata)
                        self.fetchMessagesDataNK = messageDataNK
                    } catch {
                        print(error)
                    }
                }
            } else {
                getNKMessagesData()
            }
        }
    }
}
class GetMessagesDataNKOverview: ObservableObject {
    
    @Published var fetchMessagesDataNK = [MessageData]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let messageDataNK = try JSONDecoder().decode([MessageData].self, from: mydata)
                        self.fetchMessagesDataNK = messageDataNK
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
        }
    }
}
class GetMessagesDataNKComm: ObservableObject {
    
    @Published var fetchMessagesDataNKComm = [MessageData]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let messageDataNK = try JSONDecoder().decode([MessageData].self, from: mydata)
                        self.fetchMessagesDataNKComm = messageDataNK
                    } catch {
                        print(error)
                    }
                }
            } else {
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
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("latlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([LatLonAvailable].self, from: mydata)
                        self.fetchlatlon = selftestdata
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
        }
    }
}
class GetServiceData: ObservableObject {
    
    @Published var fetchserviceData = [DataServiceElement]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("service.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([DataServiceElement].self, from: mydata)
                        self.fetchserviceData = selftestdata
                    } catch {
                        print(error)
                    }
                    
                }
            } else {
            }
        }
    }
}
class GetServiceDataNK: ObservableObject {
    
    @Published var fetchserviceNKData = [DataServiceNKElement]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([DataServiceNKElement].self, from: mydata)
                        self.fetchserviceNKData = selftestdata
                    } catch {
                        print(error)
                    }
                    
                }
            } else {
            }
        }
    }
}
class GetGrayNonMonitoredData: ObservableObject {
    
    @Published var fetchgrayData = [DataGrayElementNK]()
    
    init(){
        load()
    }
    
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("NKgrayNonMonitoredData.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([DataGrayElementNK].self, from: mydata)
                        self.fetchgrayData = selftestdata
                    } catch {
                        print(error)
                    }
                    
                }
                
            } else {
            }
        }
    }
}
func getCommSimStatus() {
    
    let defaults = UserDefaults.standard
    var baseUser = ""
    var basePass = ""
    
    let password = defaults.string(forKey: "DataPWDUser")
    let selectedSim = defaults.string(forKey: "SIMCardid")
    
    let email = defaults.string(forKey: "username")
    baseUser = email!
    basePass = password!
    
    let myURL = defaults.string(forKey: "myPortal")
    let sim = "simcards/"
    let theone =  selectedSim ?? ""
    let status = "/status"
    let url = myURL! + sim + theone + status
    
    let credentialData = "\(baseUser):\(basePass)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
    let base64Credentials = credentialData.base64EncodedString()
    
    AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "Authorization": "Basic \(base64Credentials)",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
               
    ).responseString { response in
        let mystring = ("\(response)")
        UserDefaults.standard.set(mystring, forKey: "SIMCardActive")
        
    }
}
class A: ObservableObject {
    
    @Published var showAlert = false
    
    func buttonTapped() {
        self.showAlert = true
    }
    
}
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
                
                let owner = json["data"]["id"]
                let description = json["data"]["userDescription"]
                let emailUser = json["data"]["email"]
                let telephoneUser = json["data"]["telephone"]
                let mobilePhoneUser = json["data"]["mobilephone"]
                let telegramUser = json["data"]["telegram"]
                let homepageUser = json["data"]["homepage"]
                
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
        }
    }
}
func NotificationToken() {
    let defaults = UserDefaults.standard
    
    guard let myURL = defaults.string(forKey: "myPortal"),
          let authKey = defaults.string(forKey: "DATASTRING"),
          let phoneNotificationToken = defaults.string(forKey: "NotificationToken"),
          let phoneidfaToken = defaults.string(forKey: "idfa") else {
        return
    }
    
    let endit = "notification/registerToken"
    let finalURL = myURL + endit
    var request = URLRequest(url: URL(string: finalURL)!, timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String: Any] = [
        "DeviceToken": phoneNotificationToken,
        "DeviceIdentification": phoneidfaToken
    ]
    
    guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        print("Error: Unable to serialize JSON data.")
        return
    }
    
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
func getDocumentsDiretory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
