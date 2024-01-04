//
//  MessagesMainMenuNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.11.21.
//

import SwiftUI

struct MessagesMainMenuNK: View {
    
    private var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var algn: HorizontalAlignment = .leading
    @AppStorage("dashboardState") var dashboardState: String?
    
    @State private var defibrillatorsmessage: [DefibrillatorMessages] = []
    
    var body: some View {
        NavigationView {
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
                    
                    LazyVGrid(columns: gridLayout, spacing: 10) {
                        
                        ForEach(defibrillatorsmessage, id: \.messageId) { message in
                            
                            NavigationLink(destination: MessagesDetailedNK()) {
                                
                                ZStack(){
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(Color.white)
                                        .padding(.horizontal, 5.0)
                                        .shadow(color: .gray, radius: 5, y: 5)
                                        .frame(width: 160, height: 180.0)
                                    VStack {
                                        switch message.messageType {
                                            
                                        case "AEDCOVEROPEN":
                                            imageWithCommonModifiers(systemName: "bolt.heart")
                                        case "GPS":
                                            imageWithCommonModifiers(systemName: "globe")
                                        case "DAILY":
                                            imageWithCommonModifiers(systemName: "calendar.badge.clock")
                                        case "SYNCED":
                                            imageWithCommonModifiers(systemName: "personalhotspot")
                                        case "PAIRED":
                                            imageWithCommonModifiers(systemName: "app.connected.to.app.below.fill")
                                        case "ALARM":
                                            imageWithCommonModifiers(systemName: "alarm")
                                        case "MONTHLY":
                                            imageWithCommonModifiers(systemName: "calendar")
                                        case "YEARLY":
                                            imageWithCommonModifiers(systemName: "calendar")
                                        case "NETWORKINGREPORT":
                                            imageWithCommonModifiers(systemName: "externaldrive.badge.wifi")
                                        case "BOOTUP":
                                            imageWithCommonModifiers(systemName: "circle.square")
                                        case "ERROR":
                                            imageWithCommonModifiers(systemName: "multiply.circle")
                                        case "AEDINMOTION":
                                            imageWithCommonModifiers(systemName: "waveform")
                                        default:
                                            imageWithCommonModifiers(systemName: "questionmark.circle")
                                        }
                                        
                                        
                                        Text(message.formattedMessageType().text)
                                            .font(.headline)
                                            .foregroundColor(message.formattedMessageType().color)
                                            .padding(.top, 15)
                                        
                                        Text(message.formattedTimestamp())
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                            .foregroundColor(Color.black)
                                            .frame(width: 140,
                                                   height: 60)
                                            .padding(.bottom, 10.0)
                                        
                                    }
                                }
                                
                            }
                            
                            .simultaneousGesture(TapGesture().onEnded{
                                UserDefaults.standard.set(message.messageId, forKey: "selectedMessage")
                                UserDefaults.standard.set(message.messageType, forKey: "selectedMessageType")
                                UserDefaults.standard.set(message.formattedMessageType().text, forKey: "selectedMessageTime")
                                UserDefaults.standard.set(message.transmissionAttempts, forKey: "selectedMessagetransmission")
                                
                                getMessagesDetailData()
                                
                            })
                        }
                    }
                    
                }.padding(.top, 20.0)
                    .padding(.horizontal, 5)
                
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    )
                
            }.navigationBarHidden(true)
                .onAppear {
                    fetchDefibrillatorsMessages { response in
                        if let defibrillatorsMessages = response?.data {
                            self.defibrillatorsmessage = defibrillatorsMessages
                        }
                    }
                } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }.navigationBarHidden(true)
    }
}

func imageWithCommonModifiers(systemName: String) -> some View {
    Image(systemName: systemName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 40, height: 40)
        .foregroundColor(Color.black)
        .padding(.top, 20)
}
