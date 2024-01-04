//
//  AvailData.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 21.03.23.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON


struct Availability: Codable {
    let fromTime: Int
    let toTime: Int
    let availabilityDate: Int
}



func DataAvailMonday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!

    @AppStorage("timeStartMon") var timeStartMon: String?
    @AppStorage("timeEndMon") var timeEndMon: String?
    
    @AppStorage("timeStartMonHH") var timeStartMonHH: String?
    @AppStorage("timeStartMonmm") var timeStartMonmm: String?
    @AppStorage("timeEndMonHH") var timeEndMonHH: String?
    @AppStorage("timeEndMonmm") var timeEndMonmm: String?
    @AppStorage("MondaySelected") var MondaySelected: String?
    
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    print("defibrillatorId:" ,ADdefibrillatorId ?? "0000000000")
    
    let monStartHours = Int(timeStartMonHH!)!
    let monStartMin = Int(timeStartMonmm!)!
    let monEndHours = Int(timeEndMonHH!)!
    let monEndMin = Int(timeEndMonmm!)!
    let mondaySelected = Int(MondaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    //MON
    let mondayStart = calendar.date(bySettingHour: monStartHours, minute: monStartMin, second: 0, of: now)!
    let minutesFromMidnightMondayStart = calendar.dateComponents([.minute], from: midnight, to: mondayStart).minute!
    let mondayEnd = calendar.date(bySettingHour: monEndHours, minute: monEndMin, second: 0, of: now)!
    let minutesFromMidnightMondayEnd = calendar.dateComponents([.minute], from: midnight, to: mondayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightMondayStart),\"toTime\":\(minutesFromMidnightMondayEnd),\"availabilityDay\":\(mondaySelected)}]"
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)

    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailTuesday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartTueHH") var timeStartTueHH: String?
    @AppStorage("timeStartTuemm") var timeStartTuemm: String?
    @AppStorage("timeEndTueHH") var timeEndTueHH: String?
    @AppStorage("timeEndTuemm") var timeEndTuemm: String?
    @AppStorage("TuesdaySelected") var TuesdaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let tueStartHours = Int(timeStartTueHH!)!
    let tueStartMin = Int(timeStartTuemm!)!
    let tueEndHours = Int(timeEndTueHH!)!
    let tueEndMin = Int(timeEndTuemm!)!
    let tuesdaySelected = Int(TuesdaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    //TUE
    let tuesdayStart = calendar.date(bySettingHour: tueStartHours, minute: tueStartMin, second: 0, of: now)!
    let minutesFromMidnightTuesdayStart = calendar.dateComponents([.minute], from: midnight, to: tuesdayStart).minute!
    let tuesdayEnd = calendar.date(bySettingHour: tueEndHours, minute: tueEndMin, second: 0, of: now)!
    let minutesFromMidnightTuesdayEnd = calendar.dateComponents([.minute], from: midnight, to: tuesdayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightTuesdayStart),\"toTime\":\(minutesFromMidnightTuesdayEnd),\"availabilityDay\":\(tuesdaySelected)}]"
    
    //    parameters = parametersMonday + parametersTuesday
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)

    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailWednesday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartWedHH") var timeStartWedHH: String?
    @AppStorage("timeStartWedmm") var timeStartWedmm: String?
    @AppStorage("timeEndWedHH") var timeEndWedHH: String?
    @AppStorage("timeEndWedmm") var timeEndWedmm: String?
    @AppStorage("WednesdaySelected") var WednesdaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let wedStartHours = Int(timeStartWedHH!)!
    let wedStartMin = Int(timeStartWedmm!)!
    let wedEndHours = Int(timeEndWedHH!)!
    let wedEndMin = Int(timeEndWedmm!)!
    let wednesdaySelected = Int(WednesdaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    //TUE
    let wednesdayStart = calendar.date(bySettingHour: wedStartHours, minute: wedStartMin, second: 0, of: now)!
    let minutesFromMidnightWednesdayStart = calendar.dateComponents([.minute], from: midnight, to: wednesdayStart).minute!
    let wednesdayEnd = calendar.date(bySettingHour: wedEndHours, minute: wedEndMin, second: 0, of: now)!
    let minutesFromMidnightWednesdayEnd = calendar.dateComponents([.minute], from: midnight, to: wednesdayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightWednesdayStart),\"toTime\":\(minutesFromMidnightWednesdayEnd),\"availabilityDay\":\(wednesdaySelected)}]"
    
    //    parameters = parametersMonday + parametersTuesday
    
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)
    
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailThursday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartThuHH") var timeStartThuHH: String?
    @AppStorage("timeStartThumm") var timeStartThumm: String?
    @AppStorage("timeEndThuHH") var timeEndThuHH: String?
    @AppStorage("timeEndThumm") var timeEndThumm: String?
    @AppStorage("ThursdaySelected") var ThursdaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let ThuStartHours = Int(timeStartThuHH!)!
    let ThuStartMin = Int(timeStartThumm!)!
    let ThuEndHours = Int(timeEndThuHH!)!
    let ThuEndMin = Int(timeEndThumm!)!
    let thursdaySelected = Int(ThursdaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    let ThursdayStart = calendar.date(bySettingHour: ThuStartHours, minute: ThuStartMin, second: 0, of: now)!
    let minutesFromMidnightThursdayStart = calendar.dateComponents([.minute], from: midnight, to: ThursdayStart).minute!
    let ThursdayEnd = calendar.date(bySettingHour: ThuEndHours, minute: ThuEndMin, second: 0, of: now)!
    let minutesFromMidnightThursdayEnd = calendar.dateComponents([.minute], from: midnight, to: ThursdayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightThursdayStart),\"toTime\":\(minutesFromMidnightThursdayEnd),\"availabilityDay\":\(thursdaySelected)}]"
    
    //    parameters = parametersMonday + parametersTuesday
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)
 
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailFriday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartFriHH") var timeStartFriHH: String?
    @AppStorage("timeStartFrimm") var timeStartFrimm: String?
    @AppStorage("timeEndFriHH") var timeEndFriHH: String?
    @AppStorage("timeEndFrimm") var timeEndFrimm: String?
    @AppStorage("FridaySelected") var FridaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let FriStartHours = Int(timeStartFriHH!)!
    let FriStartMin = Int(timeStartFrimm!)!
    let FriEndHours = Int(timeEndFriHH!)!
    let FriEndMin = Int(timeEndFrimm!)!
    let fridaySelected = Int(FridaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    let FridayStart = calendar.date(bySettingHour: FriStartHours, minute: FriStartMin, second: 0, of: now)!
    let minutesFromMidnightFridayStart = calendar.dateComponents([.minute], from: midnight, to: FridayStart).minute!
    let FridayEnd = calendar.date(bySettingHour: FriEndHours, minute: FriEndMin, second: 0, of: now)!
    let minutesFromMidnightFridayEnd = calendar.dateComponents([.minute], from: midnight, to: FridayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightFridayStart),\"toTime\":\(minutesFromMidnightFridayEnd),\"availabilityDay\":\(fridaySelected)}]"
    
    //    parameters = parametersMonday + parametersTuesday
    
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)

    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailSaturday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartSatHH") var timeStartSatHH: String?
    @AppStorage("timeStartSatmm") var timeStartSatmm: String?
    @AppStorage("timeEndSatHH") var timeEndSatHH: String?
    @AppStorage("timeEndSatmm") var timeEndSatmm: String?
    @AppStorage("SaturdaySelected") var SaturdaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let SatStartHours = Int(timeStartSatHH!)!
    let SatStartMin = Int(timeStartSatmm!)!
    let SatEndHours = Int(timeEndSatHH!)!
    let SatEndMin = Int(timeEndSatmm!)!
    let saturdaySelected = Int(SaturdaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    let SaturdayStart = calendar.date(bySettingHour: SatStartHours, minute: SatStartMin, second: 0, of: now)!
    let minutesFromMidnightSaturdayStart = calendar.dateComponents([.minute], from: midnight, to: SaturdayStart).minute!
    let SaturdayEnd = calendar.date(bySettingHour: SatEndHours, minute: SatEndMin, second: 0, of: now)!
    let minutesFromMidnightSaturdayEnd = calendar.dateComponents([.minute], from: midnight, to: SaturdayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightSaturdayStart),\"toTime\":\(minutesFromMidnightSaturdayEnd),\"availabilityDay\":\(saturdaySelected)}]"
    
    
    //    parameters = parametersMonday + parametersTuesday
    
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)
    
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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

