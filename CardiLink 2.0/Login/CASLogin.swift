//
//  CASLogin.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 29.08.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import Foundation


struct CASLogin: View {
    
    @State private var userID: String = ""
    @State private var password: String = ""
    @State private var isRememberMe: Bool = false
    @State private var isPasswordVisible: Bool = false
    @State private var errorMessage: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var selectedEnvironment: String = "Production"
    @State var isDemoSelected: Bool = false
    @State private var isShowingBLE: Bool = false
    @State private var isShowingPassword: Bool = false
    @AppStorage("savedUserID") private var savedUserID: String = ""
    @AppStorage("savedPassword") private var savedPassword: String = ""
    let defaults = UserDefaults.standard
    @State private var isLoading = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack  {
            MainBackground()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .frame(width: widthInner, height: 650)
                .padding(.top, 90)
            VStack {
                Image("CardiLink-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 60.0)
                TextField("UserID", text: $userID)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.colorCardiGray, lineWidth: 1).frame(height: 40))
                    .foregroundColor(Color.black)
                    .textContentType(.emailAddress)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    .frame(width: widthInnerText, height: 20)
                    .onChange(of: userID) { _ in
                        if isRememberMe {
                            saveCredentials()
                        }
                    }
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .padding(.horizontal)
                            .foregroundColor(Color.black)
                            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.colorCardiGray, lineWidth: 1).frame(height: 40))
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            .onChange(of: password) { _ in
                                if isRememberMe {
                                    saveCredentials()
                                }
                            }
                    } else {
                        SecureField("Password", text: $password)
                            .padding(.horizontal)
                            .foregroundColor(Color.black)
                            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.colorCardiGray, lineWidth: 1).frame(height: 40))
                            .shadow(color: .gray, radius: 5, x: 0, y: 5) // Add this line
                            .onChange(of: password) { _ in
                                if isRememberMe {
                                    saveCredentials()
                                }
                            }
                    }
                    Spacer()
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(isPasswordVisible ? Color.black : Color.colorCardiGray)
                    }
                }
                .frame(width: widthInnerText, height: 20)
                .padding(.vertical)
                .padding()
                Toggle("Remember me", isOn: $isRememberMe)
                    .onChange(of: isRememberMe) { newValue in
                        if newValue {
                            saveCredentials()
                        } else {
                            removeSavedCredentials()
                            userID = ""
                            password = ""
                        }
                    }.foregroundColor(Color.black)
                    .toggleStyle(SwitchToggleStyle(tint: Color.colorCardiOrange))
                    .frame(width: widthInnerText, height: 50, alignment: .trailing)
                    .padding()
                Spacer()
                Button(action: {
                    isLoading = true
                    authenticateCAS() { (success, portalInfos) in
                        isLoading = false
                        if success {
                            if let portalInfos = portalInfos {
                                for portalInfo in portalInfos {
                                }
                            }
                            navigationManager.portalInfoArray = portalInfos ?? []
                            if let portalInfos = portalInfos, portalInfos.count == 1 {
                                let portal = portalInfos[0]
                                let apiUrl = portal.url + "api/"
                                UserDefaults.standard.set(apiUrl, forKey: "myPortal")
                                UserDefaults.standard.set(portal.token, forKey: "DATASTRING")
                                UserDefaults.standard.set(true, forKey: "OnePortal")
                                let environmentTypeString: String
                                switch portal.environmentType {
                                case 0:
                                    environmentTypeString = "Production"
                                case 1:
                                    environmentTypeString = "Test"
                                case 2:
                                    environmentTypeString = "Demo"
                                default:
                                    environmentTypeString = "Unknown"
                                }
                                UserDefaults.standard.set(environmentTypeString, forKey: "DemoProd")
                                UserDefaults.standard.set(true, forKey: "NoPortal")
                                navigationManager.navigateTo(.dashboard)
                                GetData()
                            } else {
                                UserDefaults.standard.set(false, forKey: "NoPortal")
                                navigationManager.navigateTo(.portalSelect)
                            }
                            UserDefaults.standard.set(userID, forKey: "username")
                            UserDefaults.standard.set(selectedEnvironment, forKey: "DemoProd")
                        } else {
                            showErrorAlert = true
                        }
                    }
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.colorCardiOrange)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: widthInnerTextButton, height: 20)
                Spacer()
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
                    }
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Login Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                checkAndFillSavedCredentials()
            }
            if isLoading {
                VStack {
                    ProgressView()
                        .foregroundColor(.Cardi_Text_Inf)
                    Text("Login in progress...")
                        .foregroundColor(.Cardi_Text_Inf)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 8)
                }
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.1)
                .glassMorphed()
            }
        }.onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
    
    private func saveCredentials() {
        savedUserID = userID
        savedPassword = password
    }
    
    private func removeSavedCredentials() {
        savedUserID = ""
        savedPassword = ""
    }
    
    private func checkAndFillSavedCredentials() {
        if !savedUserID.isEmpty && !savedPassword.isEmpty {
            userID = savedUserID
            password = savedPassword
            isRememberMe = true
        }
    }
    
    private func authenticateCAS(completion: @escaping (Bool, [PortalInfo]?) -> Void) {
        let userID = (self.userID.lowercased())
        func performRequest(index: Int, lastError: String? = nil) {
            let baseurl = "https://authentication.dev.cardi-link.cloud/auth/login?login="
            let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlTemplate = "BASEURLUSER&password=PASS"
            let urlLogin = urlTemplate.replacingOccurrences(of: "BASEURL", with: baseurl)
                .replacingOccurrences(of: "USER", with: userID)
                .replacingOccurrences(of: "PASS", with: encodedPassword)
            
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            var portalInfoArray = [PortalInfo]()
            AF.request(urlLogin, method: .get, headers: headers).response { response in
                if let statusCode = response.response?.statusCode, statusCode == 500 {
                    completion(false, nil)
                    return
                }
                switch response.result {
                case .success(let value):
                    let json = JSON(value as Any)
                    if let success = json["success"].bool, success {
                        if let dataArray = json["data"].array, !dataArray.isEmpty {
                            for dataDict in dataArray {
                                if let username = dataDict["username"].string,
                                   let url = dataDict["url"].string,
                                   let environment = dataDict["environment"].string,
                                   let token = dataDict["token"].string,
                                   let environmentType = dataDict["environmentType"].int,
                                   let imageLogoUrl = dataDict["imageLogoUrl"].string {
                                    let portalInfo = PortalInfo(username: username,
                                                                url: url,
                                                                environment: environment,
                                                                token: token,
                                                                environmentType: environmentType,
                                                                imageLogoUrl: imageLogoUrl)
                                    portalInfoArray.append(portalInfo)
                                }
                            }
                            completion(true, portalInfoArray)
                        } else {
                            completion(false, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(false, nil)
                }
            }
        }
        performRequest(index: 0)
    }
}

func GetData() {
    NotificationToken()
    fetchBaseCounters()
    getUserData()
    GrayNotMonitoredData()
}

struct PortalInfo {
    var username: String
    var url: String
    var environment: String
    var token: String
    var environmentType: Int
    var imageLogoUrl: String
}



func fetchBaseCounters() {
    
    let defaults = UserDefaults.standard
    let myURL = defaults.string(forKey: "myPortal")
    let AuthKey = defaults.string(forKey: "DATASTRING")
    let authKey = AuthKey!
    let myDefibrillators = "defibrillators/dashboardcounts"
    let url_defi = myURL! + myDefibrillators
    AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
        "authkey" : authKey,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Connection" : "keep-alive"
    ]
    )
    .responseData {response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            if json["success"].boolValue {
                let data = json["data"]
                let red = data["red"].intValue
                let green = data["green"].intValue
                let yellow = data["yellow"].intValue
                let gray = data["gray"].intValue
                let blue = data["blue"].intValue
                let withGPS = data["withGps"].intValue
                UserDefaults.standard.set(red, forKey: "red")
                UserDefaults.standard.set(green, forKey: "green")
                UserDefaults.standard.set(yellow, forKey: "yellow")
                UserDefaults.standard.set(gray, forKey: "gray")
                UserDefaults.standard.set(blue, forKey: "blue")
                UserDefaults.standard.set(withGPS, forKey: "withGps")
            }
        case .failure(let error):
            print(error)
        }
    }
}
