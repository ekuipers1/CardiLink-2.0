//
//  Dashboard.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import Combine
import Alamofire
import SwiftyJSON
import MapKit
import UIKit

var timeFormat: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy"
    return formatter
}


struct Dashboard: View {
    @EnvironmentObject var base:BaseDataFetch
    
    @EnvironmentObject var def:DefriDataFetch
    @State private var hasTimeElapsed = false
    @State var date = Date()
    @State private var isShowingInfo: Bool = false
    @State private var animationAmount: CGFloat = 1
    @State private var shouldAnimate = false
    
    @State var trimValue1 : CGFloat = 0
    @State var trimValue2 : CGFloat = 0
    
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("WaitForIt") var doneWork: String!
    
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                             block: {_ in
            self.date = Date()
        })
    }
    
    func greeting() -> String {
        var greet = ""
        
        let midNight0 = Calendar.current.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        let nightEnd = Calendar.current.date(bySettingHour: 3, minute: 59, second: 59, of: date)!
        let morningStart = Calendar.current.date(bySettingHour: 4, minute: 00, second: 0, of: date)!
        let morningEnd = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: date)!
        let noonStart = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: date)!
        let noonEnd = Calendar.current.date(bySettingHour: 16, minute: 59, second: 59, of: date)!
        let eveStart = Calendar.current.date(bySettingHour: 17, minute: 00, second: 00, of: date)!
        let eveEnd = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: date)!
        let nightStart = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: date)!
        let midNight24 = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        
        if ((date >= midNight0) && (nightEnd >= date)) {
            greet = "Good Night."
        } else if ((date >= morningStart) && (morningEnd >= date)) {
            greet = "Good Morning."
        } else if ((date >= noonStart) && (noonEnd >= date)) {
            greet = "Good Afternoon."
        } else if ((date >= eveStart) && (eveEnd >= date)) {
            greet = "Good Evening."
        } else if ((date >= nightStart) && (midNight24 >= date)) {
            greet = "Good night."
        }
        return greet
    }
    
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    let places: [PlaceDefi]
    @State private var selectedPlace: PlaceDefi
    
    init(places: [PlaceDefi]) {
        
        self.places = places
        _selectedPlace = .init(initialValue: places.first!)
        
    }
    

    var body: some View {
        
        NavigationView {
            ZStack {
                
                if doneWork == "NO" {
                    
                    ZStack(){
                        
                        VStack(){
                            
                            Image("CardiLink-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.top, -40.0)
                                .frame(width: 250, height: 100)
                            
                            ZStack {
                                HeartBeat()
                                    .stroke(lineWidth: 8)
                                    .foregroundColor(Color.colorCardiGray.opacity(0.1))
                                
                                HeartBeat()
                                    .trim(from: trimValue1, to: trimValue2)
                                    .stroke(lineWidth: 12)
                                    .foregroundColor(.colorCardiRed)
                            }
                            
                            .frame(height: 300)
                            .animation(.spring())
                            .onReceive(timer, perform: { _ in
                                if trimValue2 == 0 {
                                    trimValue2 = 1
                                }
                                else if trimValue1 == 0 {
                                    trimValue1 = 1
                                } else {
                                    trimValue2 = 0
                                    trimValue1 = 0
                                }
                            })
                            
                            Text("is loading")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .padding(.top, 30.0)
                        }.padding(.top, -50.0)
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                } else {
                    
                    

                    
                    MainBackground()
                    
                    VStack(alignment: .leading) {
                        
                        
                        let modelName = UIDevice.modelName
                        
                        
                        let defaults = UserDefaults.standard
                        
                        let backend = defaults.string(forKey: "Backend")
                        
                        if backend == "NEW" {
                            
                            let _ = print(modelName)
                            
                            
                            //modelName    String    "Simulator iPhone SE"
                            
                            if modelName == "iPhone8,4" {
                                
                                VStack(){
                                    UserInfo()
                                    DefriDetail()
                                        .padding(.bottom, 5.0)
                                    DefriDash()
                                    //                        DefriDashNonMonitored()
                                    CommDash()
//                                    ServiceDash()
                                    MapDasch(place: selectedPlace, places: places)
                                    BottomMenu()
                                    //                        BottomMenu()
                                    
                                }.padding(.leading, 15.0)
                                
                            } else {
                            
                            VStack(){
                                UserInfo()
                                DefriDetail()
                                    .padding(.bottom, 5.0)
                                DefriDash()
                                //                        DefriDashNonMonitored()
                                CommDash()
//                                ServiceDash()
                                MapDasch(place: selectedPlace, places: places)
                                BottomMenu()
                                //                        BottomMenu()
                                
                            }.padding(.leading, 15.0)
                            }
                        } else {
                            VStack(){
                                UserInfo()
                                DefriDetail()
                                    .padding(.bottom, 5.0)
                                DefriDash()
                                CommDash()
                                ServiceDash()
                                MapDasch(place: selectedPlace, places: places)
                                BottomMenu()
                                
                            }.padding(.leading, 15.0)
                            
                        }
                    }
                    
                    .padding(.leading, 40)
                    //                .padding(.bottom, 220.0) //Adjsut here for fit on screens
                    .frame(width: 100, height: 100)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
        //            .onAppear { print("🔴 OnAppear") }
    }
}

struct UserInfo: View {
    @EnvironmentObject var base:BaseDataFetch
    
    @EnvironmentObject var def:DefriDataFetch
    @State private var hasTimeElapsed = false
    @State var date = Date()
    
    @AppStorage("userOwner") var userOwner: String?
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                             block: {_ in
            self.date = Date()
        })
    }
    
    func greeting() -> String {
        var greet = ""
        
        let midNight0 = Calendar.current.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        let nightEnd = Calendar.current.date(bySettingHour: 3, minute: 59, second: 59, of: date)!
        let morningStart = Calendar.current.date(bySettingHour: 4, minute: 00, second: 0, of: date)!
        let morningEnd = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: date)!
        let noonStart = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: date)!
        let noonEnd = Calendar.current.date(bySettingHour: 16, minute: 59, second: 59, of: date)!
        let eveStart = Calendar.current.date(bySettingHour: 17, minute: 00, second: 00, of: date)!
        let eveEnd = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: date)!
        let nightStart = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: date)!
        let midNight24 = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        
        if ((date >= midNight0) && (nightEnd >= date)) {
            greet = "Good Night.".localized
        } else if ((date >= morningStart) && (morningEnd >= date)) {
            greet = "Good Morning.".localized
        } else if ((date >= noonStart) && (noonEnd >= date)) {
            greet = "Good Afternoon.".localized
        } else if ((date >= eveStart) && (eveEnd >= date)) {
            greet = "Good Evening.".localized
        } else if ((date >= nightStart) && (midNight24 >= date)) {
            greet = "Good night.".localized
        }
        return greet
    }
    
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text(greeting())
                    .fontWeight(.bold)
                    .font(.title3)
                Text(userOwner ?? "...")
                    .fontWeight(.thin)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(timeString(date: date))")
                    .fontWeight(.thin)
            }
            
        }
        .padding(.leading, -180.0)
        .padding(.bottom, 10.0)
        
    }
}


