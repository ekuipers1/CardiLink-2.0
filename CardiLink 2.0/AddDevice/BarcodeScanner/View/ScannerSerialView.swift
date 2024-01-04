//
//  ScannerSerialView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.04.23.
//

import SwiftUI

struct ScannerSerialView: View {
    
    @AppStorage("CodeScan") var CodeScan: String?
    @State private var AEDCode: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")
                
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
                            .offset(x: 0, y: 40)
                        
                        
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
                        
                        if CodeScan == "N/A" ||  CodeScan == "" {
                            
                            
                            TextField("0000000000", text: $AEDCode)
                                .limitInputLength(value: $AEDCode, length: 10)
                                .foregroundColor(.Cardi_Text_Inf)
                                .font(.title)
                                .keyboardType(UIKeyboardType.numberPad)
                                .frame(width: 175, height: 60)
                            
                            if AEDCode.count < 9 {
                                Rectangle()
                                
                                    .fill(Color.colorCardiRed)
                                    .frame(width: 175, height: 4)
                                    .padding(.top, 30)
                            } else {
                                
                                Rectangle()
                                
                                    .fill(Color.Calming_Green)
                                    .frame(width: 175, height: 4)
                                    .padding(.top, 30)
                            }
                        } else {
                            
                            VStack(){
                                
                                Text(CodeScan ?? "N/A")
                                    .foregroundColor(.Cardi_Text_Inf)
                                    .font(.title)
                                    .keyboardType(UIKeyboardType.numberPad)
                                    .frame(width: 175, height: 60)
                                Rectangle()
                                
                                    .fill(Color.Calming_Green)
                                    .frame(width: 175, height: 4)
                                    .offset(x: 0, y: -20)
                            }
                        }
                        
                    }
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        
                        NavigationLink(destination:  AD_04_IotStart()) {
                            HStack {
                                
                                Text("next")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .id(1)
                            
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            UserDefaults.standard.set(CodeScan, forKey: "ADSerialNumber")
                        })
                        
                    }) .frame(width:widthInnerText, height: 80)
                        .offset(x: 0, y: 40)
                        .offset(x: 0, y: -40)
                }
            }
            .offset(x: 15, y: 0)
            .padding(.bottom, 20)
            
            Spacer()
            
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}
