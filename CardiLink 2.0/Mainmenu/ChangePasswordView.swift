//
//  ChangePasswordView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 12.09.23.
//

import SwiftUI
import Alamofire


struct ChangePasswordView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var retypePassword: String = ""
    @State private var showOldPassword: Bool = true
    @State private var showNewPassword: Bool = true
    @State private var showRetypePassword: Bool = true
    @State private var showAlert = false  // Added for the alert
    @AppStorage("savedPassword") private var savedPassword: String = ""
    let defaults = UserDefaults.standard
    var passwordsMatch: Bool {
        return newPassword == retypePassword
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                MainBackgroundNew()
                    .edgesIgnoringSafeArea(.all)
                HStack() {
                    Button(action: {
                        navigationManager.pop()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Divider().opacity(0)
                    Text("Change password")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                } .frame(width: widthInner)
                    .padding(.top,10)
            }.frame(height:60)
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Old Password")
                    passwordField(title: "", text: $savedPassword, isSecure: $showOldPassword, isEditable: false)
                    Text("New Password")
                    passwordField(title: "", text: $newPassword, isSecure: $showNewPassword)
                    Text("Retype Password")
                    passwordField(title: "", text: $retypePassword, isSecure: $showRetypePassword)
                    if !passwordsMatch && !newPassword.isEmpty && !retypePassword.isEmpty {
                        Text("Please make sure the passwords match")
                            .foregroundColor(.colorCardiRed)
                            .frame(width: widthInnerText)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.01)
                    }
                    if containsIllegalCharacters(in: newPassword) {
                        Text("Your password contains illegal characters (#, +, &).")
                            .foregroundColor(.colorCardiRed)
                            .frame(width: widthInnerText)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.01)
                    }
                    Spacer()
                    if passwordsMatch && !newPassword.isEmpty && !retypePassword.isEmpty && !containsIllegalCharacters(in: newPassword) {
                        Button(action: {
                            self.showAlert = true
                        }) {
                            Text("Save New Password")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .offset(x: 0, y: -25)
                                .frame(width: widthInnerText)
                        }
                    }
                }
                .frame(width: widthInnerText)
                .padding(.top, 80)
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Password Updated"),
                          message: Text("Would you like to log in again for a fresh session or continue with the current session?"),
                          primaryButton: .default(Text("Log In Again"), action: {
                        changePassword(resetSession: true)
                        navigationManager.navigateTo(.login)
                        clearAllFile()
                        defaults.set(newPassword, forKey: "savedPassword")
                    }),
                          secondaryButton: .default(Text("Continue"), action: {
                        changePassword(resetSession: false)
                        navigationManager.navigateTo(.dashboard)
                        defaults.set(newPassword, forKey: "savedPassword")
                        
                    }))
                }
                BottomNavigationBar()
                    .frame(height: 0)
                    .padding(.top, 40.0)
            }
        }
    }
    
    func passwordField(title: String, text: Binding<String>, isSecure: Binding<Bool>, isEditable: Bool = true) -> some View {
        HStack {
            if isSecure.wrappedValue {
                SecureField(title, text: text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .disabled(!isEditable)
            } else {
                TextField(title, text: text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .disabled(!isEditable)
            }
            Button(action: {
                isSecure.wrappedValue.toggle()
            }) {
                Image(systemName: isSecure.wrappedValue ? "eye.slash" : "eye")
                    .foregroundColor(isSecure.wrappedValue ? Color.colorCardiRed : Color.Calming_Green)
            }
        }
    }
    
    func changePassword(resetSession: Bool) {
        
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let urlString: String
        if resetSession {
            urlString = myURL! + "login/ChangePassword?existingPassword=\(savedPassword)&newPassword=\(newPassword)&resetSession=true"
        } else {
            urlString = myURL! + "login/ChangePassword?existingPassword=\(savedPassword)&newPassword=\(newPassword)"
        }
        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .validate()
        .response { response in
            switch response.result {
            case .success:
                print("Password change successful!")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

func containsIllegalCharacters(in password: String) -> Bool {
    let illegalChars = ["#", "+", "&"]
    for char in illegalChars {
        if password.contains(char) {
            return true
        }
    }
    return false
}

