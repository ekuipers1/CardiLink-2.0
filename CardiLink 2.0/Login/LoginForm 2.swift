//
//  LoginForm.swift
//  cardi-login
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import CryptoKit

struct LoginForm: View {
    
    @EnvironmentObject var auth:BaseDataFetch
    @EnvironmentObject var base:BaseDataFetch
    
    
    @State var authenticationDidFail = false
    @State var authenticationDidSucceed = false
    
    @State var baseUser = ""
    @State var basePass = ""
    
    @State var token:UUID?
    
    @State private var buttonBackColor:Color = Color.colorCardiGray
    @State private var buttonBackColorProd:Color = Color.colorCardiGray
    
    @State private var presentingAlert = false
    @State private var presentingAlertPassword = false
    
    let defaults = UserDefaults.standard
    @State private var isShowingPortal: Bool = false
    @State private var isShowingPassword: Bool = false
    
    @AppStorage("username") var username = ""
    @AppStorage("userpwd") var userpwd = ""
    @AppStorage("DataUIDUser") var emailStored: String?
    
    @State var email:String = ""
    @State var password:String = ""
    
    @AppStorage("saveit") var saveit = ""
    @AppStorage("rememberme") var isToggleOn = false
    @AppStorage("saveit") var rememberMe = ""
    
    @State private var isDemoSelected: Bool = false
    @State private var isShowingBLE: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
        //        NavigationView {
        VStack {
            
            
            
            Image("CardiLink-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
                .padding(.top, 20.0)
                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.15)
                .gesture(TapGesture(count: 3)
                    .onEnded{
                        
                        isShowingBLE = true
                        print("Double tapped!")
                        
                    } )
            
            HStack {
                
                Button(action: {
                    defaults.set("NO", forKey: "callServiceTickets")
                    
                }) {
                    HStack {
                        
                    }
                    .sheet(isPresented: $isShowingBLE) {
                        NKBT_Warning(isShowingBLE: self.$isShowingBLE)
                    }
                }
                
            }
            VStack {
                Input(placeholder: "Your Email / User ID", value: $username, type: InputTypes.text)
                    .padding(.leading, 10)
                    .padding(.bottom, 15)
                    .padding(.top, 50)
                    .foregroundColor(Color.Cardi_Text_Inf)
                
                
                Input(placeholder: "Password", value: $userpwd, type: InputTypes.secure)
                    .padding(.bottom, 15)
                    .padding(.leading, 10)
                    .foregroundColor(Color.black)
            }
            
            .foregroundColor(.colorCardiOrange)
            
            //            .padding(.top, 120)
            
            Toggle("Remember me", isOn: $isToggleOn)
            
            
                .onChange(of: isToggleOn) { value in
                    print(value)
                    
                    if value == false {
                        
                        defaults.set("NO", forKey: "saveit")
                        
                        
                        
                        username = email
                        userpwd = password
                        
                    } else {
                        
                        defaults.set("YES", forKey: "saveit")
                        
                    }
                    
                }.foregroundColor(Color.black)
                .toggleStyle(SwitchToggleStyle(tint: Color.colorCardiOrange))
            
            
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 10)
            
