//
//  Dashboard2.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.09.23.
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
    @State private var hasTimeElapsed = false
    @State var date = Date()
    @State private var isShowingInfo: Bool = false
    @State private var animationAmount: CGFloat = 1
    @State private var shouldAnimate = false
    @State var trimValue1 : CGFloat = 0
    @State var trimValue2 : CGFloat = 0
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("WaitForIt") var doneWork: String!
    @AppStorage("OnePortal") var onePortal: Bool?
    @State private var defibrillators: [DefibrillatorMap] = []
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) var presentationMode
    @State private var showDetails = false
    @State private var selectedMapType: String = "Standard"
    @State private var isSheetPresented = false
    
    var body: some View {
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
                    VStack(){
                        Spacer()
                        UserInfoNew()
                            .padding(.bottom, 55.0)
                        DefriDetail()
                            .padding(.bottom, 55.0)
                            .padding(.leading, 40)
                        MapViewDashboard()
                            .frame(width: widthInner)
                            .padding(.leading, -5)
                            .padding(.bottom, 25.0)
                        Spacer()
                    }.padding(.leading, 5.0)
                }
                BottomNavigationBar()
                    .offset(y: UIScreen.main.bounds.height/2 - 70/2)
                    .padding(.top, 30.0)
                    .padding(.bottom, 10.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct BottomNavigationBar: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isSheetPresented = false
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    UserDefaults.standard.set("Unknown AED", forKey: "defridetailOwner")
                    UserDefaults.standard.set("Please try again", forKey: "defridetailID")
                    UserDefaults.standard.set("Make sure you have Internet connection" ,forKey: "defridetailDescription")
                    UserDefaults.standard.set("", forKey: "defridetailStatusValue")
                    UserDefaults.standard.set("", forKey: "defridetailAdminStatusValue")
                    UserDefaults.standard.set("", forKey: "defridetailpairingDate")
                    UserDefaults.standard.set("", forKey: "defridetailpairingID")
                    UserDefaults.standard.set("", forKey: "OVERVIEWCOMMID")
                    UserDefaults.standard.set("", forKey: "commdetailID")
                    UserDefaults.standard.set("", forKey: "savedSearchText")
                    GetData()
                    navigationManager.navigateTo(.dashboard)
                }) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color.Cardi_Text_Inf)
                }
                .frame(maxWidth: .infinity)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "savedSearchText")
                    navigationManager.navigateTo(.aedsearch)
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 30))
                        .foregroundStyle(Color.Cardi_Text_Inf)
                }
                .frame(maxWidth: .infinity)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "savedSearchText")
                    navigationManager.navigateTo(.adIntro)
                }) {
                    ZStack {
                        Image(systemName: "bolt.heart.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.Cardi_Text_Inf)
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.Calming_Green)
                            .offset(x: 5, y: -15)
                    }
                }
                .frame(maxWidth: .infinity)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "savedSearchText")
                    withAnimation {
                        isSheetPresented.toggle()
                    }
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 30))
                        .foregroundStyle(Color.Cardi_Text_Inf)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .frame(width: widthList)
            .padding(.bottom, 25.0)
            .padding()
            
            if isSheetPresented {
                HalfPageSheetView(isPresented: $isSheetPresented)
                    .offset(x: UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height/25 - (UIScreen.main.bounds.height/1.4)/2)
                    .transition(bottomTransition) // Use the custom bottom transition
            }
        }
    }
    
    var bottomTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct UserInfoNew: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var hasTimeElapsed = false
    @State var date = Date()
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("myPortal") var myPortal: String?
    @AppStorage("DemoProd") var demoProd: String?
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                             block: {_ in
            self.date = Date()
        })
    }
    
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
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
            Spacer()
            
        }.frame(width:widthInner, height: 50)
    }
}