//MARK: NOTIFICATION
//struct Notification: View {
//
//    @ObservedObject var fetcherForMessages = MessagesFetcher()
//    @AppStorage("NotificationDefi") var NotificationDefi: String?
//
//    var body: some View {
//
//        HStack(alignment: .bottom, spacing:15) {
//
//            Button(action: {
//                print("Floating Button Click")
//
//            }, label: {
//
//                VStack(){
//                    NavigationLink(destination: MessagesMainMenu()) {
//                        Image(systemName: "bell.badge.fill")
//                            .font(.title)
//                            .frame(width: 40.0, height: 40.0)
//                            .foregroundColor(Color.colorCardiRed)
//                            .opacity(0.5)
//                    }
//                }.simultaneousGesture(TapGesture().onEnded{
//
//                    let defaults = UserDefaults.standard
//                    defaults.set(NotificationDefi, forKey: "SelectedDefi")
//                    defaults.set("defibrillators/", forKey: "DefiComm")
//                    defaults.set("NO", forKey: "activeMap")
//                    defaults.set("YES", forKey: "messageload")
//
//
//
//
//                    //            UserDefaults.standard.set(NotificationDefi, forKey: "SelectedDefi")
//                    //            UserDefaults.standard.set("defibrillators/", forKey: "DefiComm")
//                    //            UserDefaults.standard.set("NO", forKey: "activeMap")
//                    //            UserDefaults.standard.set("YES", forKey: "messageload")
//                    //DefiGetsingleData()
//
//                })
//            })
//        }
//    }
//}

// MARK: DEFRIDETAIL
struct DefriDetail: View {
    
    @State var defiDetail: Int? = nil
    @State var exampleText: String = ""
    @State var baseUser = ""
    @State var basePass = ""
    @State var dailytest00: String = ""
    @State var dailytest01: String = ""
    @State var dailytest02: String = ""
    
    @State var action: Bool = false
    @State var isNK_Search: Bool = false
    
    let defaults = UserDefaults.standard
    
    @AppStorage("ActiveNotification") var ActiveNotification: String?
    @AppStorage("NotificationDefi") var NotificationDefi: String?
    
    var fetchsearchData = [DataGreenElementNK]()
    
    var body: some View {
        
        HStack(){
            
            ZStack(){
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .shadow(radius: 5, y: 5)
                    .frame(width: 280, height: 50)
                
                
                // MARK: SEARCH
                VStack(){
                    TextField("", text: $exampleText)
                        .modifier(PlaceholderStyle(showPlaceHolder: exampleText.isEmpty,
                                                   placeholder: "AED ID/ Description"))
                    
                        .padding(.leading, 35.0)
                        .foregroundColor(Color.colorCardiGray)
                        .frame(width: 280, height: 50)
                        .padding(.trailing)
                }
            }.padding(.leading, 20.0)
            
            
            //            if ActiveNotification == "1" {
            //
            //                //                self.exampleText = NotificationDefi
            //                Notification()
            //            }
            if self.exampleText == "" {
                
            } else {
                
                
                let defaults = UserDefaults.standard
                
                let backend = defaults.string(forKey: "Backend")
                
                if backend == "NEW" {
                    
                    
                    //                NavigationLink(destination: SearchResult()) {
                    NavigationLink(destination: NK_Search()) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                    }.simultaneousGesture(TapGesture().onEnded{
                        
                        UserDefaults.standard.set(exampleText, forKey: "searchText")
                        
                        getSearchDataGreen()
                        
                        //                                        DefiGetsingleData()
                        self.defiDetail = 1
                        UIApplication.shared.endEditing()
                        
                        
                    })
                    
                    .padding(20)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.white)
                    .background(Color.Calming_Green)
                    .cornerRadius(50)
                    
                    
                } else {
                    
                    //                NavigationLink(destination: SearchResult()) {
                    NavigationLink(destination: DefibrillatorDetailed()) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                    }.simultaneousGesture(TapGesture().onEnded{
                        
                        UserDefaults.standard.set(exampleText, forKey: "SelectedDefi")
                        
                        DefiGetsingleData()
                        
                        self.defiDetail = 1
                        UIApplication.shared.endEditing()
                        
                        
                        
                    })
                    
                    .padding(20)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.white)
                    .background(Color.Calming_Green)
                    .cornerRadius(50)
                }
                
                
            }
            
        }.padding(.trailing, 80.0)
    }
    
}

