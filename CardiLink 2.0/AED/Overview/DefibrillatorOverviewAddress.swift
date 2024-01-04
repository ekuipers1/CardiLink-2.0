//
//  DefibrillatorOverviewAddress.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//

import SwiftUI
import MapKit

struct DisplayAddress: View {
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 00.100, longitude: 00.100),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @AppStorage("geoLocationLat") var message_lat: String?
    @AppStorage("geoLocationLon") var message_lng: String?
    @AppStorage("defridetailAdminStatusColor") var defridetailAdminStatusColor: Int?
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    @State private var showAddress = false
    @State private var showHours = false
    
    var body: some View {
        ZStack(){
            let myDoubleLat =  Double(message_lat ?? "")
            let myDoubleLon =  Double(message_lng ?? "")
            if myDoubleLat == nil {
                let places = [
                    Place(name: "Sub zero", latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100)
                ]
                
                Map(coordinateRegion: $coordinateRegion, interactionModes: [], annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        VStack(){
                            HStack(){
                                Image(systemName: "xmark.octagon.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130,
                                           height: 130)
                                    .foregroundColor(.colorCardiRed)
                            }
                            Text("No Data Available")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.colorCardiRed)
                        }
                        .padding()
                        .foregroundColor(.black)
                        .cornerRadius(40)
                        .shadow(radius: 5, y: 5)
                    }
                }.frame(width: 340, height: 320, alignment: .center)
                    .cornerRadius(25)
                    .shadow(radius: 5, y: 5)
                    .opacity(0.5)
                    .padding(.top, 20.0)
                if showAddress {
                    showAddressContent()
                        .padding(.top, 50.0)
                }
                if showHours {
                    showHoursContent()
                }
            } else {
                let places = [
                    Place(name: "" , latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820)
                ]
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820), span: MKCoordinateSpan(latitudeDelta: 0.0009, longitudeDelta: 0.0009))), annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        let whatStatusImage = defridetailAdminStatusColor
                        switch whatStatusImage {
                        case 0:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.Map_Calming_Green)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                        case 1:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.Cardi_Yellow)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                        case 2:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.colorCardiRed)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                            
                        case 3:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.Cardi_Yellow)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                        case 4:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.colorCardiRed)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                        case 5:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.colorCardiGray)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                        default:
                            VStack(){
                                HStack(){
                                    Image(systemName: "bolt.heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,
                                               height: 30)
                                        .foregroundColor(Color.Map_Calming_Green)
                                }
                                Text(defridetailSerial ?? "N/A")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width: 100)
                            }
                            
                            .padding()
                            .foregroundColor(.black)
                            .cornerRadius(40)
                            .shadow(radius: 5, y: 5)
                        }
                    }
                }.frame(width: 340, height: 320, alignment: .center)
                    .cornerRadius(25)
                    .shadow(radius: 5, y: 5)
                    .padding(.top, 20.0)
                if showAddress {
                    showAddressContent()
                        .padding(.top, 50.0)
                }
                if showHours {
                    showHoursContent()
                }
                HStack(){
                    ZStack(){
                        Button(action: { withAnimation {
                            showAddress.toggle()
                        } }) {
                            Image(systemName: self.showAddress == true ? "xmark" : "house.fill")
                                .font(.title3)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .padding(showHours ? 15.0 : 15.0)
                        }
                        .background(Circle().fill(Color.Cardi_Text))
                        .offset(x: -10, y: -25)
                        .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
                        .opacity(showHours ? 0 : 1)
                        .offset(x: showAddress ? 65 : 0)
                    }  .offset(x: 105, y: -125)
                    ZStack(){
                        Button(action: { withAnimation {
                            showHours.toggle()
                        } }) {
                            Image(systemName: self.showHours == true ? "xmark" : "clock.badge.checkmark")
                                .font(.title3)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .padding(showAddress ? 15.0 : 15.0)
                        }
                        .background(Circle().fill(Color.Cardi_Text))
                        .offset(x:-10, y: -25)
                        .opacity(showAddress ? 0 : 1)
                        .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
                    }  .offset(x: 105, y: -125)
                }
            }
        }
    }
}
struct showAddressContent: View {
    
