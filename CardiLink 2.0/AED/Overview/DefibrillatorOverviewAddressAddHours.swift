//
//  DefibrillatorOverviewAddressAddHours.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 26.06.23.
//

import SwiftUI

struct DefibrillatorOverviewAddressAddHours: View {
    @State private var disabled = true
    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTimeStart = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @State private var selectedTimeEnd = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    @State var timeEnd: String = ""
    @State var timeStart: String = ""
    let dateFormatter = DateFormatter()
    @State private var isShowingOverview: Bool = false
    @State private var showAlert = false
    @State private var CopyMonday = false
    @State private var isOnMonday = false
    @State private var isOnTuesday = false
    @State private var isOnWednesday = false
    @State private var isOnThursday = false
    @State private var isOnFriday = false
    @State private var isOnSaturday = false
    @State private var isOnSunday = false
    @State private var addMonday: Bool = false
    @ObservedObject var viewModel: DeviceAvailabilityViewModel
    
    var body: some View {
        VStack(alignment: .trailing){
            ScrollView(.vertical){
                if viewModel.is24_7Available == false {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cardi_Text)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: 325, height: 70)
                        VStack {
                            HStack(){
                                Text("Open 24/7")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                HStack {
                                    Text(viewModel.is24_7Available ?? true ? "YES" : "NO")
                                        .foregroundColor(viewModel.is24_7Available ?? true ? .Calming_Green : .colorCardiRed)
                                        .bold()
                                        .frame(width: 60, height: 30)
                                    Toggle("", isOn: Binding<Bool>(
                                        get: { self.viewModel.is24_7Available ?? true },
                                        set: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "is247Available")
                                            ADAvailable247()
                                            self.viewModel.is24_7Available = newValue
                                        }
                                    ))
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: viewModel.is24_7Available ?? true ? .Calming_Green : .colorCardiRed))
                                    .frame(width: 60)
                                }
                                .padding()
                            }
                            .frame(width:width)
                        }
                    }.padding(.top, 30.0)
                    ZStack(alignment: .top){
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .backgroundCardMedium()
                        VStack(){
                            VStack(){
                                Text("Opening hours")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:widthInnerTextBorder, height: 60)
                                    .padding(.top, 30.0)
                            }.padding(.bottom, 10.0)
                            ScrollView(.vertical){
                                VStack(){
                                    Spacer()
                                    ZStack(){
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color.Cardi_Text)
                                            .frame(width: widthInnerTextBorder, height: 120)
                                            .shadow(color: .gray, radius: 3, y: 1)
                                        HStack(){
                                            Spacer()
                                            VStack(){
                                                Text("From")
                                                DatePicker("This AED is avaialble from", selection: $selectedTimeStart,  displayedComponents: [.hourAndMinute])
                                                    .labelsHidden()
                                            }
                                            Spacer()
                                            VStack(){
                                                Text("To")
                                                DatePicker("This AED is avaialble to", selection: $selectedTimeEnd, displayedComponents: [.hourAndMinute])
                                                    .labelsHidden()
                                            }
                                            Spacer()
                                        } .frame(width:widthInnerText)
                                        Rectangle()
                                            .fill(Color.Cardi_Text)
                                            .frame(width: 120, height: 30)
                                            .offset(x: 0, y: -65)
                                        Text("Select Time")
                                            .font(.headline)
                                            .offset(x: 0, y: -62)
                                    }
                                    ZStack(){
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color.Cadi_Select)
                                            .frame(width: widthInnerTextBorder, height: 220)
                                            .shadow(color: .gray, radius: 3, y: 1)
                                        VStack(){
                                            HStack(){
                                                Toggle("Monday", isOn: $isOnMonday)
                                                    .toggleStyle(.button)
                                                    .accentColor(.Calming_Green)
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "HH:mm"
                                                        let timeZone = TimeZone(abbreviation: "CEST")!
                                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartMonHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartMonmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndMonHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndMonmm")
                                                        } else {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartMonHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartMonmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndMonHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndMonmm")
                                                        }
                                                        
                                                        let timeStartMon = selectedTimeStart.toString(withFormat: "HH:mm")
                                                        let timeEndMon = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                        UserDefaults.standard.set(timeStartMon, forKey: "timeStartMon")
                                                        UserDefaults.standard.set(timeEndMon, forKey: "timeEndMon")
                                                        UserDefaults.standard.set(1, forKey: "MondaySelected")
                                                        if isOnMonday == false {
                                                            UserDefaults.standard.set("Yes", forKey: "Monday")
                                                        }else{
                                                            UserDefaults.standard.set("No", forKey: "Monday")
                                                        }
                                                    })
                                                Spacer()
                                                VStack(alignment: .trailing) {
                                                    Toggle("Tuesday", isOn: $isOnTuesday)
                                                        .toggleStyle(.button)
                                                        .tint(.Calming_Green)
                                                        .simultaneousGesture(TapGesture().onEnded{
                                                            let dateFormatter = DateFormatter()
                                                            dateFormatter.dateFormat = "HH:mm"
                                                            let timeZone = TimeZone(abbreviation: "CEST")!
                                                            if timeZone.isDaylightSavingTime(for: Date()) {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartTueHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartTuemm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndTueHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndTuemm")
                                                            } else {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartTueHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartTuemm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndTueHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndTuemm")
                                                            }
                                                            let timeStartTue = selectedTimeStart.toString(withFormat: "HH:mm")
                                                            let timeEndTue = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                            UserDefaults.standard.set(timeStartTue, forKey: "timeStartTue")
                                                            UserDefaults.standard.set(timeEndTue, forKey: "timeEndTue")
                                                            UserDefaults.standard.set(2, forKey: "TuesdaySelected")
                                                            if isOnTuesday == false {
                                                                UserDefaults.standard.set("Yes", forKey: "Tuesday")
                                                            }else{
                                                                UserDefaults.standard.set("No", forKey: "Tuesday")
                                                            }
                                                        })
                                                }
                                            }.frame(width: widthInnerTextBorderText)
                                                .offset(x: 0, y: 0)
                                            HStack(){
                                                Toggle("Wednesday", isOn: $isOnWednesday)
                                                    .toggleStyle(.button)
                                                    .tint(.Calming_Green)
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "HH:mm"
                                                        let timeZone = TimeZone(abbreviation: "CEST")!
                                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartWedHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartWedmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndWedHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndWedmm")
                                                            
                                                        } else {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartWedHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartWedmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndWedHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndWedmm")
                                                        }
                                                        let timeStartWed = selectedTimeStart.toString(withFormat: "HH:mm")
                                                        let timeEndWed = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                        UserDefaults.standard.set(timeStartWed, forKey: "timeStartWed")
                                                        UserDefaults.standard.set(timeEndWed, forKey: "timeEndWed")
                                                        UserDefaults.standard.set(3, forKey: "WednesdaySelected")
                                                        if isOnWednesday == false {
                                                            UserDefaults.standard.set("Yes", forKey: "Wednesday")
                                                        }else{
                                                            UserDefaults.standard.set("No", forKey: "Wednesday")
                                                        }
                                                    })
                                                Spacer()
                                                VStack(alignment: .trailing) {
                                                    Toggle("Thursday", isOn: $isOnThursday)
                                                        .toggleStyle(.button)
                                                        .tint(.Calming_Green)
                                                        .simultaneousGesture(TapGesture().onEnded{
                                                            let dateFormatter = DateFormatter()
                                                            dateFormatter.dateFormat = "HH:mm"
                                                            let timeZone = TimeZone(abbreviation: "CEST")!
                                                            if timeZone.isDaylightSavingTime(for: Date()) {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartThuHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartThumm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndThuHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndThumm")
                                                            } else {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartThuHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartThumm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndThuHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndThumm")
                                                            }
                                                            let timeStartThu = selectedTimeStart.toString(withFormat: "HH:mm")
                                                            let timeEndThu = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                            UserDefaults.standard.set(4, forKey: "ThursdaySelected")
                                                            UserDefaults.standard.set(timeStartThu, forKey: "timeStartThu")
                                                            UserDefaults.standard.set(timeEndThu, forKey: "timeEndThu")
                                                            if isOnThursday == false {
                                                                UserDefaults.standard.set("Yes", forKey: "Thursday")
                                                            }else{
                                                                UserDefaults.standard.set("No", forKey: "Thursday")
                                                            }
                                                        })
                                                }
                                            }.frame(width: widthInnerTextBorderText)
                                            HStack(){
                                                Toggle("Friday", isOn: $isOnFriday)
                                                    .toggleStyle(.button)
                                                    .tint(.Calming_Green)
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "HH:mm"
                                                        let timeZone = TimeZone(abbreviation: "CEST")!
                                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartFriHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartFrimm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndFriHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndFrimm")
                                                        } else {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartFriHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartFrimm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndFriHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndFrimm")
                                                        }
                                                        let timeStartFri = selectedTimeStart.toString(withFormat: "HH:mm")
                                                        let timeEndFri = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                        UserDefaults.standard.set(5, forKey: "FridaySelected")
                                                        UserDefaults.standard.set(timeStartFri, forKey: "timeStartFri")
                                                        UserDefaults.standard.set(timeEndFri, forKey: "timeEndFri")
                                                        if isOnFriday == false {
                                                            UserDefaults.standard.set("Yes", forKey: "Friday")
                                                        }else{
                                                            UserDefaults.standard.set("No", forKey: "Friday")
                                                        }
                                                    })
                                                Spacer()
                                                VStack(alignment: .trailing) {
                                                    Toggle("Saturday", isOn: $isOnSaturday)
                                                        .toggleStyle(.button)
                                                        .tint(.Calming_Green)
                                                        .simultaneousGesture(TapGesture().onEnded{
                                                            let dateFormatter = DateFormatter()
                                                            dateFormatter.dateFormat = "HH:mm"
                                                            let timeZone = TimeZone(abbreviation: "CEST")!
                                                            if timeZone.isDaylightSavingTime(for: Date()) {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartSatHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartSatmm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndSatHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndSatmm")
                                                            } else {
                                                                var calendar = Calendar(identifier: .gregorian)
                                                                calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                                let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                                let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                                let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                                let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                                UserDefaults.standard.set(currentHourStart, forKey: "timeStartSatHH")
                                                                UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartSatmm")
                                                                UserDefaults.standard.set(currentHourEnd, forKey: "timeEndSatHH")
                                                                UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndSatmm")
                                                            }
                                                            let timeStartSat = selectedTimeStart.toString(withFormat: "HH:mm")
                                                            let timeEndSat = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                            UserDefaults.standard.set(6, forKey: "SaturdaySelected")
                                                            UserDefaults.standard.set(timeStartSat, forKey: "timeStartSat")
                                                            UserDefaults.standard.set(timeEndSat, forKey: "timeEndSat")
                                                            if isOnSaturday == false {
                                                                UserDefaults.standard.set("Yes", forKey: "Saturday")
                                                            }else{
                                                                UserDefaults.standard.set("No", forKey: "Saturday")
                                                            }
                                                        })
                                                }
                                            }.frame(width: widthInnerTextBorderText)
                                            HStack(){
                                                Toggle("Sunday", isOn: $isOnSunday)
                                                    .toggleStyle(.button)
                                                    .tint(.Calming_Green)
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "HH:mm"
                                                        let timeZone = TimeZone(abbreviation: "CEST")!
                                                        if timeZone.isDaylightSavingTime(for: Date()) {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CEST")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartSunHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartSunmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndSunHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndSunmm")
                                                        } else {
                                                            var calendar = Calendar(identifier: .gregorian)
                                                            calendar.timeZone = TimeZone(abbreviation: "CET")!
                                                            let currentHourStart = calendar.component(.hour, from: selectedTimeStart)
                                                            let currentMinuteStart = calendar.component(.minute, from: selectedTimeStart)
                                                            let currentHourEnd = calendar.component(.hour, from: selectedTimeEnd)
                                                            let currentMinuteEnd = calendar.component(.minute, from: selectedTimeEnd)
                                                            UserDefaults.standard.set(currentHourStart, forKey: "timeStartSunHH")
                                                            UserDefaults.standard.set(currentMinuteStart, forKey: "timeStartSunmm")
                                                            UserDefaults.standard.set(currentHourEnd, forKey: "timeEndSunHH")
                                                            UserDefaults.standard.set(currentMinuteEnd, forKey: "timeEndSunmm")
                                                        }
                                                        let timeStartSun = selectedTimeStart.toString(withFormat: "HH:mm")
                                                        let timeEndSun = selectedTimeEnd.toString(withFormat: "HH:mm")
                                                        UserDefaults.standard.set(7, forKey: "SundaySelected")
                                                        UserDefaults.standard.set(timeStartSun, forKey: "timeStartSun")
                                                        UserDefaults.standard.set(timeEndSun, forKey: "timeEndSun")
                                                        if isOnSunday == false {
                                                            UserDefaults.standard.set("Yes", forKey: "Sunday")
                                                        }else{
                                                            UserDefaults.standard.set("No", forKey: "Sunday")
                                                        }
                                                    })
                                                Spacer()
                                            }.frame(width: widthInnerTextBorderText)
                                        }.frame(width:widthInnerTextBorderText)
                                            .offset(x: 0, y: 0)
                                    }
                                    .padding(.top, 30.0)
                                    RoundedRectangle(cornerRadius: 15, style:.continuous)
                                        .fill(Color.Cardi_Text)
                                        .frame(width: 130, height: 30)
                                        .offset(x: 0, y: -240)
                                    Text("Select Day(s)")
                                        .font(.headline)
                                        .offset(x: 0, y: -275)
                                        .frame(width:widthInnerText)
                                }
                                .padding(.bottom, 10.0)
                                Spacer()
                                Button(action: {
                                    if isOnMonday == true {
                                        DataAvailMonday()
                                    }
                                    if isOnTuesday == true {
                                        DataAvailTuesday()
                                    }
                                    if isOnWednesday == true {
                                        DataAvailWednesday()
                                    }
                                    if isOnThursday == true {
                                        DataAvailThursday()
                                    }
                                    if isOnFriday == true {
                                        DataAvailFriday()
                                    }
                                    if isOnSaturday == true {
                                        DataAvailSaturday()
                                    }
                                    if isOnSunday == true {
                                        DataAvailSunday()
                                    }
                                    navigationManager.push(.availabilityView)
                                    
                                }) {
                                    HStack {
                                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                            .font(.title2)
                                        Text("Add")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(20)
                                    .padding([.leading, .bottom, .trailing], 10)
                                }
                                .simultaneousGesture(TapGesture().onEnded{
                                })
                                .frame(width:widthInnerText, height: 20)
                            }
                        }
                    }.offset(x: 0, y: 0)
                } else {
                    ZStack(alignment: .top) {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "x.square.fill")
                                    .hamburgerMenu()
                            }
                            .id(navigationManager.lastUpdated)
                        }.frame(width:widthInnerText, height: 20)
                    }.padding(.top, 20.0)
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cardi_Text)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: 325, height: 70)
                        VStack {
                            HStack(){
                                Text("Open 24/7")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                HStack {
                                    Text(viewModel.is24_7Available ?? true ? "YES" : "NO")
                                        .foregroundColor(viewModel.is24_7Available ?? true ? .Calming_Green : .colorCardiRed)
                                        .bold()
                                        .frame(width: 60, height: 30)
                                    Toggle("", isOn: Binding<Bool>(
                                        get: { self.viewModel.is24_7Available ?? true },
                                        set: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "is247Available")
                                            ADAvailable247()
                                            self.viewModel.is24_7Available = newValue
                                        }
                                    ))
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: viewModel.is24_7Available ?? true ? .Calming_Green : .colorCardiRed))
                                    .frame(width: 60)
                                }
                                .padding()
                            }
                            .frame(width:width)
                        }
                    }.padding(.top, 20.0)
                }
            } .onAppear(perform: {
                viewModel.checkAvailability()
            })
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}
