//
//  DefibrillatorOverviewServiceTickets.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//


import SwiftUI

//MARK: ServiceTickets
struct ServiceTickets: View{
    @State private var showButtons = false
    @Environment(\.presentationMode) var presentationMode
    @State private var dropdownComm = false
    
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 325, height: 100)
                
                
                HStack(){
                    Button(action: {
                        print("Movement click")
                        
                        
                        
                    }, label: {
                        
                        HStack(){
                            NavigationLink(destination: ServiceTicketsDefi()) {
                                
                                HStack(){
                                    
                                    //                HStack(spacing: -20){
                                    Image(systemName: "ticket.fill")
                                        .font(.title2)
                                        .frame(width: 40.0, height: 40.0)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                        .padding(10.0)
                                    //                }
                                    VStack(alignment: .leading){
                                        Text("Service Tickets")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                        Text("No service tickets created for this device")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                        
                                    }.frame(width: 260, height: 70)
                                        .offset(x: -15)
                                }
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                        })
                    })
                    //                        }
                }
            }.padding(.top, 20.0)
        }.offset(x: 0)
            .padding(.bottom, 20.0)
    }
}
