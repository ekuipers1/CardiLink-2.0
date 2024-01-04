//
//  AD_02_NKSerialSelect_Type.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.06.23.
//

import Foundation
import SwiftUI


struct AD_02_NKSerialSelect_Type: View {
    
    @State private var AEDCode: String = ""
    @State private var AEDCodeCheck: String = ""
    @State private var CombinedSerial: String = ""
    @AppStorage("ble_state") var bleState: String!
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    
    var body: some View {
        
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(){
                    
                    VStack(alignment: .leading){
                        Text("AED serial number")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInner, height: 40)
                            .offset(x: 0, y: 50)
                        
                        
                        VStack(){
                            Text("Please enter AED serial number")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInner, height: 80)
                                .offset(x: 0, y: 40)
                        }
                    }
                    Spacer()
                    
                    ZStack(){
                        
                        TextField("000000", text: $AEDCode)
                            .limitInputLength(value: $AEDCode, length: 6)
                            .foregroundColor(.Cardi_Text_Inf)
                            .font(.title)
                            .keyboardType(UIKeyboardType.numberPad)
                            .frame(width: 115, height: 60)
                        
                        if AEDCode.count < 5 {
                            
                            Rectangle()
                            
                                .fill(Color.colorCardiRed)
                                .frame(width: 115, height: 4)
                                .padding(.top, 30)
                            
                        } else {
                            
                            Rectangle()
                            
                                .fill(Color.Calming_Green)
                                .frame(width: 115, height: 4)
                                .padding(.top, 30)
                            
                        }
                        
                    }
                    .offset(x: 0, y: -40)
                    
                    ZStack(){
                        
                        if AEDCodeCheck == AEDCode {
                            
                            if AEDCodeCheck == "000000" || AEDCodeCheck.count < 5 {
                                
                                Rectangle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 210, height: 60)
                                    .shadow(color: .colorCardiRed, radius: 3, y: 1)
                                
                            }else{
                                Rectangle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 210, height: 60)
                                    .shadow(color: .Calming_Green, radius: 3, y: 1)
                            }
                            ZStack(){
                                
                                Rectangle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 80, height: 30)
                                Text("Confirm")
                                
                            }.offset(x: 0, y: -30)
                            
                        } else {
                            
                            Rectangle()
                                .fill(Color.Cardi_Text)
                                .frame(width: 210, height: 60)
                                .shadow(color: .colorCardiRed, radius: 3, y: 1)
                            ZStack(){
                                Rectangle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 80, height: 30)
                                Text("Confirm")
                            }.offset(x: 0, y: -30)
                        }
                        
                        TextField("000000", text: $AEDCodeCheck)
                            .limitInputLength(value: $AEDCodeCheck, length: 6)
                            .foregroundColor(.Cardi_Text_Inf)
                            .font(.title)
                            .keyboardType(UIKeyboardType.numberPad)
                            .frame(width: 105, height: 60)
                        
                        if AEDCodeCheck.count < 5 {
                            
                            Rectangle()
                            
                                .fill(Color.colorCardiRed)
                                .frame(width: 115, height: 4)
                                .padding(.top, 30)
                        } else {
                            
                            Rectangle()
                            
                                .fill(Color.colorCardiRed)
                                .frame(width: 125, height: 4)
                                .padding(.top, 30)
                            
                            if AEDCodeCheck == AEDCode {
                                
                                Rectangle()
                                
                                    .fill(Color.Calming_Green)
                                    .frame(width: 125, height: 4)
                                    .padding(.top, 30)
                            }
                        }
                    }
                    
                    .offset(x: 0, y: -20)
                    .padding(.vertical, 5.0)
                    
                    Spacer()
                    
                    VStack(){
                        
                        if AEDCodeCheck == AEDCode && AEDCodeCheck != "" {
                            
                            Button(action: {
                                
                                if bleState == "Is Unauthorized." || bleState == "Is Unsupported."  {
                                    
                                    self.activeAlert = .first
                                    self.showAlert = true
                                    
                                } else {
                                    
                                }
                                
                                navigationManager.push(.adNKiotstart)
                                UserDefaults.standard.set(AEDCode, forKey: "ADSerialNumber")
                                UserDefaults.standard.set("NO", forKey: "ConnectionSuccess")
                                UserDefaults.standard.set("False", forKey: "connection_ble")
                                
                                if AEDCode.count == 5 {
                                    
                                    CombinedSerial = "0"+AEDCode
                                    UserDefaults.standard.set(CombinedSerial, forKey: "MYPIN")
                                    UserDefaults.standard.set(CombinedSerial, forKey: "ADSerialNumber")
                                    
                                } else {
                                    
                                    CombinedSerial = AEDCode
                                    UserDefaults.standard.set(CombinedSerial, forKey: "MYPIN")
                                    UserDefaults.standard.set(CombinedSerial, forKey: "ADSerialNumber")
                                    
                                }
                                
                            }, label: {
                                HStack {
                                    Text("Next")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                    Image(systemName: "arrowshape.forward.fill")
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                                .id(1)
                            }).frame(width:widthInnerText, height: 80)
                            
                        }
                        
                    }
                    
                }.padding(.bottom, 20)
                
                    .frame(width:width)
                
            }.navigationBarHidden(true)
                .offset(x: 10, y: 0)
                .frame(width:width)
        }  .gesture(DragGesture().onChanged { _ in
            UIApplication.shared.endEditing()
        })
        
    }
}