// MARK: DEFRIDASH
struct DefriDash: View {
    
    @State var selection: Int? = nil
    
    @State private var isShowingInfo: Bool = false
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    
    let defaults = UserDefaults.standard
    
    @AppStorage("Backend") var backend : String!
    @AppStorage("username") var username : String!
    @State private var newUsername = ""
    
    var body: some View {
        
        ZStack(){
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .padding(.vertical, 10.0)
                    .shadow(radius: 5, y: 5)
                    .frame(width: 400, height: 95)
                
                HStack(spacing:10){
                    
                    Image("aed")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                        .padding(.trailing, -0)
                    
                    VStack(){
                        Text("AEDs")
                            .fontWeight(.light)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(.top, 10)
                            .padding(.trailing, 220)
                        HStack(alignment: .bottom, spacing:15) {
                            
                            
                            let newoneText = backend
                            
                            switch newoneText {
                            case "NEW":
                                let greenData = base.countDashGreenNumber
                                
                                if greenData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    
                                    
                                    
                                    Button(action: {
                                        print("Floating Button Click")
                                        
                                    }, label: {
                                        NavigationLink(destination: DefibrillatorMainMenu_New()) {
                                            Text(base.countDashGreenNumber ?? "...")
                                                .fontWeight(.bold)
                                                .font(.title)
                                                .foregroundColor(Color.black)
                                                .frame(width: 80, alignment: .trailing)
                                        }
                                    })
                                }
                            case "OLD":
                                
                                let greenData = base.countGreenNumber
                                
                                if greenData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    //                                countDashRedNumber
                                    NavigationLink(destination: DefibrillatorMainMenu()) {
                                        Text(base.countGreenNumber ?? "...")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    
                                }
                                
                            default:
                                Text("-")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .opacity(0.2)
                                    .frame(width: 80, alignment: .trailing)
                            }
                            
                            //MARK: OLD
                            //                            NavigationLink(destination: DefibrillatorMainMenu()) {
                            //                                Text(base.countGreenNumber ?? "...")
                            //                                    .fontWeight(.bold)
                            //                                    .font(.title)
                            //                                    .foregroundColor(Color.black)
                            //                                    .frame(width: 80, alignment: .trailing)
                            //                            }
                            //MARK: !@
                            
                            switch newoneText {
                            case "NEW":
                                let yellowData = base.countDashYellowNumber
                                
                                if yellowData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    
                                    
                                    
                                    Button(action: {
                                        print("Floating Button Click")
                                        
                                    }, label: {
                                        NavigationLink(destination: DefibrillatorMainMenuYellowNK()) {
                                            Text(base.countDashYellowNumber ?? "...")
                                                .fontWeight(.bold)
                                                .font(.title)
                                                .foregroundColor(Color.black)
                                                .frame(width: 80, alignment: .trailing)
                                        }
                                    })
                                }
                                
                            case "OLD":
                                
                                let yellowData = base.countYellowNumber
                                
                                if yellowData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    //                                countDashRedNumber
                                    NavigationLink(destination: DefibrillatorMainMenuYellow()) {
                                        Text(base.countYellowNumber ?? "...")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    
                                }
                                //
                                //
                                //
                                //
                                //                                Button(action: {
                                //                                    print("Floating Button Click")
                                //                                }, label: {
                                //
                                //                                    NavigationLink(destination: DefibrillatorMainMenuYellow()) {
                                //                                        Text(base.countYellowNumber ?? "...")
                                //                                            .fontWeight(.bold)
                                //                                            .font(.title)
                                //                                            .foregroundColor(Color.black)
                                //                                            .frame(width: 80, alignment: .trailing)
                                //                                    }//
                                //                                    .simultaneousGesture(TapGesture().onEnded{
                                //
                                //                                        if backend == "NEW" {
                                //
                                //                                            print("Backend: ", backend!)
                                //                                            print("YASSSS")
                                //
                                //                                        } else {
                                //
                                //                                        }
                                //
                                //                                    })
                                //                                })
                            default:
                                Text("-")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .opacity(0.2)
                                    .frame(width: 80, alignment: .trailing)
                            }
                            
                            switch newoneText {
                            case "NEW":
                                
                                
                                let redData = base.countDashRedNumber
                                
                                if redData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    
                                    
                                    
                                    Button(action: {
                                        print("Floating Button Click")
                                        
                                    }, label: {
                                        NavigationLink(destination: DefibrillatorMainMenuRedNK()) {
                                            Text(base.countDashRedNumber ?? "...")
                                                .fontWeight(.bold)
                                                .font(.title)
                                                .foregroundColor(Color.black)
                                                .frame(width: 80, alignment: .trailing)
                                        }
                                    })
                                }
                                
                            case "OLD":
                                
                                let redData = base.countRedNumber
                                
                                if redData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    //                                countDashRedNumber
                                    NavigationLink(destination: DefibrillatorMainMenuRed()) {
                                        Text(base.countRedNumber ?? "...")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    
                                }
                                
                            default:
                                Text("-")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .opacity(0.2)
                                    .frame(width: 80, alignment: .trailing)
                            }
                            
                            
                        }
                        
                        .padding(.trailing, 10)
                        
                        HStack(alignment: .top, spacing:15) {
                            
                            let newoneText = backend
                            
                            switch newoneText {
                            case "NEW":
                                
                                let greenData = base.countDashGreenNumber
                                
                                if greenData == "0" {
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                } else {
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .frame(width: 80, height: 4)
                                }
                                
                            case "OLD":
                                
                                let greenData = base.countGreenNumber
                                
                                if greenData == "0" {
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                } else {
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .frame(width: 80, height: 4)
                                }
                                
                            default:
                                Rectangle()
                                    .fill(Color.Calming_Green)
                                    .frame(width: 80, height: 4)
                            }
                            
                            switch newoneText {
                            case "NEW":
                                
                                let yellowData = base.countDashYellowNumber
                                
                                if yellowData == "0" {
                                    Rectangle()
                                        .fill(Color.Cardi_Yellow)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                }else {
                                    Rectangle()
                                        .fill(Color.Cardi_Yellow)
                                        .frame(width: 80, height: 4)
                                }
                            case "OLD":
                                let yellowData = base.countYellowNumber
                                if yellowData == "0" {
                                    Rectangle()
                                        .fill(Color.Cardi_Yellow)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                }else {
                                    Rectangle()
                                        .fill(Color.Cardi_Yellow)
                                        .frame(width: 80, height: 4)
                                }
                                
                            default:
                                Rectangle()
                                    .fill(Color.Cardi_Yellow)
                                    .frame(width: 80, height: 4)
                            }
                            
                            
                            
                            switch newoneText {
                            case "NEW":
                                
                                let redData = base.countDashRedNumber
                                if redData == "0" {
                                    
                                    Rectangle()
                                        .fill(Color.colorCardiRed)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                } else {
                                    
                                    Rectangle()
                                        .fill(Color.colorCardiRed)
                                        .frame(width: 80, height: 4)
                                }
                            case "OLD":
                                let redData = base.countRedNumber
                                if redData == "0" {
                                    
                                    Rectangle()
                                        .fill(Color.colorCardiRed)
                                        .opacity(0.2)
                                        .frame(width: 80, height: 4)
                                } else {
                                    
                                    Rectangle()
                                        .fill(Color.colorCardiRed)
                                        .frame(width: 80, height: 4)
                                }
                            default:
                                Rectangle()
                                    .fill(Color.colorCardiRed)
                                    .frame(width: 80, height: 4)
                            }
                        }
                        .padding(.trailing, 0)
                        .padding(.top, -15.0)
                        
                        
                    }.padding(.trailing, 30)
                }
                
            }
        }
    }
}


