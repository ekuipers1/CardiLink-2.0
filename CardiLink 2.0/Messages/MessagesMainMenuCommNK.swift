//
//  MessagesMainMenuCommNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.11.21.
//

import SwiftUI

struct MessagesMainMenuCommNK: View {
    
    private var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fetcherMessagesNK = GetMessagesDataNKComm()
    @State private var algn: HorizontalAlignment = .leading
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
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            UserDefaults.standard.set("NO", forKey: "activeMap")
                            UserDefaults.standard.set("NO", forKey: "messageload")
                            UserDefaults.standard.set("false", forKey: "message_motionDetected")
                            
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
                    .padding(.top, 80.0)
                    .padding(.bottom, 30)
                }
            }
            .frame(width: 450, height: 100)
            
            ScrollView{
                LazyVGrid(columns: gridLayout, spacing: 20) {
                    ForEach(fetcherMessagesNK.fetchMessagesDataNKComm) { mymessages in
                        
                        NavigationLink(destination: MessagesDetailedNK()) {
                            ZStack(){
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.white)
                                    .padding(.horizontal, 5.0)
                                    .shadow(color: .gray, radius: 5, y: 5)
                                    .frame(width: 160, height: 180.0)
                                
                                VStack () {
                                    let newoneText = mymessages.messageType
                                    
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
                                        let motion = "Motion"
                                        Text(motion)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                            .foregroundColor(Color.Cardi_Yellow)
                                            .lineLimit(2)
                                            .frame(width: 140, height: 60.0)
                                            .padding(.top, 15)
                                    default:
                                        Text("Unknown")
                                            .fontWeight(.bold)
                                            .font(.title3)
                                            .foregroundColor(Color.colorCardiRed)
                                    }
                                    
                                    VStack(){
                                        
                                        let newone = mymessages.messageType
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
                                            Image(systemName: "waveform")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40,
                                                       height: 40)
                                                .foregroundColor(Color.black)
                                            
                                        default:
                                            Image(systemName: "questionmark.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40,
                                                       height: 40)
                                                .foregroundColor(Color.black)
                                        }
                                        
                                    }
                                    
                                    Text(mymessages.timeStamp!)
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                        .foregroundColor(Color.black)
                                        .frame(width: 140,
                                               height: 60)
                                        .padding(.bottom, 10.0)
                                    
                                }
                                
                            }
                            
                        }.navigationBarHidden(true)
                            .edgesIgnoringSafeArea(.all)
                        
                            .simultaneousGesture(TapGesture().onEnded{
                                UserDefaults.standard.set(mymessages.id, forKey: "selectedMessage")
                                UserDefaults.standard.set(mymessages.messageType, forKey: "selectedMessageType")
                                UserDefaults.standard.set(mymessages.timeStamp!, forKey: "selectedMessageTime")
                                UserDefaults.standard.set(mymessages.transmissionAttempts, forKey: "selectedMessagetransmission")
                                getMessagesDetailData()
                            })
                    }
                }
            }.padding(.top, 20.0)
                .padding(.horizontal, 75)
            
        }.navigationBarHidden(true)
            .mask(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}