func DataAvailSunday() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    @AppStorage("timeStartSunHH") var timeStartSunHH: String?
    @AppStorage("timeStartSunmm") var timeStartSunmm: String?
    @AppStorage("timeEndSunHH") var timeEndSunHH: String?
    @AppStorage("timeEndSunmm") var timeEndSunmm: String?
    @AppStorage("SundaySelected") var SundaySelected: String?
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let SunStartHours = Int(timeStartSunHH!)!
    let SunStartMin = Int(timeStartSunmm!)!
    let SunEndHours = Int(timeEndSunHH!)!
    let SunEndMin = Int(timeEndSunmm!)!
    let sundaySelected = Int(SundaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    let SundayStart = calendar.date(bySettingHour: SunStartHours, minute: SunStartMin, second: 0, of: now)!
    let minutesFromMidnightSundayStart = calendar.dateComponents([.minute], from: midnight, to: SundayStart).minute!
    let SundayEnd = calendar.date(bySettingHour: SunEndHours, minute: SunEndMin, second: 0, of: now)!
    let minutesFromMidnightSundayEnd = calendar.dateComponents([.minute], from: midnight, to: SundayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightSundayStart),\"toTime\":\(minutesFromMidnightSundayEnd),\"availabilityDay\":\(sundaySelected)}]"
    
    //    parameters = parametersMonday + parametersTuesday
    
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)

    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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



