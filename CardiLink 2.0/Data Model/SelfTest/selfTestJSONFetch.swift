//
//  selfTestJSONFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetSelfTestData: ObservableObject {
    let defaults = UserDefaults.standard
    private var showingAlert = false
    @Published var fetchSelfTestData = [selfTestDataModel]()
    init(){
        
        load()
    }
    func load() {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([selfTestDataModel].self, from: mydata)
                        self.fetchSelfTestData = selftestdata
                    } catch {
                        print(error)
                        defaults.set("NO", forKey: "validJsonData")
                        
                    }
                }
                
            } else {
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
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let selectedDefi = defaults.string(forKey: "SelectedDefi")
    let myDefibrillators = "defibrillators/"
    let url_defi = myURL! + myDefibrillators
    let theone =  selectedDefi ?? ""
    let url = url_defi + theone
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
            for(index,subJson):(String, JSON) in json {
                if index == "data" {
                    let selftestidStart = subJson["selfTests"].array
                    if selftestidStart == nil || selftestidStart!.count == 0 {
                        UserDefaults.standard.set("N/A", forKey: "defridetailhasBatteryErrorOverview")
                        UserDefaults.standard.set("N/A", forKey: "defridetailSelfTesthasWarningsOverview")
                        UserDefaults.standard.set("N/A", forKey: "defridetailSelfTesthasRedErrorsOverview")
                        UserDefaults.standard.set("No Additional Info", forKey: "message_selfTestResult")
                    } else {
                        UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasBatteryError"].bool ?? false)), forKey: "defridetailhasBatteryErrorOverview")
                        UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasWarnings"].bool ?? false)), forKey: "defridetailSelfTesthasWarningsOverview")
                        UserDefaults.standard.set(String((subJson["selfTests"].array?[0]["hasRedErrors"].bool ?? false)), forKey: "defridetailSelfTesthasRedErrorsOverview")
                        let selfTestMessage = subJson["selfTests"].array?[0]["selfTestMessage"].string
                        let selfTestMessage_00 = String(describing: selfTestMessage ?? "No Additional Info")
                        UserDefaults.standard.set(selfTestMessage_00, forKey: "message_selfTestResult")
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
    }
}
