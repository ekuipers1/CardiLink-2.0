//
//  ForgotPassword.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.03.21.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var isShowingPassword: Bool
    let gradient = Gradient(colors: [Color.colorCardiOrange, .white])
    var body: some View {
        VStack() {
            ZStack(alignment: .top){
                Rectangle()
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    .frame(width: 500, height: 300)
                    .edgesIgnoringSafeArea(.top
                    )
                TopLeft()
                MidCenter()
                Topright()
                Spacer()
                Password()
            }
        }.background(Color.white)
    }
}

struct Password: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(){
            Text("Forgot your password?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.vertical, 50.0)
            Text("Please visit the online portal to get a new password or use the below ITSM link")
                .padding(40.0)
                .padding(.bottom, 20.0)
                .foregroundColor(Color.black)
            Text("IT Service Management CardiLink")
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            Link("https://cardilink.atlassian.net/servicedesk/customer/portal/1", destination: URL(string: "https://cardilink.atlassian.net/servicedesk/customer/portal/1")!)
                .padding(.horizontal, 30.0)
                .padding(.bottom, 20.0)
                .foregroundColor(Color.Cardi_MapBlue)
            Spacer()
            Button(action: {self.presentation.wrappedValue.dismiss()}) {
                Text("Dismiss")
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .foregroundColor(Color.white)
                    .background(Color.colorCardiRed)
                    .cornerRadius(15)
            }
            Spacer()
            Text("CardiLink 2.0 Version: \(Bundle.main.appVersionShort!) \(Bundle.main.appVersionLong!)")
                .fontWeight(.light)
                .font(.footnote)
                .foregroundColor(Color.colorCardiGray)
                .multilineTextAlignment(.trailing)
        }.padding(40.0)
    }
}