// MARK: DEFRIDASH
struct DefriDashNonMonitored: View {
    
    @State var selection: Int? = nil
    
    @State private var isShowingInfo: Bool = false
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    
    let defaults = UserDefaults.standard
    
    @AppStorage("Backend") var backend : String!
    @AppStorage("username") var username : String!
    @State private var newUsername = ""
    
    var body: some View {
        
        ZStack(){
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .padding(.vertical, 10.0)
                    .shadow(radius: 5, y: 5)
                    .frame(width: 400, height: 95)
                
                HStack(spacing:10){
                    
                    Image("aed")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                        .padding(.trailing, -0)
                    
                    VStack(){
                        Text("Non-monitored Defibrillators")
                            .fontWeight(.light)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(.top, 10)
                            .padding(.trailing, 160)
                        HStack(alignment: .bottom, spacing:15) {
                            
                            
                            //                            let newoneText = backend
                            
                            
                            let greenData = base.countDashGreenNumber
                            
                            if greenData == "0" {
                                Text("-")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .opacity(0.2)
                                    .frame(width: 80, alignment: .trailing)
                                
                            } else {
                                
                                
                                
                                Button(action: {
                                    print("Floating Button Click")
                                    
                                }, label: {
                                    NavigationLink(destination: DefibrillatorMainMenu_New()) {
                                        Text(base.countDashGreenNumber ?? "...")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}



// MARK: COMMDASH
struct CommDash: View {
    @State var selection: Int? = nil
    @AppStorage("Backend") var backend : String!
    @State private var isShowingInfo: Bool = false
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    let defaults = UserDefaults.standard
    var body: some View {
        
        ZStack(){
            
            let newoneText = backend
            
            switch newoneText {
            case "NEW":
                Button(action: {
                    print("Floating Button Click")
                    
                    
                }, label: {
                    NavigationLink(destination: CommMainMenu_New()) {
                        
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.white)
                                .padding(.vertical, 10.0)
                                .shadow(radius: 5, y: 5)
                                .frame(width: 400, height: 95)
                            
                            HStack(spacing:10){
                                
                                Image("Comms")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                                    .padding(.trailing, -0)
                                
                                VStack(){
                                    Text("Heart Connects")
                                        .fontWeight(.light)
                                        .font(.title2)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 10)
                                        .padding(.trailing, 130) //40
                                    HStack(alignment: .bottom, spacing:15) {
                                        Text("Connected")
                                            .fontWeight(.thin)
                                            .font(.title2)
                                            .foregroundColor(Color.black)
                                            .frame(width: 160, alignment: .leading)
                                            .padding(.trailing, 12)
                                        //                                    .padding(.leading, 8)
                                        
                                        if base.getit2 == "" {
                                            
                                            Text(base.getit2 ?? "Loading")
                                                .fontWeight(.thin)
                                                .font(.title)
                                                .foregroundColor(Color.black)
                                                .frame(width: 80, alignment: .trailing)
                                            
                                        } else {
                                            
                                            
                                            Text(base.getit2 ?? "...")
                                            //                                            .fontWeight(.thin)
                                                .fontWeight(.bold)
                                                .font(.title)
                                                .foregroundColor(Color.black)
                                                .frame(width: 80, alignment: .trailing)
                                        }
                                    }
                                    
                                    .padding(.trailing, 10)
                                    HStack(alignment: .top, spacing:15) {
                                        Rectangle()
                                            .fill(Color.Calming_Green)
                                            .frame(width: 80, height: 4)
                                        
                                    }
                                    .padding(.leading, 190)
                                    .padding(.top, -15.0)
                                    
                                    
                                }.padding(.trailing, 30)
                            }
                            
                        }
                        
                    }//
                    .simultaneousGesture(TapGesture().onEnded{
                        if backend == "NEW" {
                            
                            print("Backend: ", backend!)
                            getCommBaseDataList()
                            
                        } else {
                        }
                        
                    })
                })
            case "OLD":
                Button(action: {
                    print("Floating Button Click")
                    
                    
                }, label: {
                    NavigationLink(destination: CommMainMenu()) {
                        ZStack(){
                            
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.white)
                                .padding(.vertical, 10.0)
                                .shadow(radius: 5, y: 5)
                                .frame(width: 400, height: 95)
                            
                            HStack(spacing:10){
                                
                                Image("Comms")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                                    .padding(.trailing, -0)
                                
                                VStack(){
                                    Text("Heart Connects")
                                        .fontWeight(.light)
                                        .font(.title2)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 10)
                                        .padding(.trailing, 130) //40
                                    HStack(alignment: .bottom, spacing:15) {
                                        Text("Connected")
                                            .fontWeight(.thin)
                                            .font(.title2)
                                            .foregroundColor(Color.black)
                                            .frame(width: 160, alignment: .leading)
                                            .padding(.trailing, 12)
                                        //                                    .padding(.leading, 8)
                                        Text(base.getit2 ?? "...")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    
                                    .padding(.trailing, 10)
                                    
                                    HStack(alignment: .top, spacing:15) {
                                        Rectangle()
                                            .fill(Color.Calming_Green)
                                            .frame(width: 80, height: 4)
                                        
                                    }
                                    .padding(.leading, 190)
                                    .padding(.top, -15.0)
                                    
                                    
                                }.padding(.trailing, 30)
                            }
                            
                        }
                    }//
                    .simultaneousGesture(TapGesture().onEnded{
                        
                        
                        if backend == "NEW" {
                            
                            print("Backend: ", backend!)
                            print("YASSSS")
                            //                                    NKDefriDataFetch()
                            //                                    DefiListFetcherNew()
                            getCommBaseDataList()
                            
                        } else {
                        }
                        
                    })
                })
            default:
                messMainInfo()
            }
            
            //            NavigationLink(destination: CommMainMenu(), tag: 1, selection: $selection) {
            
            //                ZStack(){
            //
            //                    RoundedRectangle(cornerRadius: 25, style: .continuous)
            //                        .fill(Color.white)
            //                        .padding(.vertical, 10.0)
            //                        .shadow(radius: 5, y: 5)
            //                        .frame(width: 400, height: 95)
            //
            //                    HStack(spacing:10){
            //
            //                        Image("Comms")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(width: 40,
            //                                   height: 40)
            //                            .padding(.trailing, -0)
            //
            //                        VStack(){
            //                            Text("Heart Connects")
            //                                .fontWeight(.light)
            //                                .font(.title2)
            //                                .foregroundColor(Color.black)
            //                                .padding(.top, 10)
            //                                .padding(.trailing, 130) //40
            //                            HStack(alignment: .bottom, spacing:15) {
            //                                Text("Connected")
            //                                    .fontWeight(.thin)
            //                                    .font(.title2)
            //                                    .foregroundColor(Color.black)
            //                                    .frame(width: 160, alignment: .leading)
            //                                    .padding(.trailing, 12)
            //                                //                                    .padding(.leading, 8)
            //                                Text(base.getit2 ?? "...")
            //                                    .fontWeight(.bold)
            //                                    .font(.title)
            //                                    .foregroundColor(Color.black)
            //                                    .frame(width: 80, alignment: .trailing)
            //                            }
            //
            //                            .padding(.trailing, 10)
            //
            //                            HStack(alignment: .top, spacing:15) {
            //                                Rectangle()
            //                                    .fill(Color.Calming_Green)
            //                                    .frame(width: 80, height: 4)
            //
            //                            }
            //                            .padding(.leading, 190)
            //                            .padding(.top, -5.0)
            //
            //
            //                        }.padding(.trailing, 30)
            //                    }
            //
            //                }
            //            }
        }
    }
}


// MARK: SERVICEDASH
struct ServiceDash: View {
    @State var selection: Int? = nil
    @State private var isShowingInfo: Bool = false
    @AppStorage("Backend") var backend : String!
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack(){
            
            
            let defaults = UserDefaults.standard
            
            let backend = defaults.string(forKey: "Backend")
            
            if backend == "NEW" {
                
                NavigationLink(destination: ServiceTicketsMainMenuNK(), tag: 1, selection: $selection) {
                
                
                ZStack(){
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .padding(.vertical, 10.0)
                        .shadow(radius: 5, y: 5)
                        .frame(width: 400, height: 95)
                    
                    HStack(spacing:10){
                        
                        
                        let ticketsData = base.countDashServiceTicketNumber
//                        let _ = print("!@#$%^&*", ticketsData)
                        if ticketsData == "0" {
                            
                            Image("bell")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.2)
                                .frame(width: 40,
                                       height: 40)
                                .padding(.trailing, -0)
                        }else {
                            
                            Image("bell")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40,
                                       height: 40)
                                .padding(.trailing, -0)
                        }
                        
                        VStack(){
                            
                            if ticketsData == "0" {
                                Text("Service Tickets")
                                    .fontWeight(.light)
                                    .font(.title2)
                                    .opacity(0.2)
                                    .foregroundColor(Color.black)
                                    .padding(.top, 10)
                                    .padding(.trailing, 135)
                            } else {
                                
                                Text("Service Tickets")
                                    .fontWeight(.light)
                                    .font(.title2)
                                    .foregroundColor(Color.black)
                                    .padding(.top, 10)
                                    .padding(.trailing, 135)
                            }
                            
                            
                            HStack(alignment: .bottom, spacing:15) {
                                
                                if ticketsData == "0" {
                                    
                                    Text("None Open")
                                        .fontWeight(.thin)
                                        .font(.title2)
                                        .opacity(0.2)
                                        .foregroundColor(Color.black)
                                        .frame(width: 160, alignment: .leading)
                                        .padding(.trailing, 10)
                                } else {
                                    Text("Current open")
                                        .fontWeight(.thin)
                                        .font(.title2)
                                        .foregroundColor(Color.black)
                                        .frame(width: 160, alignment: .leading)
                                        .padding(.trailing, 10)
                                }
                                //                                switch newoneText {
                                //                                case "NEW":
                                let ticketsData = base.countDashServiceTicketNumber
                                
                                if ticketsData == "0" {
                                    Text("-")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .opacity(0.2)
                                        .frame(width: 80, alignment: .trailing)
                                    
                                } else {
                                    
                                    Text(base.countDashServiceTicketNumber ?? "0")
                                    
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .foregroundColor(Color.black)
                                        .frame(width: 80, alignment: .trailing)
                                }
                                
                            }
                            
                            .padding(.trailing, 10)
                            
                            HStack(alignment: .top, spacing:15) {
                                
                                let ticketsData = base.countDashServiceTicketNumber
                                if ticketsData == "0" {
                                    
                                    
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .frame(width: 80, height: 4)
                                        .opacity(0.2)
                                } else {
                                    Rectangle()
                                        .fill(Color.Calming_Green)
                                        .frame(width: 80, height: 4)
                                }
                                
                            }
                            .padding(.leading, 190)
                            .padding(.top, -15.0)
                            
                            
                        }.padding(.trailing, 30)
                    }
                    
                }
                }
            } else {
                NavigationLink(destination: ServiceTicketsMainMenu(), tag: 1, selection: $selection) {
                    
                    
                    ZStack(){
                        
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color.white)
                            .padding(.vertical, 10.0)
                            .shadow(radius: 5, y: 5)
                            .frame(width: 400, height: 95)
                        
                        HStack(spacing:10){
                            
                            let ticketsData = base.getitService
                            
                            if ticketsData == "0" {
                                
                                Image("bell")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.2)
                                    .frame(width: 40,
                                           height: 40)
                                    .padding(.trailing, -0)
                            }else {
                                
                                Image("bell")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                                    .padding(.trailing, -0)
                            }
                            
                            VStack(){
                                
                                if ticketsData == "0" {
                                    Text("Service Tickets")
                                        .fontWeight(.light)
                                        .font(.title2)
                                        .opacity(0.2)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 10)
                                        .padding(.trailing, 135)
                                } else {
                                    
                                    Text("Service Tickets")
                                        .fontWeight(.light)
                                        .font(.title2)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 10)
                                        .padding(.trailing, 135)
                                }
                                
                                
                                HStack(alignment: .bottom, spacing:15) {
                                    
                                    if ticketsData == "0" {
                                        
                                        Text("Unavailable")
                                            .fontWeight(.thin)
                                            .font(.title2)
                                            .opacity(0.2)
                                            .foregroundColor(Color.black)
                                            .frame(width: 160, alignment: .leading)
                                            .padding(.trailing, 10)
                                    } else {
                                        Text("Current open")
                                            .fontWeight(.thin)
                                            .font(.title2)
                                            .foregroundColor(Color.black)
                                            .frame(width: 160, alignment: .leading)
                                            .padding(.trailing, 10)
                                    }
                                    //                                switch newoneText {
                                    //                                case "NEW":
                                    let ticketsData = base.getitService
                                    
                                    if ticketsData == "0" {
                                        Text("-")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.gray)
                                            .opacity(0.2)
                                            .frame(width: 80, alignment: .trailing)
                                        
                                    } else {
                                        
                                        Text(base.getitService ?? "0")
                                        
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .frame(width: 80, alignment: .trailing)
                                    }
                                    
                                }
                                
                                .padding(.trailing, 10)
                                
                                HStack(alignment: .top, spacing:15) {
                                    
                                    let ticketsData = base.getitService
                                    if ticketsData == "0" {
                                        
                                        
                                        Rectangle()
                                            .fill(Color.Calming_Green)
                                            .frame(width: 80, height: 4)
                                            .opacity(0.2)
                                    } else {
                                        Rectangle()
                                            .fill(Color.Calming_Green)
                                            .frame(width: 80, height: 4)
                                    }
                                    
                                }
                                .padding(.leading, 190)
                                .padding(.top, -15.0)
                                
                                
                            }.padding(.trailing, 30)
                        }
                        
                    }
                    
                }
            } //NAVIGATION
        }.simultaneousGesture(TapGesture().onEnded{
            defaults.set("YES", forKey: "callServiceTickets")
        })
        
        
    }
    
}

