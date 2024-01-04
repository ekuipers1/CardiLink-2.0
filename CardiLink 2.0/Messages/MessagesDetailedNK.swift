//
//  MessagesDetailedNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 24.11.21.
//

import SwiftUI

struct MessagesDetailedNK: View {
    
    @AppStorage("selectedMessageType") var selectedMessageType: String?
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("dashboardState") var dashboardState: String?
    
    var body: some View {
        VStack(){
            ZStack(){
                let backroundColor = Int(dashboardState ?? "N/A") ?? 0
                switch backroundColor {
                case 0:
                    MainBackgroundGreen()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 1:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 2:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 3:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 4:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 5:
                    MainBackgroundGray()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                default:
                    MainBackground()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                }
                VStack(alignment: .leading){
                    
                    HStack(spacing: 10){
                        Button(action:{
                            self.presentationMode.wrappedValue.dismiss()
                            UserDefaults.standard.set("false", forKey: "message_motionDetected")
                            UserDefaults.standard.set("false", forKey: "message_success")
                        }){
                            
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                            
                        }
                        .padding(.leading, 100.0)
                        Text("Messages")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
                    }
                    .padding(.top, 60.0)
                    .padding(.bottom, 30)
                }
            }
            .frame(width: 450, height: 100)
            ZStack(){
                ScrollView {
                    let newoneText = selectedMessageType
                    switch newoneText {
                    case "AEDCOVEROPEN":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "GPS":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messMovementNK()
                            .padding(.top, 20.0)
                        messMapDataNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "DAILY":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messSelfTestDailyNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "SYNCED":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messBatteryInfoNK()
                            .padding(.top, 20.0)
                        messSyncDefNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "PAIRED":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messPairingNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "ALARM":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "MONTHLY":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messSelfTestMonthNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "YEARLY":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messSelfTestYearNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "NETWORKINGREPORT":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messMobileNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "BOOTUP":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messBootNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    case "ERROR":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                        messErrorNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                        
                    case "AEDINMOTION":
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                        
                    default:
                        messMainInfoNK()
                            .padding(.top, 20.0)
                        messBaseBatteryInfoNK()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                    }
                }.frame(width: 450)
            }
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct messMainInfoNK: View {
    
    @State private var algn: HorizontalAlignment = .leading
    @AppStorage("selectedMessagetransmission") var selectedMessagetransmission: String?
    @AppStorage("selectedMessageTime") var selectedMessageTime: String?
    @AppStorage("selectedMessageType") var selectedMessageType: String?
    @AppStorage("aedInMotion") var aedInMotion: Bool?

    var body: some View {
        HStack{
            ZStack(){
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .padding(.horizontal, 5.0)
                    .shadow(color: .gray, radius: 5, y: 5)
                    .frame(width: 160, height: 180.0)
                
                HStack(){
                    
                    VStack (alignment: .leading) {
                        
                        VStack(){
                            
                            let newoneText = selectedMessageType
                            switch newoneText {
                                
                            case "AEDCOVEROPEN":
                                Text("AED Cover Open")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Yellow)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "GPS":
                                Text("GPS")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "DAILY":
                                Text("Daily")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "SYNCED":
                                Text("Synced")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "PAIRED":
                                Text("Paired")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "ALARM":
                                Text("Alarm")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Yellow)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "MONTHLY":
                                Text("Monthly")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "YEARLY":
                                Text("Yearly")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                                
                            case "NETWORKINGREPORT":
                                Text("Networking Report")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiOrange)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "BOOTUP":
                                Text("Bootup")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "ERROR":
                                Text("ERROR")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                                    .lineLimit(2)
                                    .frame(width: 140, height: 60.0)
                                    .padding(.top, 15)
                                
                            case "AEDINMOTION":
                                
                                
                                if aedInMotion == true {
                                    
                                    let motion = "In motion".localized
                                    Text(motion)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .foregroundColor(Color.colorCardiRed)
                                        .lineLimit(2)
                                        .frame(width: 140, height: 60.0)
                                        .padding(.top, 15)
                                    
                                } else {
                                    
                                    let motion = "No motion".localized
                                    Text(motion)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .foregroundColor(Color.Calming_Green)
                                        .lineLimit(2)
                                        .frame(width: 140, height: 60.0)
                                        .padding(.top, 15)
                                }
                                
                            default:
                                Text("Unknown")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            
                            VStack(){
                                
                                let newone = selectedMessageType
                                
                                switch newone {
                                case "AEDCOVEROPEN":
                                    Image(systemName: "bolt.heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "GPS":
                                    Image(systemName: "globe")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "DAILY":
                                    Image(systemName: "calendar.badge.clock")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                    
                                case "SYNCED":
                                    Image(systemName: "personalhotspot")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "PAIRED":
                                    Image(systemName: "app.connected.to.app.below.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "ALARM":
                                    Image(systemName: "alarm")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "MONTHLY":
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "YEARLY":
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "NETWORKINGREPORT":
                                    Image(systemName: "externaldrive.badge.wifi")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                case "BOOTUP":
                                    Image(systemName: "circle.square")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "ERROR":
                                    Image(systemName: "multiply.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                    
                                case "AEDINMOTION":
                                    
                                    if aedInMotion == true {
                                        
                                        Image(systemName: "figure.walk")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40,
                                                   height: 60)
                                            .foregroundColor(Color.black)
                                    } else {
                                        
                                        Image(systemName: "figure.stand")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40,
                                                   height: 60)
                                            .foregroundColor(Color.black)
                                    }
                                    
                                default:
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40,
                                               height: 40)
                                        .foregroundColor(Color.black)
                                }
                                
                            }
                            Text(selectedMessageTime!)
                                .fontWeight(.bold)
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                                .frame(width: 140,
                                       height: 60)
                                .padding(.bottom, 10.0)
                            
                        }
                    }
                }
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .padding(.horizontal, 5.0)
                    .shadow(color: .gray, radius: 5, y: 5)
                    .frame(width: 160, height: 180.0)
                VStack(){
                    
                    VStack (alignment: .leading) {
                        Text(selectedMessagetransmission ?? "N/A")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.red)
                            .lineLimit(2)
                            .frame(width: 140, height: 100.0)
                            .padding(.top, 50)
                    }
                    Text("Transmission attempts")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 140,
                               height: 40)
                        .padding(.bottom, 40.0)
                    
                }
            }
            
        }
        
    }
}

