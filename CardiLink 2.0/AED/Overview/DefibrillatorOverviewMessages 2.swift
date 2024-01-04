//
//  DefibrillatorOverviewMessages.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//

import SwiftUI

//MARK: Last3Messages
struct Last3Messages: View{
    @State private var showButtons = false
    @State private var dropdownComm = false
    @ObservedObject var fetcherMessagesNK = GetMessagesDataNKOverview()
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 325, height: 220)
                
                
                HStack(){
                    Button(action: {
                        print("Movement click")
                        
                        
                    }, label: {
                        
                        HStack(){
                            NavigationLink(destination: MessagesMainMenuNK()) {
                                
                                VStack(alignment: .leading){
                                    VStack(alignment: .leading){
                                        Text("Last Messages")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                    }
                                    .offset(x: 10, y: 10)
                                    
                                    
                                    ForEach(fetcherMessagesNK.fetchMessagesDataNK) {
                                        mymessages in
                                        VStack(spacing: 5){
                                            
                                            //                        let newoneText = mymessages.messageType
                                            
                                            VStack(alignment: .trailing){
                                                HStack(){
                                                    
                                                    let newone = mymessages.messageType
                                                    
                                                    switch newone {
                                                    case "AEDCOVEROPEN":
                                                        Image(systemName: "bolt.heart")
                                                        
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("AED Cover Open")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "GPS":
                                                        Image(systemName: "globe")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("GPS")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "DAILY":
                                                        Image(systemName: "calendar.badge.clock")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Daily")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "SYNCED":
                                                        Image(systemName: "personalhotspot")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Synced")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "PAIRED":
                                                        Image(systemName: "app.connected.to.app.below.fill")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Paired")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "ALARM":
                                                        Image(systemName: "alarm")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Alarm")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                        
                                                    case "MONTHLY":
                                                        Image(systemName: "calendar")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Monthly")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "YEARLY":
                                                        Image(systemName: "calendar")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Yearly")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "NETWORKINGREPORT":
                                                        Image(systemName: "externaldrive.badge.wifi")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Networking Report")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 95.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "BOOTUP":
                                                        Image(systemName: "circle.square")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Bootup")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "ERROR":
                                                        Image(systemName: "multiply.circle")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("ERROR")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                    case "AEDINMOTION":
                                                        Image(systemName: "waveform")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Motion")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                        
                                                        
                                                    default:
                                                        Image(systemName: "questionmark.circle")
                                                            .font(.title2)
                                                            .frame(width: 40.0, height: 40.0)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .offset(x: 0, y: 5)
                                                        
                                                        Text("Unknown")
                                                            .font(.body)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .fontWeight(.semibold)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: 90.0, height: 50.0, alignment: .leading)
                                                    }
                                                    
                                                    Text(mymessages.timeStamp ?? "NAAAA")
                                                        .font(.callout)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                        .fontWeight(.regular)
                                                        .multilineTextAlignment(.leading)
                                                        .frame(width: 150.0, height: 50.0)
                                                } .offset(x: 5, y: 5)
                                                
                                            }
                                            
                                        }
                                    }
                                    
                                } .offset(x: 5)
                                
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                        })
                    })
                    
                    //                }
                    .padding(.bottom, 20.0)
                    //                }
                }.padding(.top, 20.0)
                
            }.offset(x: 0)
        }
    }
    
}