// MARK: MAPDASH
struct AEDmapInfo: Identifiable {
    var id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapDasch: View {
    @EnvironmentObject var base:BaseDataFetch
    //    @EnvironmentObject var def:DefriDataFetch
    //    @AppStorage("latLocation") var latLocation: Double?
    //    @AppStorage("lonLocation") var lonLocation: Double?
    
    //    @State var coordinateRegion = MKCoordinateRegion(
    //        center: CLLocationCoordinate2D(latitude: 49.6008746284397, longitude: 10.15136718750469 ),
    //        span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.2))
    
    
    let place: PlaceDefi
    let places: [PlaceDefi]
    
    
    var body: some View {
        
        ZStack(){
            
            NavigationLink(destination: MapView2(location: place, places: places)) {
                
                ZStack(){
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .padding(.vertical, 10.0)
                        .shadow(radius: 5, y: 5)
                        .frame(width: 400, height: 95)
                    
                    
                    HStack(spacing:10){
                        
                        Image(systemName: "map")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35,
                                   height: 35)
                            .padding(.trailing, -0)
                            .foregroundColor(Color.black)
                        
                        VStack(){
                            Text("AEDs with")
                                .fontWeight(.light)
                                .font(.title2)
                                .foregroundColor(Color.black)
                                .padding(.top, 10)
                                .padding(.trailing, 180)
//                                .padding(.trailing, 110)
                            HStack(alignment: .bottom, spacing:15) {
                                Text("GPS available")
                                    .fontWeight(.thin)
                                    .font(.title2)
                                    .foregroundColor(Color.black)
                                    .frame(width: 180, alignment: .leading)
                                    .padding(.trailing, -11)
                                Text(base.countGeoNumber ?? "...")
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .frame(width: 80, alignment: .trailing)
                            }
                            
                            .padding(.trailing, 10)
                            HStack(alignment: .top, spacing:15) {
                                Rectangle()
                                    .fill(Color.Calming_Green)
                                    .frame(width: 80, height: 4)
                                
                            }
                            .padding(.leading, 190)
                            .padding(.top, -15.0)
                            
                            
                        }.padding(.trailing, 30)
                    }
                }
                //                .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous)
                //                                                    .fill(Color.gray)
                //                                                    .opacity(0.7)
                //                                                    .padding(.vertical, 10.0)
                //                                                    .shadow(radius: 5, y: 5)
                //                                                    .frame(width: 400, height: 95))
            }.simultaneousGesture(TapGesture().onEnded{
            })
        } //.padding(.bottom, 10.0)
    }
}