struct messBaseBatteryInfoNK: View {
    
    @AppStorage("message_communicatorBatteryLevel") var message_communicatorBatteryLevel: String?
    @AppStorage("message_defibrillatorBatteryLevel") var message_defibrillatorBatteryLevel: String?
    
    let defaults = UserDefaults.standard
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery levels") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            HStack(){
                                
                                if Int(message_defibrillatorBatteryLevel ?? "") == 0 {
                                    
                                } else {
                                    
                                    let percentBattery = Int(message_defibrillatorBatteryLevel ?? "N/A") ?? 0
                                    
                                    switch percentBattery {
                                    case 0...10:
                                        Image("battery_0")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    case 11...37:
                                        Image("battery_25")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    case 38...64:
                                        Image("battery_50")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    case 65...89:
                                        Image("battery_75")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    case 90...100:
                                        Image("battery_100")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    default:
                                        Image(systemName: "battery.25")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30,
                                                   height: 30)
                                    }
                                    
                                    Text("AED is at ")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                    +
                                    Text(message_defibrillatorBatteryLevel ?? "N/A")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                    + Text(" %")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                }
                            }
                            Divider().opacity(0)
                            HStack(){
                                
                                let backend = defaults.string(forKey: "BackendAdd")
                                if backend == "NK" {
                                    
                                    if Int(message_communicatorBatteryLevel ?? "") == 0 {
                                        
                                    } else {
                                        
                                        let percentBattery = Int(message_communicatorBatteryLevel ?? "N/A") ?? 0
                                        
                                        switch percentBattery {
                                        case 0...10:
                                            Image("battery_0")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        case 11...37:
                                            Image("battery_25")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        case 38...64:
                                            Image("battery_50")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        case 65...89:
                                            Image("battery_75")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        case 90...100:
                                            Image("battery_100")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        default:
                                            Image(systemName: "battery.25")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30,
                                                       height: 30)
                                        }
                                        
                                        
                                        Text("Heart Connect is at ")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                        +
                                        Text(message_communicatorBatteryLevel ?? "N/A")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                        + Text(" %")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                    }
                                    
                                } else {
                                    
                                }
                            }
                        }
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}
