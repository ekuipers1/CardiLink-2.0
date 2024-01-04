//
//  SelfTestsData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.03.21.
//
//   let selfTests = try? newJSONDecoder().decode(SelfTests.self, from: jsonData)

import Foundation

struct SelfTest: Codable, Identifiable {
    var id: String?
    var context: String?
    var timestamp: String?
    var defibrillatorID: String?
    var isBatteryError: Bool?
    var isUncriticalError: Bool?
    var isRedError: Bool?
    var cryptoHash: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case context = "@context"
        case timestamp
        case defibrillatorID = "defibrillatorId"
        case isBatteryError, isUncriticalError, isRedError, cryptoHash
    }
}

typealias SelfTests = [SelfTest]


//MARK:GetSelfTestDataNK
class GetSelfTestDataNK: ObservableObject {
    
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