// MARK: TOPMENU

struct TopMenu: View {
    
    @State private var slideUp = false
    @State private var info = false
    @State private var infoHide = false
    @State private var infoRotate = false
    
    var body: some View {
        
        ZStack(alignment: .top){
            
            Curved_Shape(yOffset: 0.7)
                .fill(Color.colorCardiOrange)
                .frame(height: 120.0)
                .shadow(radius: 5, y: 5)
            
            Curved_Shape(yOffset: 0.5)
                .fill(Color.colorCardiOrange)
                .shadow(radius: 5, y: 5)
                .scaleEffect(x: -1, y: 1)
                .frame(height:200.0)
                .offset(y: self.slideUp ? 0 : -100)
            
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 0.4)) {
                    self.slideUp.toggle()
                    self.info.toggle()
                    self.infoRotate.toggle()
                    
                }
            }) {
                Image(systemName: "chevron.up.circle")
                    .font(Font.system(size: 40))
                    .foregroundColor(Color.black)
                    .rotationEffect(.degrees(self.infoRotate ? 180 : 0))
                    .position(self.info ? CGPoint(x: 320, y: 195) : CGPoint(x: 320, y: 95))
            }
            
            // MARK: Swith to see info
            .offset(y: self.slideUp ? 0 : 0)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let places = MapDirectory().places
        Dashboard(places: places)
    }
}

