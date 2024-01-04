//
//  UserInfoView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.09.23.
//

import SwiftUI

struct UserInfoView: View {
    
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
    
    var body: some View {
        VStack {
            ZStack {
                MainBackgroundNew()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("User profile")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                } .frame(width: widthInnerText)
                    .padding(.top,10)
            }.frame(height:60)
            VStack {
                VStack(alignment: .leading){
                    Button(action: {
                        navigationManager.push(.userinfodetailview)
                    }) {
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
                            Image(systemName: "chevron.right")
                                .fontWeight(.regular)
                                .font(.title3)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width: 30)
                                .padding(.top, 5)
                        }
                    }.frame(width: widthInnerText, height: 50.0)
                        .background(Color.clear, in: RoundedRectangle(cornerRadius: 20))
                }.frame(width: widthInnerText, height: 100.0)
                Spacer()
                HStack(spacing: 0) {
                    Button(action: {
                        navigationManager.push(.changepwd)
                    }) {
                        VStack(){
                            HStack(){
                                Image(systemName: "lock.shield.fill")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                Text("Change Password")
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .fontWeight(.regular)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width: 30)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .frame(width: widthInnerText, height: 50.0)
                    .background(Color.clear, in: RoundedRectangle(cornerRadius: 20))
                }
            } .padding(.top, 140)
                .frame(width: widthInnerText, height: 50.0)
                .padding(.bottom, 20)
                .padding(.horizontal)
            Spacer()
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 40.0)
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear {
            editedTelephone = userTelephone ?? "N/A"
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
