//
//  SettingsView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 12.09.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack {
            ZStack {
                MainBackgroundNew()
                VStack(alignment: .leading) {
                    Text("Settings")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                } .frame(width: widthInnerText)
                    .padding(.top,10)
            }.frame(height:60)
            VStack(spacing: 0) {
                Button(action: {
                    navigationManager.push(.visualview)
                }) {
                    VStack(){
                        HStack(){
                            Image(systemName: "circle.righthalf.filled")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width: 30)
                            Text("Appearance")
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
                .padding(.top, 40.0)
                .frame(width: widthInnerText, height: 150.0)
                .background(Color.clear, in: RoundedRectangle(cornerRadius: 20))
                HStack(){
                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }) {
                        HStack(){
                            Image(systemName: "globe")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width: 30)
                            Text("Language")
                                .foregroundColor(.Cardi_Text_Inf)
                                .font(.title3)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontWeight(.regular)
                                .font(.title3)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width: 30)
                                .padding(.top, 5)
                        }
                    }
                    .frame(width: widthInnerText, height: 50.0)
                    .background(Color.clear, in: RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
                BottomNavigationBar()
                    .frame(height: 0)
                    .padding(.top, 40.0)
            }
            .padding(.horizontal)
        }
    }
}