extension String {
    
    //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
}

func clearCache(){
    let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    let fileManager = FileManager.default
    do {
        // Get the directory contents urls (including subfolders urls)
        let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
        for file in directoryContents {
            do {
                try fileManager.removeItem(at: file)
                debugPrint("ALL GOOD")
            }
            catch let error as NSError {
                debugPrint("Ooops! Something went wrong: \(error)")
            }
            
        }
    } catch let error as NSError {
        debugPrint("Ooops! Something went wrong: \(error)")
        print(error.localizedDescription)
    }
}

func clearGeo() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("latlon.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearGreen()
    } catch {
        clearGreen()
        //        clearCache()
        return
    }
}

func clearGreen() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("greenData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearRed()
    } catch {
        clearRed()
        //        clearCache()
        return
    }
}

func clearRed() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("redData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearYellow()
        //        NKclearGreen()
    } catch {
        clearYellow()
        //        NKclearGreen()
        //        clearCache()
        return
    }
}

func clearYellow() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("yellowData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearGreen()
    } catch {
        NKclearGreen()
        //        clearCache()
        return
    }
}

func NKclearGreen() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKgreenData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearYellow()
        //        DataDefiNK()
    } catch {
        NKclearYellow()
        //        DataDefiNK()
        //        clearCache()
        return
    }
}

func NKclearYellow() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKyellowData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearRed()
    } catch {
        NKclearRed()
        //        clearCache()
        return
    }
}

func NKclearRed() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKredData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataDefiNK()
    } catch {
        DataDefiNK()
        //        clearCache()
        return
    }
}

func DataDefiNK() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataDefiNKOver()
    } catch {
        DataDefiNKOver()
        //        clearCache()
        return
    }
}

func DataDefiNKOver() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataCommNK()
    } catch {
        DataCommNK()
        //        clearCache()
        return
    }
}

func DataCommNK() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearCommData()
    } catch {
        NKclearCommData()
        //        clearCache()
        return
    }
}