    @AppStorage("geoAddressStreet") var geoAddressStreet: String?
    @AppStorage("geoAddressNumber") var geoAddressNumber: String?
    @AppStorage("geoAddressFloor") var geoAddressFloor: String?
    @AppStorage("geoAddressPostal") var geoAddressPostal: String?
    @AppStorage("geoAddressCity") var geoAddressCity: String?
    @AppStorage("geoAddressCountry") var geoAddressCountry: String?
    
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.Cardi_Text)
                .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                .frame(width: 300, height: 280)
            HStack(){
                VStack(){
                    HStack(spacing: 14){
                        Text("Address information")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .trailing)
                        .offset(x: 10, y: 0)
                    
                    HStack(spacing: 14){
                        Text("Street:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                        if #available(iOS 15.0, *) {
                            Text(geoAddressStreet ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 8)
                                .textSelection(.enabled)
                        } else {
                            Text(geoAddressStreet ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 8)
                        }
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 60, alignment: .trailing)
                        .offset(x: 10, y: 0)
                    HStack(spacing: 5){
                        Text("House number:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                        Text(geoAddressNumber ?? "N/A")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.regular)
                            .padding(.trailing, 25)
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                    .offset(x: 10, y: 0)
                    
                    HStack(spacing: 5){
                        Text("Floor level:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                        Text(geoAddressFloor ?? "N/A")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.regular)
                            .padding(.trailing, 25)
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                    .offset(x: 10, y: 0)
                    
                    HStack(spacing: 5){
                        Text("Postal Code:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                        if #available(iOS 15.0, *) {
                            Text(geoAddressPostal ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                                .textSelection(.enabled)
                        } else {
                            Text(geoAddressPostal ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                    .offset(x: 10, y: 0)
                    
                    HStack(spacing: 5){
                        Text("City:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                        
                        if #available(iOS 15.0, *) {
                            Text(geoAddressCity ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                                .textSelection(.enabled)
                        } else {
                            Text(geoAddressCity ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                    .offset(x: 10, y: 0)
                    
                    HStack(spacing: 5){
                        Text("Country:")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                        if #available(iOS 15.0, *) {
                            Text(geoAddressCountry ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                                .textSelection(.enabled)
                        } else {
                            Text(geoAddressCountry ?? "N/A")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .padding(.trailing, 25)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                    .offset(x: 10, y: 0)
                }
            }
        }
    }
}
struct showHoursContent: View {
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.Cardi_Text)
                .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                .frame(width: 300, height: 220)
            HStack(){
                VStack(){
                    HStack(spacing: 14){
                        Text("Availability")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                            .padding(.trailing, 8)
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .trailing)
                        .offset(x: 10, y: 0)
                    
                    HStack(spacing: 4){
                        Image(systemName: "clock.fill")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .padding(10.0)
                        Text("No AED time availability information available")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 8)
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 70, alignment: .trailing)
                        .offset(x: 10, y: 0)
                    
                    HStack(spacing: 4){
                        Image(systemName: "lock.fill")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .padding(10.0)
                        Text("No AED access information available")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 8)
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 70, alignment: .trailing)
                        .offset(x: 10, y: 0)
                }
            }
        }
    }
}
struct TimeUpdateDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var item: AvailabilityDataViewModel
    @StateObject private var viewModel = DeviceAvailabilitySelectedViewModel()
    
    let saveAction: () -> Void
    var body: some View {
        VStack(alignment: .trailing) {
            ZStack(alignment: .top) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.square.fill")
                        .hamburgerMenu()
                }
                .padding(.top, 20.0)
            }
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCardSmall()
                VStack(alignment: .leading){
                    
                    Text(String(item.availabilityData.availabilityDay))
                    Text(item.availabilityData.availabilityDayText)
                    Text(item.id)
                    DatePicker("From", selection: $item.fromTimeDate, displayedComponents: .hourAndMinute)
                        .frame(width: widthInnerTextMini)
                    DatePicker("To", selection: $item.toTimeDate, displayedComponents: .hourAndMinute)
                        .frame(width: widthInnerTextMini)
                    Button("Save", action: saveUpdatedDates)
                }.frame(width: widthInnerText)
            }
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
    
    func saveUpdatedDates() {
        viewModel.deleteAvailability(id: item.id) { success in
            if success {
                
                var currentHourStart: Int
                var currentMinuteStart: Int
                var currentHourEnd: Int
                var currentMinuteEnd: Int
                var DaySelected: Int
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeZone = TimeZone(abbreviation: "CEST")!
                
                if timeZone.isDaylightSavingTime(for: Date()) {
                    var calendar = Calendar(identifier: .gregorian)
                    calendar.timeZone = TimeZone(abbreviation: "CEST")!
                    currentHourStart = calendar.component(.hour, from: item.fromTimeDate)
                    currentMinuteStart = calendar.component(.minute, from: item.fromTimeDate)
                    currentHourEnd = calendar.component(.hour, from: item.toTimeDate)
                    currentMinuteEnd = calendar.component(.minute, from: item.toTimeDate)
                } else {
                    var calendar = Calendar(identifier: .gregorian)
                    calendar.timeZone = TimeZone(abbreviation: "CET")!
                    currentHourStart = calendar.component(.hour, from: item.fromTimeDate)
                    currentMinuteStart = calendar.component(.minute, from: item.fromTimeDate)
                    currentHourEnd = calendar.component(.hour, from: item.toTimeDate)
                    currentMinuteEnd = calendar.component(.minute, from: item.toTimeDate)
                }
                
                let defaults = UserDefaults.standard
                let myURL = defaults.string(forKey: "myPortal")
                let AuthKey = defaults.string(forKey: "DATASTRING")
                let authKey = AuthKey!
                @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
                DaySelected = item.availabilityData.availabilityDay
                let StartHours = currentHourStart
                let StartMin = currentMinuteStart
                let EndHours = currentHourEnd
                let EndMin = currentMinuteEnd
                let calendar = Calendar.current
                let now = Date()
                let midnight = calendar.startOfDay(for: now)
                let dayStart = calendar.date(bySettingHour: StartHours, minute: StartMin, second: 0, of: now)!
                _ = calendar.dateComponents([.minute], from: midnight, to: dayStart).minute!
                let dayEnd = calendar.date(bySettingHour: EndHours, minute: EndMin, second: 0, of: now)!
                _ = calendar.dateComponents([.minute], from: midnight, to: dayEnd).minute!
                let parameters = "[{\"fromTime\": \(StartHours * 60 + StartMin),\"toTime\":\(EndHours * 60 + EndMin),\"availabilityDay\":\(DaySelected)}]"
                let postData = parameters.data(using: .utf8)
                let currentDefie = defaults.string(forKey: "defridetailID")
                let myDefibrillators = "defibrillators/"
                let url_defi = myURL! + myDefibrillators
                let endit = "/availabilities"
                let finalURL = url_defi + currentDefie! + endit
                
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
            } else {
            }
        }
    }
}

