//
//  PortalSelector.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 29.08.23.
//

import SwiftUI

struct PortalSelector: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State var date = Date()
    var portalInfoArray: [PortalInfo]
    @AppStorage("username") var username: String?
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    var body: some View {
        NavigationView {
            VStack(){
                ZStack {
                    MainBackgroundNew()
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading){
                        HStack() {
                            VStack(alignment: .leading) {
                                Text(greeting())
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text(username ?? "...")
                                    .fontWeight(.thin)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text("\(timeString(date: date))")
                                    .fontWeight(.thin)
                            }
                            Spacer()
                        }
                    }.frame(width: widthInnerText, height: 60)
                        .offset(x: 0, y: 25)
                }
                .frame(width: width, height: 100)
                
                List() {
                    ScrollView{
                        Section {
                            ForEach(navigationManager.portalInfoArray, id: \.url) { portal in
                                Button(action: {
                                    let apiUrl = portal.url + "api/"
                                    UserDefaults.standard.set(apiUrl, forKey: "myPortal")
                                    UserDefaults.standard.set(portal.token, forKey: "DATASTRING")
                                    UserDefaults.standard.set(portal.imageLogoUrl, forKey: "imageLogoUrlKey")
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
                                    UserDefaults.standard.set(portal.url, forKey: "Environment")
                                    GetData()
                                    navigationManager.navigateTo(.dashboard)
                                }) {
                                    VStack(alignment: .leading) {
                                        ZStack(alignment: .bottom){
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.Cardi_Portal]), startPoint: .leading, endPoint: .trailing))
                                                .opacity(0.7)
                                                .frame(width: widthInner, height: 110.0)
                                            Base_Landscape(yOffset: 1.8)
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.colorCardiOrange]), startPoint: .trailing, endPoint: .leading))
                                                .shadow(radius: 4, y: 4)
                                                .frame(width: widthInner, height: 35)
                                                .scaleEffect(x: -1, y: -1)
                                            HStack(){
                                                Spacer()
                                                if let imageLogoUrl = URL(string: portal.imageLogoUrl) {
                                                    AsyncImage(url: imageLogoUrl) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 250, height: 100)
                                                            .offset(x: -10, y: -18)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                } else {
                                                    Image(systemName: "photo")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 250, height: 100)
                                                }
                                                Spacer()
                                                ZStack(alignment: .bottom) {
                                                    Rectangle()
                                                        .fill(Color.clear)
                                                        .frame(width: 75, height: 110)
                                                    Text(environmentTypeString(from: portal.environmentType))
                                                        .font(.system(size: 18))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color.Cardi_Text)
                                                        .offset(y: -10)
                                                }
                                            }.frame(width: widthInner - 10, height: 110.0)
                                        }
                                    }
                                }
                                .background(Color.clear)
                            }.padding(.bottom, 20)
                            Spacer()
                        }
                    }
                }.frame(width: widthList + 20)
                    .padding(.top, 10)
                    .padding(.bottom, 0)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                BottomMenuPortal()
            }.navigationBarHidden(true)
        }
    }
}

func environmentTypeIcon(from type: Int) -> some View {
    let icon: String
    let color: Color
    
    switch type {
    case 0:
        icon =  "globe.desk.fill"
        color = Color.Calming_Green
    case 1:
        icon =  "wrench.and.screwdriver.fill"
        color = Color.colorCardiRed
    case 2:
        icon =  "eye.fill"
        color = Color.Cardi_MapBlue
    default:
        icon =  "questionmark"
        color = Color.Cardi_Yellow
    }
    return Image(systemName: icon)
        .font(.system(size: 24, weight: .medium))
        .foregroundColor(color)
}

private func environmentTypeString(from type: Int) -> String {
    switch type {
    case 0:
        return ""
    case 1:
        return "Test"
    case 2:
        return "Demo"
    default:
        return "Unknown"
    }
}






