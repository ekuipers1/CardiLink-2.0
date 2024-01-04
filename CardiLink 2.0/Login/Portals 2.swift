//
//  Portals.swift
//  cardi-login
//
//  Created by Erik Kuipers on 12.01.21.
//

import SwiftUI

struct Portals: View {
    @Binding var isShowingPortal: Bool
    
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
                portalSelection(isShowingPortal: $isShowingPortal)
                    .padding(.top, 150.0)
            }
            Spacer()
        }
    }
}

struct portalSelection : View {
    let defaults = UserDefaults.standard
    @Binding var isShowingPortal: Bool
    
    var body: some View {
        
        VStack(spacing: 40){
            
            Button(action: {
                
                defaults.set("https://cardi-link.cloud/", forKey: "myPortal")
                print("Production")
                self.isShowingPortal.toggle()
            }) {
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    Text("Production")
                        .fontWeight(.thin)
                        .font(.title)
                        .frame(width: 140 , height: 30, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.colorCardiOrange)//Color.colorCardiOrange
                .cornerRadius(40)
                
            } .shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            Button(action: {
                defaults.set("https://demo.cardi-link.cloud/", forKey: "myPortal")
                print("Demo")
                self.isShowingPortal.toggle()
            }) {
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                    Text("Demo")
                        .fontWeight(.thin)
                        .font(.title)
                        .frame(width: 140 , height: 30, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.colorCardiGray)//colorCardiGray
                .cornerRadius(40)
                //                .frame(width: 300, height: 50)
            }.shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            Button(action: {
                defaults.set("https://qa1.cardilink.cloud/", forKey: "myPortal")
                print("QA1")
                self.isShowingPortal.toggle()
            }) {
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                    Text("QA1")
                        .fontWeight(.thin)
                        .font(.title)
                        .frame(width: 140 , height: 30, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.colorCardiGray)
                .cornerRadius(40)
                //                .frame(width: 300, height: 50)
            }.shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            
            Button(action: {
                defaults.set("https://qa2.cardilink.cloud/", forKey: "myPortal")
                print("QA2")
                self.isShowingPortal.toggle()
            }) {
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                    Text("QA2")
                        .fontWeight(.thin)
                        .font(.title)
                        .frame(width: 140 , height: 30, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.colorCardiGray)
                .cornerRadius(40)
            }.shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            
            Button(action: {
                print("QA3")
                defaults.set("https://qa3.cardilink.cloud/", forKey: "myPortal")
                //                defaults.set("https://qa3.cardilink.cloud/defibrillators", forKey: "myPortal")
                //                defaults.set("https://qa3.cardilink.cloud/communicators", forKey: "myPortal")
                self.isShowingPortal.toggle()
                
            }) {
                HStack {
                    Image(systemName: "network")
                        .font(.title)
                    
                    Text("QA3-Mob")
                        .fontWeight(.thin)
                        .font(.title)
                        .frame(width: 140 , height: 30, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.colorCardiGray)
                .cornerRadius(40)
            }.shadow(color: .gray, radius: 2, x: 0, y: 2)
        }
    }
}