            HStack(){
                
                Button(action: {
                    //MARK: CHANGE FOR LIFE!!!!!!!!!!!
                    
                    
                    defaults.set("https://nihon-kohden.demo.cardi-link.cloud/api/", forKey: "myPortal")
                    //                    defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                    //   "https://nihon-kohden.test.cardi-link.cloud/api/"                 defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                    //                    isShowingPortal = true
                    //MARK: CHANGE FOR LIFE!!!!!!!!!!!
                    if (self.buttonBackColor == Color.colorCardiGray) {
                        self.buttonBackColor = Color.colorCardiOrange
                        self.buttonBackColorProd = Color.colorCardiGray
                    } else if self.buttonBackColor == Color.colorCardiOrange {
                        self.buttonBackColor = Color.colorCardiGray
                        self.buttonBackColorProd = Color.colorCardiOrange
                    } else {
                        self.buttonBackColor = Color.colorCardiGray
                        self.buttonBackColorProd = Color.colorCardiOrange
                    }
                    print("DEMO Portal tapped!")
                    
                    isDemoSelected = true
                    
                    
                }) {
                    HStack {
                        Text("Demo")
                        Image(systemName: "externaldrive.connected.to.line.below")
                            .font(.title2)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(buttonBackColor)
                    .cornerRadius(40)
                    
                    .sheet(isPresented: $isShowingPortal) {
                        Portals(isShowingPortal: self.$isShowingPortal)
                    }
                }
                Spacer()
                Button(action: {
                    //MARK: CHANGE FOR LIFE!!!!!!!!!!!
                    //                    defaults.set("https://mqa1.cardilink.cloud/", forKey: "myPortal")
                    //                                      defaults.set("https://qa1.cardilink.cloud/", forKey: "myPortal")
                    //                    defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                    //                    defaults.set("https://primedic.dev.cardi-link.cloud/api/", forKey: "myPortal")
                    
                    
                    
                    defaults.set("https://nihon-kohden.cardi-link.cloud/api/", forKey: "myPortal")
//                                        defaults.set("https://nihon-kohden.test.cardi-link.cloud/api/", forKey: "myPortal")
                    
                    
                    //MARK: CHANGE FOR LIFE!!!!!!!!!!!
                    
                    
                    
                    if (self.buttonBackColorProd == Color.colorCardiOrange) {
                        self.buttonBackColorProd = Color.colorCardiGray
                        self.buttonBackColor = Color.colorCardiOrange
                    } else if self.buttonBackColorProd == Color.colorCardiGray {
                        self.buttonBackColorProd = Color.colorCardiOrange
                        self.buttonBackColor = Color.colorCardiGray
                    } else {
                        self.buttonBackColorProd = Color.colorCardiOrange
                        self.buttonBackColor = Color.colorCardiGray
                    }
                    print("PROD Portal tapped!")
                    isDemoSelected = false
                }) {
                    HStack {
                        Text("Production")
                        Image(systemName: "externaldrive.connected.to.line.below")
                            .font(.title2)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(buttonBackColorProd)
                    .cornerRadius(40)
                    
                    .sheet(isPresented: $isShowingPortal) {
                        Portals(isShowingPortal: self.$isShowingPortal)
                    }
                }
                
            }.frame(width: 300, height: 50, alignment: .center)
                .padding(.top, 20)
            
            HStack() {
                
                CustomButton(text: "Login") {
                    
                    if (self.buttonBackColorProd == Color.colorCardiGray && self.buttonBackColor == Color.colorCardiGray) {
                        self.presentingAlert = true
                    } else {
                        
                        if isToggleOn == false {
                            defaults.set("NO", forKey: "saveit")
                        } else {
                            
                        }
                        
                        if username == "" {
                            
                            authenticationDidFail = true
                            //                    LoginFail()
                            self.presentingAlert = true
                            //                        auth.logout()
                            
                        } else if userpwd == "" {
                            
                            authenticationDidFail = true
                            self.presentingAlert = true
                            //                        auth.logout()
                        } else {
                            
                            let myURL = defaults.string(forKey: "myPortal")
                            
                            if myURL == nil {
                                defaults.set("NO", forKey: "callServiceTickets")
                                self.presentingAlert = true
                            } else {
                                
                                let myLogon = "login?login="
                                
                                //                                let secretString = "salt"
                                //                                let key = SymmetricKey(data: secretString.data(using: .utf8)!)
                                
                                //                                let stringUID = (username.lowercased())
                                let stringPWD = userpwd
                                //                                let uidpwdCombined = stringUID + stringPWD
                                //
                                //                                let signature = HMAC<SHA256>.authenticationCode(for: string.data(using: .utf8)!, using: key)
                                //                                print(signature)
                                
                                let baseurl = myURL! + myLogon
                                let user = (username.lowercased())
                                print(user)
                                let pass = "&password="
                                //                                let token = HMAC<SHA256>.authenticationCode(for: uidpwdCombined.data(using: .utf8)!, using: key)
                                
                                //                                let hashString = token.compactMap { String(format: "%02x", $0) }.joined()
                                //MARK: TOKEN FIX CAPITAL LOGIN ISSUE
                                let tokenURL = baseurl + user + pass + stringPWD //= password
                                //                                let tokenURL = baseurl + user + pass + hashString //= token
                                
                                print(tokenURL)
                                
                                AF.request((tokenURL) as URLConvertible,
                                           method: .get,
                                           parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                            "Accept": "application/json",
                                            "Content-Type": "application/json",
                                            "Connection" : "keep-alive"
                                            //                                            "Keep-Alive" : "timeout=5"
                                           ]
                                )
                                .responseData {response in
                                    
                                    switch response.result {
                                        
                                    case .success(let value):
                                        
                                        
                                        let statusCode = response.response?.statusCode
                                        
                                        if statusCode == 502 {
                                            
                                            defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                            defaults.set("Yup", forKey: "ShowForgotPassword")
                                            
                                            //TODO: DEMO LOGIN
                                            if isDemoSelected == true {
                                                
                                                defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                                                defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                                defaults.set("Yup", forKey: "ShowForgotPassword")
                                                
                                            } else {
                                                defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                                                defaults.set("https://cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                                defaults.set("Yup", forKey: "ShowForgotPassword")
                                                
                                            }
                                            
                                            self.buttonBackColorProd = Color.colorCardiGray
                                            self.buttonBackColor = Color.colorCardiGray
                                            
                                            let myURL = defaults.string(forKey: "myPortal")
                                            
                                            print(userpwd)
                                            print(user)
                                            
                                            if myURL == nil {
                                                defaults.set("NO", forKey: "callServiceTickets")
                                                self.presentingAlert = true
                                            } else {
                                                
                                                let credentialData = "\(username):\(userpwd)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                                                
                                                let base64Credentials = credentialData.base64EncodedString()
                                                
                                                AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                                    "Authorization": "Basic \(base64Credentials)",
                                                    
                                                    "Accept": "application/json",
                                                    "Content-Type": "application/json",
                                                    "Connection" : "keep-alive"
                                                ]
                                                )
                                                .responseData {response in
                                                    
                                                    let statusCode = response.response?.statusCode
                                                    
                                                    if statusCode == 401 {
                                                        
                                                        print("LOGIN: ⛔️")
                                                        
                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                        self.buttonBackColor = Color.colorCardiGray
                                                        
                                                        defaults.set("NO", forKey: "callServiceTickets")
                                                        self.presentingAlert = true
                                                        
                                                        authenticationDidSucceed = false
                                                        authenticationDidFail = true
                                                    } else{
                                                        
                                                        switch response.result {
                                                            
                                                        case .success( _):
                                                            authenticationDidSucceed = true
                                                            authenticationDidFail = false
                                                            print("LOGIN: ✅")
                                                            
                                                            self.buttonBackColorProd = Color.colorCardiGray
                                                            self.buttonBackColor = Color.colorCardiGray
                                                            
                                                            if authenticationDidSucceed {
                                                                if self.auth.login(email: self.username, password: self.userpwd) {
                                                                    defaults.set("OLD", forKey: "Backend")
                                                                    getUserData()
                                                                }
                                                            }
                                                        case .failure(let error):
                                                            print(error)
                                                            print("LOGIN: ⛔️")
                                                            
                                                            self.buttonBackColorProd = Color.colorCardiGray
                                                            self.buttonBackColor = Color.colorCardiGray
                                                            
                                                            defaults.set("NO", forKey: "callServiceTickets")
                                                            self.presentingAlert = true
                                                            
                                                            authenticationDidSucceed = false
                                                            authenticationDidFail = true
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            
                                        } else {
                                            
                                            let json = JSON(value)
                                            print(json)
                                            
                                            if json.count == 0 {
                                                print("jsonprint(json)")
                                            }
                                            
                                            for (index,_):(String, JSON) in json {
                                                switch index {
                                                case "data":
                                                    let dataCode = json["data"]
                                                    print("data: ", dataCode)
                                                    
                                                    
                                                case "success":
                                                    
                                                    let success1 = json["success"].rawValue
                                                    print("success: ", success1)
                                                    
                                                    
                                                    
                                                    if success1 as! Bool == true {
                                                        
                                                        defaults.set("NO", forKey: "WaitForIt")
                                                        defaults.set("NO", forKey: "WaitForItOverview")
                                                        
                                                        
                                                        defaults.set("NEW", forKey: "Backend")
                                                        let dataString = json["data"].rawValue
                                                        print("DATASTRING: ", dataString)
                                                        print("username: ", username)
                                                        
                                                        
                                                        defaults.set(username, forKey: "DataUIDUser")
                                                        defaults.set("NEW", forKey: "Backend")
                                                        defaults.set(dataString, forKey: "DATASTRING")
                                                        authenticationDidSucceed = true
                                                        
                                                        if authenticationDidSucceed {
                                                            if self.auth.login(email: self.username, password: self.userpwd) {
                                                                self.buttonBackColorProd = Color.colorCardiGray
                                                                self.buttonBackColor = Color.colorCardiGray
                                                                
                                                                getUserData()
                                                                
                                                            }
                                                        }
                                                        
                                                    }
                                                    
                                                case "error":
                                                    
                                                    let error = json["error"]
                                                    print("error: ", error)
                                                    
                                                    if error == "Password is incorrect" {
                                                        
                                                        defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                                        defaults.set("Yup", forKey: "ShowForgotPassword")
                                                        
                                                        //TODO: DEMO LOGIN
                                                        if isDemoSelected == true {
                                                            
                                                            defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                                                            defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                                            defaults.set("Yup", forKey: "ShowForgotPassword")
                                                            
                                                        } else {
                                                            defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                                                            defaults.set("https://cardi-link.cloud/", forKey: "myPortalPasswordProd")
                                                            defaults.set("Yup", forKey: "ShowForgotPassword")
                                                            
                                                        }
                                                        
                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                        self.buttonBackColor = Color.colorCardiGray
                                                        
                                                        let myURL = defaults.string(forKey: "myPortal")
                                                        
                                                        print(userpwd)
                                                        print(user)
                                                        
                                                        if myURL == nil {
                                                            defaults.set("NO", forKey: "callServiceTickets")
                                                            self.presentingAlert = true
                                                        } else {
                                                            
                                                            let credentialData = "\(username):\(userpwd)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                                                            
                                                            let base64Credentials = credentialData.base64EncodedString()
                                                            
                                                            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                                                "Authorization": "Basic \(base64Credentials)",
                                                                
                                                                "Accept": "application/json",
                                                                "Content-Type": "application/json",
                                                                "Connection" : "keep-alive"
                                                            ]
                                                            )
                                                            .responseData {response in
                                                                
                                                                let statusCode = response.response?.statusCode
                                                                
                                                                if statusCode == 401 {
                                                                    
                                                                    print(error)
                                                                    print("LOGIN: ⛔️")
                                                                    
                                                                    self.buttonBackColorProd = Color.colorCardiGray
                                                                    self.buttonBackColor = Color.colorCardiGray
                                                                    
                                                                    defaults.set("NO", forKey: "callServiceTickets")
                                                                    self.presentingAlert = true
                                                                    
                                                                    authenticationDidSucceed = false
                                                                    authenticationDidFail = true
                                                                } else{
                                                                    
                                                                    switch response.result {
                                                                        
                                                                    case .success( _):
                                                                        authenticationDidSucceed = true
                                                                        authenticationDidFail = false
                                                                        print("LOGIN: ✅")
                                                                        
                                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                                        self.buttonBackColor = Color.colorCardiGray
                                                                        
                                                                        if authenticationDidSucceed {
                                                                            if self.auth.login(email: self.username, password: self.userpwd) {
                                                                                defaults.set("OLD", forKey: "Backend")
                                                                                getUserData()
                                                                            }
                                                                        }
                                                                    case .failure(let error):
                                                                        print(error)
                                                                        print("LOGIN: ⛔️")
                                                                        
                                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                                        self.buttonBackColor = Color.colorCardiGray
                                                                        
                                                                        defaults.set("NO", forKey: "callServiceTickets")
                                                                        self.presentingAlert = true
                                                                        
                                                                        authenticationDidSucceed = false
                                                                        authenticationDidFail = true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    
                                                case "errorCode":
                                                    print("errorCode")
                                                    
                                                    let errorCode = json["errorCode"]
                                                    print("ERROR: ", errorCode)
                                                    print("Invalid User")
                                                    if errorCode == 90 {
                                                        
                                                        //TODO: DEMO LOGIN
                                                        if isDemoSelected == true {
                                                            
                                                            defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                                                            
                                                        } else {
                                                            defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                                                            
                                                        }
                                                        
                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                        self.buttonBackColor = Color.colorCardiGray
                                                        
                                                        //MARK: TRY OLD
                                                        
                                                        
                                                        let myURL = defaults.string(forKey: "myPortal")
                                                        
                                                        if myURL == nil {
                                                            defaults.set("NO", forKey: "callServiceTickets")
                                                            self.presentingAlert = true
                                                        } else {
                                                            
                                                            let credentialData = "\(username):\(userpwd)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                                                            
                                                            let base64Credentials = credentialData.base64EncodedString()
                                                            
                                                            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                                                "Authorization": "Basic \(base64Credentials)",
                                                                
                                                                "Accept": "application/json",
                                                                "Content-Type": "application/json",
                                                                "Connection" : "keep-alive"
                                                            ]
                                                            )
                                                            .responseData {response in
                                                                
                                                                let statusCode = response.response?.statusCode
                                                                //                                                                    print(statusCode)
                                                                
                                                                if statusCode == 401 {
                                                                    
                                                                    print("LOGIN: ⛔️")
                                                                    
                                                                    self.buttonBackColorProd = Color.colorCardiGray
                                                                    self.buttonBackColor = Color.colorCardiGray
                                                                    
                                                                    defaults.set("NO", forKey: "callServiceTickets")
                                                                    self.presentingAlert = true
                                                                    
                                                                    authenticationDidSucceed = false
                                                                    authenticationDidFail = true
                                                                } else{
                                                                    
                                                                    switch response.result {
                                                                        
                                                                        
                                                                    case .success( _):
                                                                        authenticationDidSucceed = true
                                                                        authenticationDidFail = false
                                                                        print("LOGIN: ✅")
                                                                        
                                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                                        self.buttonBackColor = Color.colorCardiGray
                                                                        
                                                                        if authenticationDidSucceed {
                                                                            if self.auth.login(email: self.username, password: self.userpwd) {
                                                                                defaults.set("OLD", forKey: "Backend")
                                                                                getUserData()
                                                                                //MARK: NKTEST
                                                                                //                                                getNKData()
                                                                            }
                                                                        }
                                                                    case .failure(let error):
                                                                        print(error)
                                                                        print("LOGIN: ⛔️")
                                                                        
                                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                                        self.buttonBackColor = Color.colorCardiGray
                                                                        
                                                                        defaults.set("NO", forKey: "callServiceTickets")
                                                                        self.presentingAlert = true
                                                                        
                                                                        authenticationDidSucceed = false
                                                                        authenticationDidFail = true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    
                                                default:
                                                    print("456")
                                                }
                                            }
                                        }
                                        //MARK: NKTEST FAIL
                                    case .failure(let error):
                                        print(error)
                                        print("LOGIN: ⛔️⛔️⛔️⛔️")
                                        
                                        //TODO: DEMO LOGIN
                                        if isDemoSelected == true {
                                            
                                            defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                                            
                                        } else {
                                            defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                                            
                                        }
                                        
                                        self.buttonBackColorProd = Color.colorCardiGray
                                        self.buttonBackColor = Color.colorCardiGray
                                        
                                        //MARK: TRY OLD
                                        
                                        
                                        let myURL = defaults.string(forKey: "myPortal")
                                        
                                        if myURL == nil {
                                            defaults.set("NO", forKey: "callServiceTickets")
                                            self.presentingAlert = true
                                        } else {
                                            
                                            let credentialData = "\(username):\(userpwd)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                                            
                                            let base64Credentials = credentialData.base64EncodedString()
                                            
                                            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                                "Authorization": "Basic \(base64Credentials)",
                                                
                                                "Accept": "application/json",
                                                "Content-Type": "application/json",
                                                "Connection" : "keep-alive"
                                            ]
                                            )
                                            .responseData {response in
                                                
                                                let statusCode = response.response?.statusCode
                                                //                                                                    print(statusCode)
                                                
                                                if statusCode == 401 {
                                                    
                                                    print("LOGIN: ⛔️")
                                                    
                                                    self.buttonBackColorProd = Color.colorCardiGray
                                                    self.buttonBackColor = Color.colorCardiGray
                                                    
                                                    defaults.set("NO", forKey: "callServiceTickets")
                                                    self.presentingAlert = true
                                                    
                                                    authenticationDidSucceed = false
                                                    authenticationDidFail = true
                                                } else{
                                                    
                                                    switch response.result {
                                                        
                                                        
                                                    case .success( _):
                                                        authenticationDidSucceed = true
                                                        authenticationDidFail = false
                                                        print("LOGIN: ✅")
                                                        
                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                        self.buttonBackColor = Color.colorCardiGray
                                                        
                                                        if authenticationDidSucceed {
                                                            if self.auth.login(email: self.username, password: self.userpwd) {
                                                                defaults.set("OLD", forKey: "Backend")
                                                                getUserData()
                                                                //MARK: NKTEST
                                                                //                                                getNKData()
                                                            }
                                                        }
                                                    case .failure(let error):
                                                        print(error)
                                                        print("LOGIN: ⛔️")
                                                        
                                                        self.buttonBackColorProd = Color.colorCardiGray
                                                        self.buttonBackColor = Color.colorCardiGray
                                                        
                                                        defaults.set("NO", forKey: "callServiceTickets")
                                                        self.presentingAlert = true
                                                        
                                                        authenticationDidSucceed = false
                                                        authenticationDidFail = true
                                                    }
                                                }
                                            }
                                        }
                                        //                                        }
                                        
                                    }
                                    //TODO: MAKE MESSAG IN CASE OF BACKEND FAILLURE
                                    
                                    print("LOGIN: ⛔️ ⛔️ ⛔️    ⛔️")
                                    
                                    
                                    //                                        defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                                    //
                                    //                                        self.buttonBackColorProd = Color.colorCardiGray
                                    //                                        self.buttonBackColor = Color.colorCardiGray
                                    //
                                    //                                        //MARK: TRY OLD
                                    //
                                    //
                                    //                                        let myURL = defaults.string(forKey: "myPortal")
                                    //
                                    //                                        if myURL == nil {
                                    //                                            defaults.set("NO", forKey: "callServiceTickets")
                                    //                                            self.presentingAlert = true
                                    //                                        } else {
                                    //
                                    //                                            let credentialData = "\(username):\(userpwd)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                                    //
                                    //                                            let base64Credentials = credentialData.base64EncodedString()
                                    //
                                    //                                            AF.request((myURL!) as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
                                    //                                                "Authorization": "Basic \(base64Credentials)",
                                    //
                                    //                                                "Accept": "application/json",
                                    //                                                "Content-Type": "application/json"
                                    //                                            ]
                                    //                                            )
                                    //                                                .responseData {response in
                                    //
                                    //                                                    switch response.result {
                                    //
                                    //                                                    case .success( _):
                                    //                                                        authenticationDidSucceed = true
                                    //                                                        authenticationDidFail = false
                                    //                                                        print("LOGIN: ✅")
                                    //
                                    //                                                        self.buttonBackColorProd = Color.colorCardiGray
                                    //                                                        self.buttonBackColor = Color.colorCardiGray
                                    //
                                    //                                                        if authenticationDidSucceed {
                                    //                                                            if self.auth.login(email: self.username, password: self.userpwd) {
                                    //                                                                defaults.set("OLD", forKey: "Backend")
                                    //                                                                getUserData()
                                    //                                                                //MARK: NKTEST
                                    //                                                                //                                                getNKData()
                                    //                                                            }
                                    //                                                        }
                                    //                                                    case .failure(let error):
                                    //                                                        print(error)
                                    //                                                        print("LOGIN: ⛔️")
                                    //
                                    //                                                        self.buttonBackColorProd = Color.colorCardiGray
                                    //                                                        self.buttonBackColor = Color.colorCardiGray
                                    //
                                    //                                                        defaults.set("NO", forKey: "callServiceTickets")
                                    //                                                        self.presentingAlert = true
                                    //
                                    //                                                        authenticationDidSucceed = false
                                    //                                                        authenticationDidFail = true
                                    //                                                    }
                                    //                                                }
                                    //                                        }
                                    
                                    
                                }
                            }
                            
                            
                        }
                    };UIApplication.shared.endEditing()
                }
                
            }.frame(width: 300, height: 50, alignment: .trailing)
                .padding(.top, 45)
                .padding(.leading, 20.0)
            
            HStack {
                
                Button(action: {
                    defaults.set("NO", forKey: "callServiceTickets")
                    isShowingPassword = true
                }) {
                    VStack {
                        Text("Forgot your password?")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.colorCardiRed)
                    }
                    .sheet(isPresented: $isShowingPassword) {
                        ForgotPassword(isShowingPassword: self.$isShowingPassword)
                    }
                }.padding(.top, 25)
                
                
                
            }
            
            //            .onAppear {
            //            print("ContentView appeared!")
            //            }
        }
        .alert(isPresented: $presentingAlert) { () -> Alert in
            Alert(title: Text("Invalid Login Info"),
                  message: Text("Please make sure you have entered the correct login information or make sure you have selected a portal."))
            
            
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            print("Moving to the background!")
            self.buttonBackColorProd = Color.colorCardiGray
            self.buttonBackColor = Color.colorCardiGray
            
            //            let fileManager = FileManager.default
            
            //            let filenameService = getDocumentsDiretory().appendingPathComponent("service.json")
            //            let filenameRed = getDocumentsDiretory().appendingPathComponent("redData.json")
            //            let filenameYellow = getDocumentsDiretory().appendingPathComponent("yellowData.json")
            //            let filenameGreen = getDocumentsDiretory().appendingPathComponent("greenData.json")
            //            let filenameCommNK = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
            //            let filenameGreenNK = getDocumentsDiretory().appendingPathComponent("NKgreenData.json")
            //            let filenameGeo = getDocumentsDiretory().appendingPathComponent("latlon.json")
            //    let filenameService = getDocumentsDiretory().appendingPathComponent("service.json")
            //    let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            //            do {
            //                try fileManager.removeItem(at: filenameService)
            //                try fileManager.removeItem(at: filenameRed)
            //                try fileManager.removeItem(at: filenameYellow)
            //                try fileManager.removeItem(at: filenameGreen)
            //                try fileManager.removeItem(at: filenameGreenNK)
            //                try fileManager.removeItem(at: filenameCommNK)
            //                try fileManager.removeItem(at: filenameGeo)
            
            //            } catch {
            //                clearGreen()
            //                clearGeo()
            //                return
            //            }
            //        }
        }
    }
}
}
func LoginFail() {
    
    let defaults = UserDefaults.standard
    
    defaults.set("", forKey: "DataUIDUser")
    defaults.set("", forKey: "DataPWDUser")
    print("NOP")
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
            .previewDevice("iPhone SE (1st generation)")
        LoginForm()
            .previewDevice("iPhone 13 Pro")
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
