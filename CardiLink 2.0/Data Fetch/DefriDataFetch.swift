//
//  DefriDataFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import Foundation
import Combine
import Alamofire
import SwiftyJSON


class DefriDataFetch: ObservableObject, Identifiable {
    @Published var token:UUID?
    @Published var getit:String?
    @Published var getit2:String?
    @Published var getit3:String?
    @Published var DefbaseUser:String?
    
    let defaults = UserDefaults.standard
    func login(email: String, password: String)  -> Bool {
        self.token = UUID()
        
        defaults.set(email, forKey: "DataUIDUser")
        defaults.set(password, forKey: "DataPWDUser")
        
        let myURL = defaults.string(forKey: "myPortal")
        let comLink = "defibrillators?includeWithAdminStatus=monitored"
        let url = myURL! + comLink
        let credentialData = "\(email):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData(completionHandler: { [self] (data)  in
            
            let json = try! JSON(data: data.data!)
            let countall = String(json.count)
            getit = countall
            DefbaseUser = email
            
            for (index,subJson):(String, JSON) in json {
            }
            
        })
        return  true
    }
}

