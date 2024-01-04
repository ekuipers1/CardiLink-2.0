//
//  AD_11_CardiaPairingRedGreen.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 08.03.23.
//

import SwiftUI

struct AD_11_CardiaPairingRedGreen: View {
    
    @AppStorage("myPortal") var myPortal: String?
    @AppStorage("ADExisting") var ADExisting: String?
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var DeviceIsInitiallyOk = false
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
            }
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(alignment: .leading){
                    
                    Text("Status of your AED")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width:widthInnerText, height: 40)
                        .offset(x: 0, y: 40)
                    
                    Spacer()
                    HStack(){
                        Text("**Is the indicator on the AED still green?**")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .offset(x: 0, y: 10)
                    }.frame(width:widthInnerText, height: 180)
                    
                    Spacer()
                    HStack(){
                        if myPortal == "https://nihon-kohden.cardi-link.cloud/api/" || myPortal == "https://nihon-kohden.demo.cardi-link.cloud/api/" || myPortal == "https://nihon-kohden.test.cardi-link.cloud/api/"{
                            Button(action: {
                                if ADExisting == "true" {
                                    self.DeviceIsInitiallyOk = true
                                    UserDefaults.standard.set(DeviceIsInitiallyOk, forKey: "DeviceIsInitiallyOk")
                                    ADDeviceIsInitiallyOk()
                                    navigationManager.push(.adlocationmainscreen)
                                } else {
                                    self.DeviceIsInitiallyOk = true
                                    navigationManager.push(.adlocationmainscreen)
                                    UserDefaults.standard.set(DeviceIsInitiallyOk, forKey: "DeviceIsInitiallyOk")
                                    ADDeviceIsInitiallyOk()
                                    navigationManager.push(.adlocationmainscreen)
                                }
                            }, label: {
                                HStack {
                                    Text("Yes")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                            })
                            .environmentObject(navigationManager)
                            
                            Button(action: {
                                self.DeviceIsInitiallyOk = false
                                ADDeviceIsInitiallyOk()
                                navigationManager.navigateTo(.adIntro)
                            }, label: {
                                HStack {
                                    Text("No")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                            })
                            .environmentObject(navigationManager)
                            
                        } else {
                            
                            Button(action: {
                                navigationManager.push(.adlocationmainscreen)
                            }, label: {
                                HStack {
                                    Text("Yes")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                            })
                            .environmentObject(navigationManager)
                            
                            Button(action: {
                                navigationManager.navigateTo(.adIntro)
                            }, label: {
                                HStack {
                                    Text("No")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                            })
                            .environmentObject(navigationManager)
                        }
                        
                    }
                    .padding(.bottom, 20.0)
                    
                    .frame(width:widthInnerText)
                    
                }
            }
            .offset(x: 15, y: 0)
            Spacer()
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}

