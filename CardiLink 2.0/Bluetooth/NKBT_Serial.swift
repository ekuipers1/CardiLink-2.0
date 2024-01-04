//
//  NKBT_Serial.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.10.21.
//

import SwiftUI
import AudioToolbox

class TextFieldManager: ObservableObject {
    
    let characterLimit = 1
    
    @Published var userInput1 = "" {
        didSet {
            if userInput1.count > characterLimit {
                userInput1 = String(userInput1.prefix(characterLimit))
                userInput1.removeLast()
                
            }
        }
    }
    
    @Published var userInput2 = "" {
        didSet {
            if userInput2.count > characterLimit {
                userInput2 = String(userInput2.prefix(characterLimit))
                userInput2.removeLast()
                
            }
        }
    }
    
    @Published var userInput3 = "" {
        didSet {
            if userInput3.count > characterLimit {
                userInput3 = String(userInput3.prefix(characterLimit))
                userInput3.removeLast()
                
            }
        }
    }
    
    @Published var userInput4 = "" {
        didSet {
            if userInput4.count > characterLimit {
                userInput4 = String(userInput4.prefix(characterLimit))
                userInput4.removeLast()
                
            }
        }
    }
    
    @Published var userInput5 = "" {
        didSet {
            if userInput5.count > characterLimit {
                userInput5 = String(userInput5.prefix(characterLimit))
                userInput5.removeLast()
                
            }
        }
    }
    
    @Published var userInput6 = "" {
        didSet {
            if userInput6.count > characterLimit {
                userInput6 = String(userInput6.prefix(characterLimit))
                userInput6.removeLast()
                
            }
        }
    }
}

enum ActiveAlert {
    case first, second
}

struct NKBT_Serial: View {
    
    @Binding var isNKBT_Serial: Bool
    @State private var value = ""
    @State private var withOutline = ""
    @ObservedObject var textFieldManager = TextFieldManager()
    
    @State private var number_1: String = ""
    @State private var number_2: String = ""
    @State private var number_3: String = ""
    @State private var number_4: String = ""
    @State private var number_5: String = ""
    @State private var number_6: String = ""
    @State private var CombinedSerial: String = ""
    
    @State private var isNKBT_Connected: Bool = false
    
    @State private var showingAlert = false
    @State private var showingAlertble = false
    
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    
    @State private var AEDCode: String = ""
    
    @AppStorage("ble_state") var bleState: String!
    
    var body: some View {
        
        ZStack {
            MainBackgroundBlue()
            
            VStack(){
                Text("Bluetooth Onboarding")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .padding(.top, 40.0)
                    .padding(.bottom, 50)
                
                ZStack(){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 5, y: 5)
                        .frame(width: 340, height: 400)
                    
                    VStack(){
                        Text("Please enter AED serial number (5 or 6 digits)")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 25.0)
                            .foregroundColor(Color.colorCardiGray)
                            .frame(width: 280, height: 70)
                        
                            .padding(.top, 15)
                        
                        ZStack(){
                            TextField("000000", text: $AEDCode)
                                .limitInputLength(value: $AEDCode, length: 6)
                                .foregroundColor(.black)
                                .font(.title)
                                .keyboardType(UIKeyboardType.numberPad)
                                .frame(width: 105, height: 60)
                            
                            if AEDCode.count < 5 {
                                
                                Rectangle()
                                
                                    .fill(Color.colorCardiRed)
                                    .frame(width: 105, height: 4)
                                    .padding(.top, 30)
                                
                            } else {
                                
                                
                                Rectangle()
                                
                                    .fill(Color.Calming_Green)
                                    .frame(width: 105, height: 4)
                                    .padding(.top, 30)
                                
                            }
                        }
                        
                        .padding(.vertical, 5.0)
                        
                        Text("After you tab on continue, the app will make the Bluetooth connection and verify your AED serial number.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 25.0)
                            .foregroundColor(Color.colorCardiGray)
                            .frame(width: 280, height: 100)
                            .padding(.vertical, 5)
                        
                        Button("Continue") {
                            
                            if bleState == "Is Unauthorized." || bleState == "Is Unsupported."  {
                                
                                self.activeAlert = .first
                                self.showAlert = true
                                
                            } else {
                                
                                UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
                                UserDefaults.standard.set("NO", forKey: "ConnectionSuccess")
                                
                                if AEDCode.count < 5 {
                                    
                                    self.activeAlert = .second
                                    self.showAlert = true
                                }
                                
                                if AEDCode.count == 5 {
                                    
                                    CombinedSerial = "0"+AEDCode
                                    UserDefaults.standard.set(CombinedSerial, forKey: "MYPIN")
                                    
                                } else {
                                    
                                    CombinedSerial = AEDCode
                                    UserDefaults.standard.set(CombinedSerial, forKey: "MYPIN")
                                    
                                }
                                
                                UserDefaults.standard.set("False", forKey: "connection_ble")
                                
                                isNKBT_Connected.toggle()
                            }
                        }
                        
                        .sheet(isPresented: $isNKBT_Connected) {
                            NKBT_Connected()
                        }
                        
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.Cadri_BLE)
                        .cornerRadius(40)
                        .padding(.bottom, 25.0)
                        
                    }
                }
                
            }
        }
        .alert(isPresented: $showAlert) {
            switch activeAlert {
            case .first:
                return Alert(title: Text("Bluetooth issue"), message: Text("Please make sure your bluetooth is turned on and check if the app has permission to use it."))
            case .second:
                return Alert(title: Text("Incorrect AED Serial Number"), message: Text("Please enter at least 5 numbers!"))
            }
        }
    }
}



