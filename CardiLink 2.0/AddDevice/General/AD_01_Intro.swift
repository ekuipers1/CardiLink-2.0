//
//  AD_01_Intro.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 02.11.22.
//

import SwiftUI

struct AD_01_Intro: View {

    @State private var show = false
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @AppStorage("ble_state") var bleState: String!
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("myPortal") var myPortal: String?
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                
                HeaderStart(title: "AED Activation".localized)
                
            }
            
            Text("Hi," + " " + (userOwner ?? "..."))
                .font(.headline)
                .foregroundColor(Color.Cardi_Text_Inf)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.leading, 15.0)
                .padding(.top, 20.0)
            
            
            Text("Let’s get started activating your AED. \n\nIn the following process you need:")
                .foregroundColor(Color.Cardi_Text_Inf)
                .frame(height: 180)
                .padding(.leading, 15)
            
            HStack(){
                Image(systemName: "1.circle")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.5), value: show)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .cornerRadius(50)
                
                Text("AED (ready for operation).")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.5), value: show)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
            }
            HStack(){
                Image(systemName: "2.circle")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.7), value: show)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .cornerRadius(50)
                
                Text("AED serial number.")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.7), value: show)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
            }
            HStack(){
                
                Image(systemName: "3.circle")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.9), value: show)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .cornerRadius(50)
                
                Text("CardiLink HeartConnect (Optional).")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(0.9), value: show)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
            }
            HStack(){
                Image(systemName: "4.circle")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.1), value: show)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .cornerRadius(50)
                
                Text("Details about the installation location of your AED.")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.1), value: show)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
            }
            HStack(){
                Image(systemName: "5.circle")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.3), value: show)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .cornerRadius(50)
                
                Text("Information about the public availability of your AED.")
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.3), value: show)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
            }
            Spacer()
            HStack() {
                Text("I am ready, let’s start.")
                    .font(.headline)
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.5), value: show)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 15.0)
                
                Spacer()

                let buttonView = Image(systemName: "arrow.right")
                    .padding(.trailing, 15.0)
                    .opacity(show ? 1 : 0)
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.Calming_Green)

                switch myPortal {
                case "https://nihon-kohden.cardi-link.cloud/api/",
                     "https://nihon-kohden.demo.cardi-link.cloud/api/",
                     "https://nihon-kohden.test.cardi-link.cloud/api/":
                    Button(action: {
                        navigationManager.push(.NKserialType)
                    }) {
                        buttonView
                    }.animation(.easeIn.delay(1.5), value: show)

                case "https://vivest.cardi-link.cloud/api/",
                     "https://vivest.test.cardi-link.cloud/api/":
                    Button(action: {
                        navigationManager.push(.serialTypeVivest)
                    }) {
                        buttonView
                    }.animation(.easeIn.delay(1.5), value: show)

                case "https://primedic.cardi-link.cloud/api/",
                    "https://primedic.test.cardi-link.cloud/api/":
                    Button(action: {
                        navigationManager.push(.adSerialSelectPrimedic)
                    }) {
                        buttonView
                    }.animation(.easeIn.delay(1.5), value: show)
                    
                    
                case "https://cardiaint.cardi-link.cloud/api/",
                    "https://cardiaint.test.cardi-link.cloud/api/":
                    Button(action: {
                        navigationManager.push(.adSerialSelect)
                    }) {
                        buttonView
                    }.animation(.easeIn.delay(1.5), value: show)

                default:
                    Button(action: {
                        navigationManager.push(.adSerialSelect)
                    }) {
                        buttonView
                    }.animation(.easeIn.delay(1.5), value: show)
                }
            }
        } .frame(width:width)
            .onAppear {
                show = true }
            .navigationBarHidden(true)
            .navigationBarHidden(true)
 
    }
}