struct HalfPageSheetView: View {
    @Binding var isPresented: Bool
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("OnePortal") var onePortal: Bool?
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        HStack() {
            VStack {
                if onePortal == true {
                    Button(action: {
                        isPresented = false
                        navigationManager.navigateTo(.userinfoview)
                    }) {
                        HStack() {
                            Spacer()
                                .font(.title3)
                            Text(userOwner ?? "Unknown")
                                .fontWeight(.thin)
                                .font(.headline)
                                .lineLimit(1)
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 30))
                        }  .foregroundStyle(Color.Cardi_Text_Inf)
                            .padding(.trailing, 20.0)
                    }
                    .padding(.top, 20.0)
                    .frame(width: 260)
                    .padding(.bottom)
                } else {
                    VStack(alignment: .leading) {
                        Button(action: {
                            isPresented = false
                            navigationManager.navigateTo(.portalSelect)
                            clearAllFile()
                        }) {
                            HStack() {
                                Image(systemName: "rectangle.2.swap")
                                    .font(.system(size: 30))
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 20.0)
                                if let savedURLString = UserDefaults.standard.string(forKey: "imageLogoUrlKey"),
                                   let savedURL = URL(string: savedURLString) {
                                    AsyncImage(url: savedURL) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 50)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                } else {
                                }
                                Spacer()
                            }
                        }
                        .frame(width: 260)
                        .padding(.top, 20.0)
                    }
                    Button(action: {
                        isPresented = false
                        navigationManager.navigateTo(.userinfoview)
                    }) {
                        HStack() {
                            Spacer()
                                .font(.title3)
                            Text(userOwner ?? "Unknown")
                                .fontWeight(.regular)
                                .font(.headline)
                                .lineLimit(1)
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 30))
                        }  .foregroundStyle(Color.black)
                            .padding(.trailing, 20.0)
                    }
                    .padding(.top, 20.0)
                    .frame(width: 260)
                    .padding(.bottom)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Button(action: {
                        isPresented = false
                        navigationManager.navigateTo(.settingsview)
                    }) {
                        HStack() {
                            Image(systemName: "gear")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black)
                                .padding(.leading, 20.0)
                            Text("Settings")
                            Spacer()
                        }
                    }
                    .frame(width: 240)
                    .padding(.bottom, 10.0)
                    .foregroundStyle(Color.black)
                    Button(action: {
                        isPresented = false
                        navigationManager.navigateTo(.about)
                    }) {
                        HStack() {
                            Image(systemName: "list.bullet.clipboard")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black)
                                .padding(.leading, 25.0)
                            Text("About")
                            Spacer()
                        }
                    }
                    .foregroundStyle(Color.black)
                    .frame(width: 240)
                    .padding(.bottom, 10.0)
                    Button(action: {
                        isPresented = false
                        navigationManager.navigateTo(.login)
                        clearAllFile()
                    }) {
                        HStack() {
                            Image(systemName: "escape")
                                .font(.system(size: 30))
                                .padding(.leading, 20.0)
                                .foregroundColor(Color.colorCardiRed)
                            Text("Logout")
                                .fontWeight(.bold)
                                .font(.headline)
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                    }
                    .foregroundStyle(Color.Cardi_Text_Inf)
                    .frame(width: 240)
                    .padding(.bottom)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.height / 2)
        .background(Color.Cadi_Select)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

struct DefriDetail: View{
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var base:BaseDataFetch
    @State var selection: Int? = nil
    @State private var isShowingInfo: Bool = false
    @EnvironmentObject var def:DefriDataFetch
    let defaults = UserDefaults.standard
    @AppStorage("Backend") var backend : String!
    @AppStorage("username") var username : String!
    @AppStorage("green") var greencounter : String  = "5"
    @AppStorage("yellow") var yellowcounter : String = "5"
    @AppStorage("red") var redcounter : String = "5"
    @AppStorage("gray") var grayCount : String = "5"
    @AppStorage("blue") var blueCount : String = "5"
    @AppStorage("RedTimeout") var redcounterTimeout : Int!
    @AppStorage("RedError") var redcounterError : Int!
    @AppStorage("YellowCountWarning") var yellowCountWarning : Int!
    @AppStorage("YellowCountOverdue") var yellowCountoverdue : Int!
    
