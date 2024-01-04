//
//  AD_032_CardiaSerial_Type.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 26.10.23.
//

import SwiftUI

struct AD_032_CardiaSerial_Type: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @AppStorage("myPortal") var myPortal: String?
    
    @State private var AEDCode: String = ""
    @State private var AEDCodeCheck: String = ""
    @State private var isTextBEditing: Bool = false
    
    var areTextFieldsEqual: Bool {
        return AEDCode == AEDCodeCheck
    }
    
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
                    
                    VStack(spacing: 5) {
                        if isTextBEditing {
                            Text(String(repeating: "*", count: AEDCode.count))
                                .font(.largeTitle)
                                .padding()
                                .onTapGesture {
                                    self.isTextBEditing = false
                                }
                        } else {
                            
                            TextField("Enter serial number", text: $AEDCode)
                                .limitInputLength(value: $AEDCode, length: 15)
                                .foregroundColor(.Cardi_Text_Inf)
                                .font(.title)
                                .keyboardType(UIKeyboardType.default)
                                .frame(width: widthInnerText)
                                .offset(x: 30)
                            Rectangle()
                                .fill(AEDCode.count < 8 ? Color.colorCardiRed : Color.Calming_Green)
                                .frame(width: widthInnerText - 60, height: 4)  // Set the width of the Rectangle to widthInnerText
                        }
                    }
                    .offset(x: 0, y: -40)
                    .frame(width: widthInnerText, height: 70)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.Cardi_Text)
                            .frame(width: widthInnerText - 10 , height: 60)
                            .shadow(
                                color: (areTextFieldsEqual && (AEDCodeCheck == "Enter serial number" || AEDCodeCheck.count < 8))
                                ? .colorCardiRed : (areTextFieldsEqual) ? .Calming_Green : .colorCardiRed,
                                radius: 3,
                                y: 1
                            )
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.Cardi_Text)
                                .frame(width: 80, height: 30)
                            Text("Confirm")
                        }
                        .offset(x: 0, y: -30)
                        
                        VStack(spacing: 5) {
                            TextField("Enter serial number", text: $AEDCodeCheck, onEditingChanged: { isEditing in
                                self.isTextBEditing = isEditing
                            })
                            .limitInputLength(value: $AEDCodeCheck, length: 15)
                            .foregroundColor(.Cardi_Text_Inf)
                            .font(.title)
                            .keyboardType(UIKeyboardType.default)
                            .frame(width: widthInnerText)
                            .offset(x: 30)
                            
                            Rectangle()
                                .fill(AEDCodeCheck.count < 8 ? Color.colorCardiRed : (areTextFieldsEqual) ? Color.Calming_Green : Color.colorCardiRed)
                                .frame(width: widthInnerText  - 60, height: 4)
                        }
                    }
                    .offset(x: 0, y: -20)
                    .padding(.vertical, 5.0)
                    
                    Spacer()
                    
                    VStack(){
                        
                        if AEDCodeCheck == AEDCode && AEDCodeCheck != "" {
                            
                            Button(action: {
                                
                                navigationManager.push(.adiotstart)
                                UserDefaults.standard.set(AEDCode, forKey: "ADSerialNumber")
                                
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