func NKclearCommData() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        //        clearSearchGreen()
        NKclearServiceData()
    } catch {
        NKclearServiceData()
        //        clearSearchGreen()
        //        clearCache()
        return
    }
}

func NKclearServiceData() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        //        clearSearchGreen()
        clearService()
    } catch {
        clearService()
        //        clearSearchGreen()
        //        clearCache()
        return
    }
}



func clearService() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("service.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchGreen()
    } catch {
        clearSearchGreen()
        return
    }
}


func clearSearchGreen() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataGreen.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchYellow()
    } catch {
        clearSearchYellow()
        return
    }
}

func clearSearchYellow() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataYellow.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchRed()
    } catch {
        clearSearchRed()
        return
    }
}

func clearSearchRed() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataRed.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchGray()
    } catch {
        clearSearchGray()
        return
    }
}

func clearSearchGray() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataGray.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSelfTest()
    } catch {
        clearSelfTest()
        return
    }
}


func clearSelfTest() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearCache()
    } catch {
        //        clearRed()
        //                clearCache()
        return
    }
}


func clearAllFile() {
    
    let fileManager = FileManager.default
    
    let filenameService = getDocumentsDiretory().appendingPathComponent("service.json")
    let filenameRed = getDocumentsDiretory().appendingPathComponent("redData.json")
    let filenameYellow = getDocumentsDiretory().appendingPathComponent("yellowData.json")
    let filenameGreen = getDocumentsDiretory().appendingPathComponent("greenData.json")
    let filenameGreenNK = getDocumentsDiretory().appendingPathComponent("NKgreenData.json")
    let filenameGeo = getDocumentsDiretory().appendingPathComponent("latlon.json")
    let filenameCommNK = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
    let filenameSelfTestNK = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    let filenameYellowNK = getDocumentsDiretory().appendingPathComponent("NKyellowData.json")
    let filenameRedNK = getDocumentsDiretory().appendingPathComponent("NKredData.json")
    let filenameDataDefiNK = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
    let filenameDataDefiNKOver = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
    let filenameDataCommNK = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
    let filenameSearchGreen = getDocumentsDiretory().appendingPathComponent("NKSearchDataGreen.json")
    let filenameSearchYellow = getDocumentsDiretory().appendingPathComponent("NKSearchDataYellow.json")
    let filenameSearchRed = getDocumentsDiretory().appendingPathComponent("NKSearchDataRed.json")
    let filenameSearchGray = getDocumentsDiretory().appendingPathComponent("NKSearchDataGray.json")
    let filenameServiceDataNK = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
    
    
    do {
        try fileManager.removeItem(at: filenameService)
        try fileManager.removeItem(at: filenameRed)
        try fileManager.removeItem(at: filenameRedNK)
        try fileManager.removeItem(at: filenameYellow)
        try fileManager.removeItem(at: filenameYellowNK)
        try fileManager.removeItem(at: filenameGreen)
        try fileManager.removeItem(at: filenameGreenNK)
        try fileManager.removeItem(at: filenameCommNK)
        try fileManager.removeItem(at: filenameGeo)
        try fileManager.removeItem(at: filenameSelfTestNK)
        try fileManager.removeItem(at: filenameDataDefiNK)
        try fileManager.removeItem(at: filenameDataDefiNKOver)
        try fileManager.removeItem(at: filenameDataCommNK)
        try fileManager.removeItem(at: filenameSearchGreen)
        try fileManager.removeItem(at: filenameSearchYellow)
        try fileManager.removeItem(at: filenameSearchRed)
        try fileManager.removeItem(at: filenameSearchGray)
        try fileManager.removeItem(at: filenameServiceDataNK)
        
        
    } catch {
        //        clearGreen()
        clearGeo()
        return
    }
    
}

struct BottomMenu: View {
    
    @State var selection: Int? = nil
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    //    let place: PlaceDefi
    //    let places: [PlaceDefi]
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack(){
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: 400, height: 65)
            
            
            
            VStack(){
                HStack(spacing: 0){
                    Button(action: {
                        
                        defaults.set("NO", forKey: "callServiceTickets")
                        defaults.set("", forKey: "Backend")
                        defaults.set("Nop", forKey: "ShowForgotPassword")
                        defaults.set("", forKey: "searchText")
                        
                        //
                        self.base.logout()
                        clearAllFile()
                        print("Logout tapped!")
                        
                    }) {
                        HStack {
                            
                            Image(systemName: "escape")
                                .font(.title2)
                            Text("Logout")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .foregroundColor(Color.colorCardiRed)
                        
                    }
                    .padding(.trailing, 55.0)
                    
                    //                                                        NavigationLink(destination: MapView2(location: place, places: places)) {
                    //                                                            HStack {
                    //                                                                Image(systemName: "globe")
                    //                                                                    .font(.title2)
                    //                                                            }
                    //                                                            .padding()
                    //                                                            .foregroundColor(Color.Cardi_MapBlue)
                    //
                    //                                                        }
                    //
                    //                                                        .simultaneousGesture(TapGesture().onEnded{
                    //
                    ////                                                            getUserData()
                    //                                                        })
                    
//                    NavigationLink(destination: DefibrillatorDetailed()) {
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: "wallet.pass")
                                .font(.title2)
                            Text("About")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            
                        }
                        .padding()
                        .foregroundColor(Color.colorCardiOrange)
                        
                    }
                    .padding(.trailing, 55.0)
                    
                    .simultaneousGesture(TapGesture().onEnded{
                        
                        getUserData()
                    })
                }
            }
        }
    }
}


