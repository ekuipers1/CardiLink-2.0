//
//  DeviceAvailabilityViewModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 21.06.23.
//

import Combine
import Alamofire
import SwiftyJSON
import Foundation

class DeviceAvailabilityViewModel: ObservableObject {
    @Published var is24_7Available: Bool? = nil
    var cancellable: AnyCancellable? = nil
    
    func checkAvailability() {
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey ?? ""
        let currentDefie = defaults.string(forKey: "defridetailID")
        let myDefibrillators = "defibrillators/"
        let url_defi = myURL! + myDefibrillators + (currentDefie ?? "0000000000")
        let urlComList = "\(url_defi)/DeviceIs24-7Available"
        
        AF.request(urlComList, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.is24_7Available = json["data"].bool
            case .failure(let error):
                print(error)
            }
        }
    }
}

class AvailabilityDataViewModel: ObservableObject, Identifiable, Hashable {
    @Published var availabilityData: AvailabilityData
    @Published var fromTimeDate: Date
    @Published var toTimeDate: Date
    var id: String { availabilityData.id }
    
    init(availabilityData: AvailabilityData) {
        self.availabilityData = availabilityData
        
        let calendar = Calendar.current
        let fromHours = availabilityData.fromTime / 60
        let fromMinutes = availabilityData.fromTime % 60
        let toHours = availabilityData.toTime / 60
        let toMinutes = availabilityData.toTime % 60
        
        self.fromTimeDate = calendar.date(bySettingHour: fromHours, minute: fromMinutes, second: 0, of: Date()) ?? Date()
        self.toTimeDate = calendar.date(bySettingHour: toHours, minute: toMinutes, second: 0, of: Date()) ?? Date()
    }
    
    static func == (lhs: AvailabilityDataViewModel, rhs: AvailabilityDataViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class DeviceAvailabilitySelectedViewModel: ObservableObject {
    @Published var availabilityData: [AvailabilityDataViewModel] = []
    var cancellable: AnyCancellable? = nil
    
    var is24_7Empty: Bool {
        return UserDefaults.standard.bool(forKey: "24/7Empty")
    }
    
    func checkAvailabilityEmpty() {
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey ?? ""
        let myDefibrillators = "defibrillators/"
        let currentDefie = defaults.string(forKey: "defridetailID") ?? "0000000000"
        let url_defi = myURL! + myDefibrillators + currentDefie
        let urlComList = "\(url_defi)/availabilities"
        
        AF.request(urlComList, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseDecodable(of: AvailabilityResponse.self) { response in
            switch response.result {
            case .success(let availabilityResponse):
                DispatchQueue.main.async {
                    self.availabilityData = availabilityResponse.data.map(AvailabilityDataViewModel.init)
                    self.availabilityData.sort { $0.availabilityData.availabilityDay < $1.availabilityData.availabilityDay }
                    if self.availabilityData.isEmpty {
                        defaults.set(true, forKey: "24/7Empty")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteAvailability(id: String, completion: @escaping (Bool) -> Void) {
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey ?? ""
        let currentDefie = defaults.string(forKey: "defridetailID")
        let myDefibrillators = "defibrillators/"
        let url_defi = myURL! + myDefibrillators + currentDefie!
        let urlComList = "\(url_defi)/availabilities"
        let array = [id]
        let jsonData = try? JSONSerialization.data(withJSONObject: array)
        
        AF.upload(jsonData!, to: urlComList, method: .delete, headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).response { [weak self] response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self?.availabilityData.removeAll(where: { String(describing: $0.id) == id })
                    completion(true)
                }
            case .failure(let error):
                completion(false)
            }
        }
    }
}

struct AvailabilityResponse: Decodable {
    let success: Bool
    let error: String?
    let errorCode: Int
    let data: [AvailabilityData]
    let count: Int?
}

struct AvailabilityData: Decodable, Identifiable {
    let id: String
    let fromTime: Int
    let toTime: Int
    let availabilityDay: Int
    
    var fromTimeHourMinute: String {
        let hours = fromTime / 60
        let minutes = fromTime % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var toTimeHourMinute: String {
        let hours = toTime / 60
        let minutes = toTime % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var availabilityDayText: String {
        switch availabilityDay {
        case 1: return "Monday"
        case 2: return "Tuesday"
        case 3: return "Wednesday"
        case 4: return "Thursday"
        case 5: return "Friday"
        case 6: return "Saturday"
        case 7: return "Sunday"
        default: return "Unknown day"
        }
    }
}
