//
//  selfTestJSONFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK:REDDATA
class GetSelfTestData: ObservableObject {
    let defaults = UserDefaults.standard
    private var showingAlert = false
    //    @Published var fetchredData = [DataRedElement]()
    @Published var fetchSelfTestData = [selfTestDataModel]()
    init(){
        
        load()
    }
    
    func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("SELFTEST FILE AVAILABLE")
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("SELFTEST FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([selfTestDataModel].self, from: mydata)
                        self.fetchSelfTestData = selftestdata
                        //all fine with jsonData here
                    } catch {
                        //handle error
                        print(error)
                        print("💣 SELFTEST FILE ERROR")
                        defaults.set("NO", forKey: "validJsonData")
                        
                    }
                    
                }
                
            } else {
                print("RED FILE NOT AVAILABLE")
            }
        }
    }
}




func DefiGetsingleDataOverView() {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    let defaults = UserDefaults.standard
    
    //    let backend = defaults.string(forKey: "Backend")
    //    let overview = defaults.string(forKey: "Overview")
    
    
    //    var selfTestCount: Int = 0
//    var mymin0: Int = 0
//    var timetest: String  = ""
//
//    var selftestData: String = ""
//    var selftestDataInfo : String = ""
    //
    //    if backend == "NEW" {
    
//    var baseUser = ""
    //        print("Backend: ", backend!)
    
    //        let email = defaults.string(forKey: "DataUIDUser")
    
    
//    baseUser = email!
//    print(baseUser)
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone
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
            
            //                    print(json)
            
            for(index,subJson):(String, JSON) in json {
                print("defi:\(index) 2:\(subJson)")
                
                if index == "data" {
//                print("FIRST GROUP BLOCK Before:\(mymin0)")
                
                    
                    let selftestidStart = subJson["selfTests"].array
                    
                    if selftestidStart == nil || selftestidStart!.count == 0 {
                        print("There are no objects")
                    
                    
                    
//                    if selftestidStart == 0 {
                        UserDefaults.standard.set("N/A", forKey: "defridetailhasBatteryErrorOverview")
                        UserDefaults.standard.set("N/A", forKey: "defridetailSelfTesthasWarningsOverview")
                        UserDefaults.standard.set("N/A", forKey: "defridetailSelfTesthasRedErrorsOverview")

                        UserDefaults.standard.set("No Additional Info", forKey: "message_selfTestResult")

                    } else {
                    
                    
//                let selftestid_00 = subJson["selfTests"].array![0]["uniqeSelfTestId"].string

                UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasBatteryError"].bool ?? false)), forKey: "defridetailhasBatteryErrorOverview")
                
//                let hasWarningsString = String((subJson["selfTests"].array?[0]["hasWarnings"].bool)!)
                UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasWarnings"].bool ?? false)), forKey: "defridetailSelfTesthasWarningsOverview")
//                print("defridetailSelfTesthasWarningsOverview",hasWarningsString ?? "N/A")
                
//                let hasRedErrorsString = String((subJson["selfTests"].array?[0]["hasRedErrors"].bool)!)
                UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasRedErrors"].bool ?? false)), forKey: "defridetailSelfTesthasRedErrorsOverview")
                
                
                let selfTestMessage = subJson["selfTests"].array?[0]["selfTestMessage"].string
                //                                    print("uniqeSelfTestId",selfTestMessage ?? "N/A")
                let selfTestMessage_00 = String(describing: selfTestMessage ?? "No Additional Info")
                UserDefaults.standard.set(selfTestMessage_00, forKey: "message_selfTestResult")
                }
                }
                

                
                
            }
        case .failure(let error):
            print(error)
            print("NOOOOOO NEW DEFI SELFTEST")
        }
    }
}
