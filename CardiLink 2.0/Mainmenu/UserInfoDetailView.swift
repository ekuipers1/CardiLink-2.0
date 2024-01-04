//
//  UserInfoDetailView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.09.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct UserInfoDetailView: View {
    
    let defaults = UserDefaults.standard
    @EnvironmentObject var navigationManager: NavigationManager
    @State var date = Date()
    @State private var emailAddress = ""
    @State private var userid = ""
    @State private var username = ""
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("userID") var userID: String?
    @AppStorage("userEmail") var userMail: String?
    @AppStorage("userTelephone") var userTelephone: String?
    @State private var editedTelephone: String = ""
    @State private var isTelephoneEdited: Bool = false
    @State private var userProfile = UserProfile(name: "", telephone: "", mobilePhone: "", telegramUsername: "", description: "", homepage: "")
    @State private var isSaveComplete = false
    @State private var alertMessage = ""
    
    func fetchUserProfile() {
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let finalURL = myURL! + "profile"
        AF.request(finalURL, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["success"].boolValue {
                    self.editedTelephone = json["data"]["mobilePhone"].stringValue
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveUserProfile() {
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let finalURL = myURL! + "profile"
        let parameters: [String: Any] = [
            "name" : userProfile.name,
            "telephone" : userProfile.telephone,
            "mobilePhone" : self.editedTelephone,
            "telegramUsername" : userProfile.telegramUsername,
            "description" : userProfile.description,
            "homepage" : userProfile.homepage
        ]
        AF.request(finalURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ])
        .responseJSON { response in
            switch response.result {
            case .success:
                self.isSaveComplete = true
                self.alertMessage = "Your data has been updated"
            case .failure(let error):
                self.alertMessage = "Failed to update data: \(error.localizedDescription)"
            }
        }
    }
    
    var body: some View {
        VStack {
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
                    Text("User profile")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                } .frame(width: widthInner)
                    .padding(.top,10)
            }.frame(height:60)
            
            VStack {
                VStack(alignment: .leading){
                    HStack(){
                        Image(systemName: "person.circle.fill")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.Cardi_Text_Inf)
                        Text(userOwner ?? "John Doe")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.regular)
                            .font(.title3)
                        Spacer()
                    }
                }.frame(width: widthInnerText, height: 100.0)
                
                HStack() {
                    Image(systemName: "envelope")
                        .fontWeight(.regular)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .frame(width: 30)
                    TextField("E-Mail Address:", text: Binding(
                        get: { self.userMail ?? "" },
                        set: { _ in }
                    ))
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }.frame(width: widthInnerText, height: 50.0)
                
                VStack() {
                    HStack() {
                        Image(systemName: "iphone")
                            .fontWeight(.regular)
                            .font(.title2)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .frame(width: 30)
                        
                        TextField("Telephone", text: $editedTelephone, onCommit: {
                            isTelephoneEdited = (userTelephone != editedTelephone)
                        })
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    } .padding(.bottom, 20)
                        .frame(width: widthInnerText, height: 50.0)
                }
            } .padding(.top, 40)
            
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    saveUserProfile()
                }) {
                    HStack {
                        Text("Save")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(width: 100, height: 20.0)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }
                Spacer()
            }
            .padding(.bottom, 20)
            .padding(.horizontal)
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 40.0)
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear {
            fetchUserProfile()
        }
        .alert(isPresented: $isSaveComplete) {
            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveTelephone() {
        userTelephone = editedTelephone
    }
    
    func timeString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct UserProfile: Codable {
    var name: String
    var telephone: String
    var mobilePhone: String
    var telegramUsername: String
    var description: String
    var homepage: String
    
}