func DataAvailUpdate() {
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!

    @AppStorage("timeStartMon") var timeStartMon: String?
    @AppStorage("timeEndMon") var timeEndMon: String?
    
    @AppStorage("timeStartMonHH") var timeStartMonHH: String?
    @AppStorage("timeStartMonmm") var timeStartMonmm: String?
    @AppStorage("timeEndMonHH") var timeEndMonHH: String?
    @AppStorage("timeEndMonmm") var timeEndMonmm: String?
    @AppStorage("MondaySelected") var MondaySelected: String?
    
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    print("defibrillatorId:" ,ADdefibrillatorId ?? "0000000000")
    
    let monStartHours = Int(timeStartMonHH!)!
    let monStartMin = Int(timeStartMonmm!)!
    let monEndHours = Int(timeEndMonHH!)!
    let monEndMin = Int(timeEndMonmm!)!
    let mondaySelected = Int(MondaySelected!)!
    
    let calendar = Calendar.current
    let now = Date()
    let midnight = calendar.startOfDay(for: now)
    
    //MON
    let mondayStart = calendar.date(bySettingHour: monStartHours, minute: monStartMin, second: 0, of: now)!
    let minutesFromMidnightMondayStart = calendar.dateComponents([.minute], from: midnight, to: mondayStart).minute!
    let mondayEnd = calendar.date(bySettingHour: monEndHours, minute: monEndMin, second: 0, of: now)!
    let minutesFromMidnightMondayEnd = calendar.dateComponents([.minute], from: midnight, to: mondayEnd).minute!
    
    let parameters = "[{\"fromTime\": \(minutesFromMidnightMondayStart),\"toTime\":\(minutesFromMidnightMondayEnd),\"availabilityDay\":\(mondaySelected)}]"
    
    let postData = parameters.data(using: .utf8)
    
    
    let myDefibrillators = "defibrillators/" //4500
    let url_defi = myURL! + myDefibrillators
    let currentDefie = ADdefibrillatorId ?? "0000000000"
    let endit = "/availabilities"
    
    let finalURL = url_defi + currentDefie + endit
    
    print(finalURL)
    
    var request = URLRequest(url: URL(string: finalURL)!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
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


//MARK: DELETE MONDAY



func deleteTimeData() {
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let defaults = UserDefaults.standard

    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    print("NEXT DATASTRING: ", AuthKey!)
    let authKey = AuthKey!
    
    let myDefibrillators = "defibrillators/"
    let endit = "/availabilities"
    let url_defi = myURL! + myDefibrillators
    let finalURL = url_defi + (ADdefibrillatorId ?? "0000") + endit

    var request = URLRequest(url: URL(string: finalURL)!, timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(authKey, forHTTPHeaderField: "authkey")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var idsToDelete: [String] = []
    
    // Fetching the IDs from UserDefaults
    for day in days {
        if let id = UserDefaults.standard.string(forKey: "\(day)ID") {
            idsToDelete.append(id)
        }
    }
    
    do {
        let postData = try JSONSerialization.data(withJSONObject: idsToDelete, options: [])
        request.httpBody = postData
    } catch {
        print("Error serializing JSON: \(error)")
    }
    
    request.httpMethod = "DELETE"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("Successfully deleted the data")
        } else {
            print("Failed to delete the data")
        }
    }
    
    task.resume()
}


//func deleteTimeData() {
//
//    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
//
//    let defaults = UserDefaults.standard
//
//    let myURL = defaults.string(forKey: "myPortal")
//    let AuthKey = defaults.string(forKey: "DATASTRING")
//    print("NEXT DATASTRING: ", AuthKey!)
//    let authKey = AuthKey!
//
//    let myDefibrillators = "defibrillators/"
//    let endit = "/availabilities"
//    let url_defi = myURL! + myDefibrillators
//
//    let finalURL = url_defi + (ADdefibrillatorId ?? "0000") + endit
//
//    var request = URLRequest(url: URL(string: finalURL)!, timeoutInterval: Double.infinity)
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    request.addValue(authKey, forHTTPHeaderField: "authkey")
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    let myString = "75e1972d-681e-498f-bb19-cd6a653f6bc4"
//    let jsonArray: [String] = [myString]
//
//    do {
//        let postData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
//        request.httpBody = postData
//    } catch {
//        print("Error serializing JSON: \(error)")
//    }
//
//    request.httpMethod = "DELETE"
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error: \(error)")
//            return
//        }
//
//        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//            print("Successfully deleted Monday data")
//        } else {
//            print("Failed to delete Monday data")
//        }
//    }
//
//    task.resume()
//}

func getAvialableDayTime(optionA: Bool = false) {
//func getAvialableDayTime() {
    
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    
    let defaults = UserDefaults.standard
    
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")

    let authKey = AuthKey!
    
    let myDefibrillators = "defibrillators/"
    let endit = "/availabilities"
    let url_defi = myURL! + myDefibrillators
    
    let finalURL = url_defi + (ADdefibrillatorId ?? "0000") + endit

    print("NEW URL: ", finalURL)
    
    AF.request(finalURL, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]).responseJSON { response in
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                
                for dayData in dataArray {
                    if let availabilityDay = dayData["availabilityDay"] as? Int,
                       let fromTime = dayData["fromTime"] as? Int,
                       let toTime = dayData["toTime"] as? Int,
                       let id = dayData["id"] as? String {
                        handleAvailability(day: availabilityDay, startTime: fromTime, endTime: toTime, id: id)
                    }
                }
                
                if optionA {
                               deleteTimeData()
                    
                    UserDefaults.standard.set("No", forKey: "Monday")
                    UserDefaults.standard.set("No", forKey: "Tuesday")
                    UserDefaults.standard.set("No", forKey: "Wednesday")
                    UserDefaults.standard.set("No", forKey: "Thursday")
                    UserDefaults.standard.set("No", forKey: "Friday")
                    UserDefaults.standard.set("No", forKey: "Saturday")
                    UserDefaults.standard.set("No", forKey: "Sunday")
                           }
                
            } else {
                print("Invalid JSON format or missing 'data' key.")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}

func handleAvailability(day: Int, startTime: Int, endTime: Int, id: String) {
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let dayShort = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    if day > 0 && day <= days.count {
        let dayString = days[day - 1]
        let dayShortString = dayShort[day - 1]
        
        // Set UserDefaults for day availability
        UserDefaults.standard.setValue("Yes", forKey: dayString)
        
        // Convert start and end times
        let fromTimeString = minutesToTimeString(minutes: startTime)
        let toTimeString = minutesToTimeString(minutes: endTime)
        
        // Set UserDefaults for start and end times
        UserDefaults.standard.setValue(fromTimeString, forKey: "timeStart\(dayShortString)")
        UserDefaults.standard.setValue(toTimeString, forKey: "timeEnd\(dayShortString)")
        
        // Store the ID
        UserDefaults.standard.setValue(id, forKey: "\(dayString)ID")
    }
}

// Convert minutes since midnight to a time string
func minutesToTimeString(minutes: Int) -> String {
    let hours = minutes / 60
    let remainingMinutes = minutes % 60
    return String(format: "%02d:%02d", hours, remainingMinutes)
}


