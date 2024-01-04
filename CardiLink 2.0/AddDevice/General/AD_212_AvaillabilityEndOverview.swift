//
//  AD_212_AvaillabilityEndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 15.08.23.
//

import SwiftUI

struct AD_212_AvaillabilityEndOverview: View {
    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    
    @AppStorage("Monday") var MondaySelected: String?
    @AppStorage("Tuesday") var TuesdaySelected: String?
    @AppStorage("Wednesday") var WednesdaySelected: String?
    @AppStorage("Thursday") var ThursdaySelected: String?
    @AppStorage("Friday") var FridaySelected: String?
    @AppStorage("Saturday") var SaturdaySelected: String?
    @AppStorage("Sunday") var SundaySelected: String?
    
    @State private var is247Available: Bool = UserDefaults.standard.bool(forKey: "is247Available")
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(){
                
                if is247Available {
                    
                    Text("Your AED is available 24/7")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .frame(width:widthInnerText, height: 50)
                        .padding(.bottom, 20.0)
                    
                    HStack(){
                        
                        Button(action: {
                            
                            navigationManager.push(.adavailtimes)
                            
                        }) {
                            HStack {
                                Text("Update with opening hours")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .stroke(lineWidth: 3.0)
                                        .frame(width: widthInnerText * 0.9)
                                )
                                .offset(x: 0, y: 10)
                                .padding(.bottom,20)
                            
                        }
                    } .frame(width:widthInnerText)
                    
                } else {
                    
                    VStack(){
                        
                        Text("You have made the following selection.")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInnerText, height: 50)
                            .padding(.bottom, 20.0)
                        
                    }
                    
                    if MondaySelected == "Yes"
                    {
                        Monday()
                        
                    }
                    
                    if TuesdaySelected == "Yes"
                    {
                        Tuesday()
                    }
                    
                    if WednesdaySelected == "Yes"
                    {
                        Wednesday()
                    }
                    
                    if ThursdaySelected == "Yes"
                    {
                        Thursday()
                    }
                    
                    
                    if FridaySelected == "Yes"
                    {
                        Friday()
                    }
                    
                    
                    if SaturdaySelected == "Yes"
                    {
                        Saturday()
                    }
                    
                    if SundaySelected == "Yes"
                    {
                        Sunday()
                    }

                    HStack(){
                        Spacer()
                        Button(action: {
                            
                            UserDefaults.standard.set("true", forKey: "ADExisting")
                            navigationManager.push(.adavailtimes)
                            
                        }) {
                            HStack {
                                Text("Edit")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .stroke(lineWidth: 3.0)
                                        .frame(width: widthInnerText * 0.2)
                                )
                                .offset(x: 0, y: 10)
                                .padding(.bottom,20)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                            self.is247Available = true
                            UserDefaults.standard.set(true, forKey: "is247Available")
                            ADAvailable247()
                            getAvialableDayTime(optionA: true)
                            
                        }) {
                            HStack {
                                Text("Switch to 24/7")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20.0)
                                        .stroke(lineWidth: 3.0)
                                        .frame(width: widthInnerText * 0.6)
                                )
                                .offset(x: 0, y: 10)
                                .padding(.bottom,20)
                            
                        }
                        
                        Spacer()
                        
                    }.frame(width: widthInnerText)
                    
                }
            }
            
        }.frame(width:width)
            .navigationBarHidden(true)
            .onAppear(){
                
                getAvialableDayTime()
            }
    }
}

