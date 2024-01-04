//
//  CommHardware.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 18.03.21.
//

import SwiftUI

struct CommHardware: View {
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(){
            ZStack(){
                MainBackground()
                    .padding(.top, 240.0)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .padding(.leading, 100.0)
                        Text("Hardware")
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
                    comMainInfo()
                        .padding(.top, 20.0)
                    commhardwareBaseDataNK()
                        .padding(.top, 20.0)
                    commInternalChecks()
                        .padding(.top, 20.0)
                        .padding(.bottom, 60.0)
                    Spacer()
                }
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