    var body: some View {
        ZStack(){
            VStack {
                HStack(){
                    Text("AEDs")
                        .fontWeight(.light)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .offset(x: 10, y: -30)
                    Spacer()
                }.frame(width: 340, height: 50)
                    .padding(.bottom, 20)
            }
            HStack() {
                ZStack(alignment: .bottom) {
                    let greenData = greencounter
                    if greenData == nil {
                        Rectangle()
                            .fill(Color.Calming_Green)
                            .frame(width: 80, height: 70)
                            .offset(y: 20)
                            .opacity(0.2)
                        Text("-")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.gray)
                            .opacity(0.2)
                            .frame(width: 80, alignment: .bottom)
                    } else {
                        Rectangle()
                            .fill(Color.Calming_Green)
                            .frame(width: 80, height: 70)
                            .offset(y: 20)
                        Button(action: {
                            navigationManager.navigateTo(.greenAED)
                        }) {
                            Text(greencounter)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(Color.Cardi_Text)
                                .opacity(1)
                                .frame(width: 70, alignment: .bottom)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                    }
                }
                ZStack(alignment: .bottom) {
                    let yellowTotal = yellowcounter
                    if yellowTotal == nil {
                        Rectangle()
                            .fill(Color.Cardi_Yellow)
                            .frame(width: 80, height: 70)
                            .offset(y: 20)
                            .opacity(0.2)
                        Text("-")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.gray)
                            .opacity(0.2)
                            .frame(width: 80, alignment: .bottom)
                        
                    } else {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.Cardi_Yellow)
                                .frame(width: 80, height: 70)
                                .offset(y: 20)
                            Button(action: {
                                navigationManager.navigateTo(.yellowAED)
                            }) {
                                Text(yellowcounter )
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.Cardi_Text)
                                    .opacity(1)
                                    .frame(width: 70, alignment: .bottom)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
                ZStack(alignment: .bottom) {
                    let redTotal = redcounter
                    if redTotal == nil {
                        Rectangle()
                            .fill(Color.colorCardiRed)
                            .frame(width: 80, height: 70)
                            .offset(y: 20)
                            .opacity(0.2)
                        
                        Text("-")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.gray)
                            .opacity(0.2)
                            .frame(width: 80, alignment: .bottom)
                        
                    } else {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.colorCardiRed)
                                .frame(width: 80, height: 70)
                                .offset(y: 20)
                            
                            Button(action: {
                                navigationManager.navigateTo(.redAED)
                            }) {
                                Text(redcounter ?? "0")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.Cardi_Text)
                                    .opacity(1)
                                    .frame(width: 70, alignment: .bottom)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
                ZStack(alignment: .bottom) {
                    let grayTotal = blueCount
                    if grayTotal == nil {
                        Rectangle()
                            .fill(Color.Cadri_BLE)
                            .frame(width: 80, height: 70)
                            .offset(y: 20)
                            .opacity(0.2)
                        Text("-")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.gray)
                            .opacity(0.2)
                            .frame(width: 80, alignment: .bottom)
                    } else {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.Cadri_BLE)
                                .frame(width: 80, height: 70)
                                .offset(y: 20)
                            Button(action: {
                                navigationManager.navigateTo(.blueAED)
                            }) {
                                Text(grayTotal)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.Cardi_Text)
                                    .opacity(1)
                                    .frame(width: 70, alignment: .bottom)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
            }
            .padding(20.0)
            .frame(width: width, height: 40)
            HStack {
                let greenData = greencounter
                if greenData == nil {
                    Rectangle()
                        .fill(Color.colorCardiGray)
                        .opacity(0.2)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                } else {
                    Rectangle()
                        .fill(Color.Calming_Green)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                }
                let yellowTotal = yellowcounter
                if yellowTotal == nil {
                    Rectangle()
                        .fill(Color.colorCardiGray)
                        .opacity(0.2)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                }else {
                    Rectangle()
                        .fill(Color.Cardi_Yellow)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                }
                let redTotal = redcounter
                if redTotal == nil {
                    Rectangle()
                        .fill(Color.colorCardiGray)
                        .opacity(0.2)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                } else {
                    Rectangle()
                        .fill(Color.colorCardiRed)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                }
                let grayData = String(blueCount)
                if grayData == nil {
                    Rectangle()
                        .fill(Color.colorCardiGray)
                        .opacity(0.2)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                } else {
                    Rectangle()
                        .fill(Color.Cadri_BLE)
                        .frame(width:80, height: 4)
                        .offset(y: 15)
                }
            }
            .frame(width: widthInner, height: 40)
            .offset(x: 0, y: 45)
        }
        .offset(x: -25, y:0)
    }
    
}


