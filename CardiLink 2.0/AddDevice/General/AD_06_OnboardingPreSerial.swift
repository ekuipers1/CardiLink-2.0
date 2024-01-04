//
//  AD_06_OnboardingPreSerial.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 12.12.22.
//

import SwiftUI

struct AD_06_OnboardingPreSerial: View {
    
    @State private var isNKBT_Connected: Bool = false
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("myPortal") var myPortal: String?
    @AppStorage("ble_state") var bleState: String!
    @AppStorage("DemoProd") var demoProd: String?
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(alignment: .leading){
                    
                    ScrollView(){
                        
                        let defaults = UserDefaults.standard
                        let backend = defaults.string(forKey: "BackendAdd")
                        
                        if backend == "NK" {
                            
                            Text("Bluetooth Onboarding")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .frame(width:widthInner, height: 40)
                        } else {
                            
                            Text("HeartConnect Onboarding")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .frame(width:widthInner, height: 40)
                        }
                        
                        VStack(){
                            Text("Prepare the HeartConnect for connecting")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInner, height: 50)
                                .offset(x: 0, y: 0)
                            
                            Text("Use the paper clip to press and hold the indication button for 7 seconds until the LED light on the HeartConnect starts blinking.")
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .padding(.bottom, 15)
                                .padding(.top, 15)
                            
                            ZStack(){
                                Image("ComV2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200,
                                           height: 200)
                                    .padding(.top, 0.0)
                                
                                HStack(){
                                    
                                    Circle()
                                        .strokeBorder(Color.blue,lineWidth: 4)
                                        .frame(width: 40)
                                        .padding(.top, -115)
                                    Image(systemName: "1.circle.fill")
                                        .font(.title2)
                                        .padding(.top, -95)
                                        .padding(.leading, -25)
                                        .foregroundColor(.blue)
                                    
                                } .padding(.leading, -85)
                                
                                HStack(){
                                    Circle()
                                        .strokeBorder(Color.colorCardiRed,lineWidth: 4)
                                        .frame(width: 40)
                                        .padding(.top, -0)
                                    
                                    Image(systemName: "2.circle.fill")
                                        .font(.title2)
                                        .padding(.top, -35)
                                        .padding(.leading, -25)
                                        .foregroundColor(.colorCardiRed)
                                }.padding(.leading, -85)
                            }
                            
                        }
                    }
                    .padding(.top, 40.0) .frame(width: widthInner)
                    
                    let defaults = UserDefaults.standard
                    
                    if myPortal == "https://nihon-kohden.cardi-link.cloud/api/" || myPortal == "https://nihon-kohden.demo.cardi-link.cloud/api/"  || myPortal == "https://nihon-kohden.test.cardi-link.cloud/api/" {
                        
                        Button(action: {
                            navigationManager.push(.nkbleconnected)
                        }) {
                            HStack {
                                Text("Heart Connect is blinking")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .id(1)
                        }
                        .frame(width: widthInnerText)
                        .offset(x: 17, y: 0)
                        
                    }else {
                        Button(action: {
                            UserDefaults.standard.set("NO", forKey: "ConnectionSuccess")
                            navigationManager.push(.adcardiapairingopencover)
                        }) {
                            HStack {
                                Text("Heart Connect is blinking")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .id(1)
                        }
                        .frame(width: widthInnerText)
                        .offset(x: 17, y: 0)
                        
                    }
                    
                }
                
            }.offset(x: 15, y: 0)
            Spacer()
            
            
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}



