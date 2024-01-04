//
//  SearchFetch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.10.23.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON


class SearchViewModel: ObservableObject {
    
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var dashboardCounts: [Int: Int] = [:]
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    func fetchDataFilter(searchText: String, filter: String) {
        
        self.isLoading = true
        defibrillators.removeAll()
        
        let fromDateElec = UserDefaults.standard.string(forKey: "fromDateElecKey") ?? ""
        let toDateElec = UserDefaults.standard.string(forKey: "toDateElecKey") ?? ""
        let fromDateBat = UserDefaults.standard.string(forKey: "fromDateBatKey") ?? ""
        let toDateBat = UserDefaults.standard.string(forKey: "toDateBatKey") ?? ""
        let leftAEDTextValueKey = UserDefaults.standard.string(forKey: "leftAEDTextValueKey") ?? ""
        let rightAEDTextValueKey = UserDefaults.standard.string(forKey: "rightAEDTextValueKey") ?? ""
        let ownerName = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""
        let postalCode = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
        let cityName = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
        let countryName = UserDefaults.standard.string(forKey: "countryNameKey") ?? ""
        var url_defi = myURL + "defibrillators/?searchtext=" + searchText + "&IncludeAddressInformation=true&PageSize=600"
        if !leftAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + leftAEDTextValueKey
        }
        if !rightAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + rightAEDTextValueKey
        }
        if !fromDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + fromDateElec
        }
        if !toDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + toDateElec
        }
        if !fromDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + fromDateBat
        }
        if !toDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + toDateBat
        }
        if !postalCode.isEmpty {
            url_defi += "&PostalCode=" + postalCode
        }
        if !cityName.isEmpty {
            url_defi += "&City=" + cityName
        }
        if !countryName.isEmpty {
            url_defi += "&Country=" + countryName
        }
        if !ownerName.isEmpty {
            url_defi += "&Owner=" + ownerName
        }
        let stringurlfixed = url_defi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(stringurlfixed!, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .responseJSON { response in
            self.isLoading = false
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dataArray = json["data"].array {
                    self.defibrillators = dataArray.map { SearchDefibrillator(json: $0) }
                    self.calculateDashboardCounts(data: self.defibrillators)  // Call
                    self.saveCountsToUserDefaults()
                } else {
                    self.error = "Data format is incorrect."
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
    
    func calculateDashboardCounts(data: [SearchDefibrillator]) {
        var counts: [Int: Int] = [:]
        for item in data {
            counts[item.dashboardState, default: 0] += 1
        }
        self.dashboardCounts = counts
    }
    
    func saveCountsToUserDefaults() {
        let countsArray = [
            dashboardCounts[0] ?? 0,
            (dashboardCounts[1] ?? 0) + (dashboardCounts[3] ?? 0),
            (dashboardCounts[2] ?? 0) + (dashboardCounts[4] ?? 0),
            dashboardCounts[6] ?? 0
        ]
        UserDefaults.standard.setValue(countsArray, forKey: "dashboardCounts")
    }
    
}

class SearchViewModelColorRed: ObservableObject {
    
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    func fetchDataFilter(searchText: String, filter: String) {
        
        self.isLoading = true
        defibrillators.removeAll()
        
        let fromDateElec = UserDefaults.standard.string(forKey: "fromDateElecKey") ?? ""
        let toDateElec = UserDefaults.standard.string(forKey: "toDateElecKey") ?? ""
        let fromDateBat = UserDefaults.standard.string(forKey: "fromDateBatKey") ?? ""
        let toDateBat = UserDefaults.standard.string(forKey: "toDateBatKey") ?? ""
        let leftAEDTextValueKey = UserDefaults.standard.string(forKey: "leftAEDTextValueKey") ?? ""
        let rightAEDTextValueKey = UserDefaults.standard.string(forKey: "rightAEDTextValueKey") ?? ""
        let ownerName = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""
        let postalCode = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
        let cityName = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
        let countryName = UserDefaults.standard.string(forKey: "countryNameKey") ?? ""
        var url_defi = myURL + "defibrillators/?searchtext=" + searchText + "&IncludeAddressInformation=true&DashboardColorGroup=0&PageSize=600"
        if !leftAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + leftAEDTextValueKey
        }
        if !rightAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + rightAEDTextValueKey
        }
        if !fromDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + fromDateElec
        }
        if !toDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + toDateElec
        }
        if !fromDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + fromDateBat
        }
        if !toDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + toDateBat
        }
        if !postalCode.isEmpty {
            url_defi += "&PostalCode=" + postalCode
        }
        if !cityName.isEmpty {
            url_defi += "&City=" + cityName
        }
        if !countryName.isEmpty {
            url_defi += "&Country=" + countryName
        }
        if !ownerName.isEmpty {
            url_defi += "&Owner=" + ownerName
        }
        let stringurlfixed = url_defi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(stringurlfixed!, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .responseJSON { response in
            self.isLoading = false
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dataArray = json["data"].array {
                    self.defibrillators = dataArray.map { SearchDefibrillator(json: $0) }
                } else {
                    self.error = "Data format is incorrect."
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}

class SearchViewModelColorYellow: ObservableObject {
    
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    func fetchDataFilter(searchText: String, filter: String) {
        self.isLoading = true
        defibrillators.removeAll()
        let fromDateElec = UserDefaults.standard.string(forKey: "fromDateElecKey") ?? ""
        let toDateElec = UserDefaults.standard.string(forKey: "toDateElecKey") ?? ""
        let fromDateBat = UserDefaults.standard.string(forKey: "fromDateBatKey") ?? ""
        let toDateBat = UserDefaults.standard.string(forKey: "toDateBatKey") ?? ""
        let leftAEDTextValueKey = UserDefaults.standard.string(forKey: "leftAEDTextValueKey") ?? ""
        let rightAEDTextValueKey = UserDefaults.standard.string(forKey: "rightAEDTextValueKey") ?? ""
        let ownerName = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""
        let postalCode = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
        let cityName = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
        let countryName = UserDefaults.standard.string(forKey: "countryNameKey") ?? ""
        var url_defi = myURL + "defibrillators/?searchtext=" + searchText + "&IncludeAddressInformation=true&DashboardColorGroup=2&PageSize=600"
        if !leftAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + leftAEDTextValueKey
        }
        if !rightAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + rightAEDTextValueKey
        }
        if !fromDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + fromDateElec
        }
        if !toDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + toDateElec
        }
        if !fromDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + fromDateBat
        }
        if !toDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + toDateBat
        }
        if !postalCode.isEmpty {
            url_defi += "&PostalCode=" + postalCode
        }
        if !cityName.isEmpty {
            url_defi += "&City=" + cityName
        }
        if !countryName.isEmpty {
            url_defi += "&Country=" + countryName
        }
        if !ownerName.isEmpty {
            url_defi += "&Owner=" + ownerName
        }
        let stringurlfixed = url_defi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(stringurlfixed!, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .responseJSON { response in
            self.isLoading = false
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dataArray = json["data"].array {
                    self.defibrillators = dataArray.map { SearchDefibrillator(json: $0) }
                } else {
                    self.error = "Data format is incorrect."
                }
                
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}

class SearchViewModelColorGreen: ObservableObject {
    
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    func fetchDataFilter(searchText: String, filter: String) {
        self.isLoading = true
        defibrillators.removeAll()
        
        let fromDateElec = UserDefaults.standard.string(forKey: "fromDateElecKey") ?? ""
        let toDateElec = UserDefaults.standard.string(forKey: "toDateElecKey") ?? ""
        let fromDateBat = UserDefaults.standard.string(forKey: "fromDateBatKey") ?? ""
        let toDateBat = UserDefaults.standard.string(forKey: "toDateBatKey") ?? ""
        let leftAEDTextValueKey = UserDefaults.standard.string(forKey: "leftAEDTextValueKey") ?? ""
        let rightAEDTextValueKey = UserDefaults.standard.string(forKey: "rightAEDTextValueKey") ?? ""
        let ownerName = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""
        let postalCode = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
        let cityName = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
        let countryName = UserDefaults.standard.string(forKey: "countryNameKey") ?? ""
        var url_defi = myURL + "defibrillators/?searchtext=" + searchText + "&IncludeAddressInformation=true&DashboardColorGroup=1&PageSize=600"
        if !leftAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + leftAEDTextValueKey
        }
        if !rightAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + rightAEDTextValueKey
        }
        if !fromDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + fromDateElec
        }
        if !toDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + toDateElec
        }
        if !fromDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + fromDateBat
        }
        if !toDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + toDateBat
        }
        if !postalCode.isEmpty {
            url_defi += "&PostalCode=" + postalCode
        }
        if !cityName.isEmpty {
            url_defi += "&City=" + cityName
        }
        if !countryName.isEmpty {
            url_defi += "&Country=" + countryName
        }
        if !ownerName.isEmpty {
            url_defi += "&Owner=" + ownerName
        }
        let stringurlfixed = url_defi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(stringurlfixed!, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .responseJSON { response in
            self.isLoading = false
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dataArray = json["data"].array {
                    self.defibrillators = dataArray.map { SearchDefibrillator(json: $0) }
                } else {
                    self.error = "Data format is incorrect."
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}

class SearchViewModelColorBlue: ObservableObject {
    
    @Published var defibrillators: [SearchDefibrillator] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    @State private var currentPage = 1
    @State private var pageSize = 200
    @State private var hasMoreData = true
    
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    
    func fetchDataFilter(searchText: String, filter: String) {
        
        self.isLoading = true
        defibrillators.removeAll()
        let fromDateElec = UserDefaults.standard.string(forKey: "fromDateElecKey") ?? ""
        let toDateElec = UserDefaults.standard.string(forKey: "toDateElecKey") ?? ""
        let fromDateBat = UserDefaults.standard.string(forKey: "fromDateBatKey") ?? ""
        let toDateBat = UserDefaults.standard.string(forKey: "toDateBatKey") ?? ""
        let leftAEDTextValueKey = UserDefaults.standard.string(forKey: "leftAEDTextValueKey") ?? ""
        let rightAEDTextValueKey = UserDefaults.standard.string(forKey: "rightAEDTextValueKey") ?? ""
        let ownerName = UserDefaults.standard.string(forKey: "ownerNameKey") ?? ""
        let postalCode = UserDefaults.standard.string(forKey: "postalCodeKey") ?? ""
        let cityName = UserDefaults.standard.string(forKey: "cityNameKey") ?? ""
        let countryName = UserDefaults.standard.string(forKey: "countryNameKey") ?? ""
        var url_defi = myURL + "defibrillators/?searchtext=" + searchText + "&IncludeAddressInformation=true&DashboardColorGroup=4"
        if !leftAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + leftAEDTextValueKey
        }
        if !rightAEDTextValueKey.isEmpty {
            url_defi += "&AedComBatteryCapacity=" + rightAEDTextValueKey
        }
        if !fromDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + fromDateElec
        }
        if !toDateElec.isEmpty {
            url_defi += "&ElectrodeExpirationDate=" + toDateElec
        }
        if !fromDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + fromDateBat
        }
        if !toDateBat.isEmpty {
            url_defi += "&BatteryExpirationDate=" + toDateBat
        }
        if !postalCode.isEmpty {
            url_defi += "&PostalCode=" + postalCode
        }
        if !cityName.isEmpty {
            url_defi += "&City=" + cityName
        }
        if !countryName.isEmpty {
            url_defi += "&Country=" + countryName
        }
        if !ownerName.isEmpty {
            url_defi += "&Owner=" + ownerName
        }
        let stringurlfixed = url_defi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(stringurlfixed!, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .responseJSON { response in
            self.isLoading = false
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dataArray = json["data"].array {
                    self.defibrillators = dataArray.map { SearchDefibrillator(json: $0) }
                } else {
                    self.error = "Data format is incorrect."
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
