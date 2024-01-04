//
//  AD_031_VivestSerial_Type.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.10.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AD_031_VivestSerial_Type: View {
    
    @FocusState private var focusedField: Field?
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("myPortal") var myPortal: String?
    @State private var AEDCode: String = ""
    @State private var AEDCodeCheck: String = ""
    @State private var isAEDCodeEditing: Bool = false
    @State private var activationError: String?
    @State private var isAEDCodeCheckEditing: Bool = false
    
    var areTextFieldsEqual: Bool {
        return AEDCode == AEDCodeCheck
    }
    
    enum Field {
        case aedCode
        case aedCodeCheck
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
                        if focusedField == .aedCodeCheck {
                            Text(String(repeating: "*", count: AEDCode.count))
                                .font(.largeTitle)
                                .padding()
                        } else {
                            HStack {
                                Text("PBX")
                                TextField("AED Code", text: $AEDCode)
                                    .focused($focusedField, equals: .aedCode)
                                    .onChange(of: AEDCode) { newValue in
                                            AEDCode = newValue.uppercased() // Transform the text to uppercase
                                        }
                                    .onChange(of: focusedField) { newValue in
                                        if newValue != .aedCode {
                                            isAEDCodeEditing = false
                                        }
                                    }
                                    .offset(x: -8, y: 0)
                            }
                            .limitInputLength(value: $AEDCode, length: 15)
                            .foregroundColor(.Cardi_Text_Inf)
                            .font(.title)
                            .keyboardType(UIKeyboardType.default)
                            .frame(width: widthInnerText)
                            .offset(x: 30)
                            Rectangle()
                                .fill(AEDCode.count < 7 ? Color.colorCardiRed : Color.Calming_Green)
                                .frame(width: widthInnerText - 60, height: 4)
                        }
                    }
                    .offset(x: 0, y: -40)
                    .frame(width: widthInnerText, height: 70)
                    ZStack {
                        Rectangle()
                            .fill(Color.Cardi_Text)
                            .frame(width: widthInnerText - 10 , height: 60)
                            .shadow(
                                color: (areTextFieldsEqual && (AEDCodeCheck == "Enter serial number" || AEDCodeCheck.count < 7))
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
                            if focusedField == .aedCode {
                                Text(String(repeating: "*", count: AEDCodeCheck.count))
                                    .font(.largeTitle)
                                    .padding()
                            } else {
                                HStack {
                                    Text("PBX")
                                    TextField("AED Code", text: $AEDCodeCheck)
                                        .focused($focusedField, equals: .aedCodeCheck)
                                        .onChange(of: AEDCode) { newValue in
                                                AEDCode = newValue.uppercased() // Transform the text to uppercase
                                            }
                                        .onChange(of: focusedField) { newValue in
                                            if newValue != .aedCodeCheck {
                                                isAEDCodeCheckEditing = false
                                            }
                                        }
                                        .offset(x: -8, y: 0)
                                }
                                .limitInputLength(value: $AEDCodeCheck, length: 15)
                                .foregroundColor(.Cardi_Text_Inf)
                                .font(.title)
                                .keyboardType(UIKeyboardType.default)
                                .frame(width: widthInnerText)
                                .offset(x: 30)
                                
                                Rectangle()
                                    .fill(AEDCodeCheck.count < 7 ? Color.colorCardiRed : (areTextFieldsEqual) ? Color.Calming_Green : Color.colorCardiRed)
                                    .frame(width: widthInnerText  - 60, height: 4)
                            }
                        }
                    }
                    .offset(x: 0, y: -20)
                    .padding(.vertical, 5.0)
                    
                    Spacer()
                    VStack(){
                        if let error = activationError {
                            Text(error)
                                .foregroundColor(.colorCardiRed)
                                .padding(.bottom, 5)
                                .frame(width: widthInnerText, height: 120)
                        }
                        if AEDCodeCheck == AEDCode && AEDCodeCheck != "" {
                            Button(action: {
                                self.checkSerialAndActivate()
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
                            }).frame(width: widthInnerText, height: 80)
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
    
    func checkSerialAndActivate() {
        self.checkIfSerialExists { serialExists in
            if serialExists {
                ADNONIOTActivation() { success in
                    if success {
                        UserDefaults.standard.set(AEDCode, forKey: "ADSerialNumber")
                        navigationManager.push(.adVIViotstart)
                    } else {
                        self.activationError = "Activation failed. Please try again."
                    }
                }
            } else {
                self.activationError = "Please double-check the serial number you've entered. It was not recognized. Make sure all details are correct and try again."
                
            }
        }
    }
    
    func checkIfSerialExists(completion: @escaping (Bool) -> Void){
        
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myDefibrillators = "defibrillators/defibrillatorexists/"
        let url_defi = myURL! + myDefibrillators  + "PBX" + AEDCode
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let dataValue = json["data"] as? Bool {
                    completion(dataValue)
                } else {
                    completion(false)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func ADNONIOTActivation(completion: @escaping (Bool) -> Void){
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myDefibrillators = "activation/"
        let url_defi = myURL! + myDefibrillators + "PBX" + AEDCodeCheck + "/start?isnoniot=true"
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        .responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["error"].string == "Activation Failed" {
                    UserDefaults.standard.set("STOP", forKey: "ActivationError")
                    completion(false)
                } else {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
