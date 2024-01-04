//
//  SelfTestMainMenuNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.21.
//

import SwiftUI

struct SelfTestMainMenuNK: View {
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fetcherSelftest = GetSelfTestData()
    @AppStorage("dashboardState") var dashboardState: String?
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    
    var body: some View {
        VStack(){
            ZStack(){
                let backroundColor = Int(dashboardState ?? "N/A") ?? 0
                switch backroundColor {
                case 0:
                    MainBackgroundGreen()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 1:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 2:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 3:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 4:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 5:
                    MainBackgroundGray()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                default:
                    MainBackground()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                }
                VStack(alignment: .leading){
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            UserDefaults.standard.set("YES", forKey: "activeMap")
                            UserDefaults.standard.set("NO", forKey: "selftestload")
                        }){
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .padding(.leading, 100.0)
                        Text("Self Tests")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
                    }
                    .padding(.top, 60.0)
                    .padding(.bottom, 30)
                }
            }
            .frame(width: 450, height: 120)
            Spacer()
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(fetcherSelftest.fetchSelfTestData) { myselftest in
                        ZStack() {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.white)
                                .padding(.horizontal, 5.0)
                                .shadow(color: .gray, radius: 5, y: 5)
                                .frame(width: 350, height: 140.0)
                            HStack(){
                                VStack (alignment: .leading) {
                                    HStack(){
                                        Image(systemName: "bolt.heart")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20,
                                                   height: 20)
                                            .foregroundColor(Color.black)
                                        Text(defridetailSerial ?? "N/A")
                                            .fontWeight(.bold)
                                            .font(.title3)
                                            .foregroundColor(Color.black)
                                        Text(myselftest.selfTestType?.localized ?? "..")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                            .foregroundColor(Color.black)
                                            .padding(.leading, 20.0)
                                    }
                                    HStack(){
                                        Text(myselftest.date ?? "N/A")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                            .foregroundColor(Color.black)
                                    }
                                    HStack(){
                                        Image(systemName: "minus.plus.batteryblock")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20,
                                                   height: 20)
                                            .foregroundColor(Color.black)
                                        VStack(){
                                            if (myselftest.hasBatteryError == "false") {
                                                Text("OK")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.Calming_Green)
                                            } else {
                                                Text("Error")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.colorCardiRed)
                                            }
                                        }
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20,
                                                   height: 20)
                                            .foregroundColor(Color.black)
                                        VStack(){
                                            if (myselftest.hasWarnings  == "false") {
                                                Text("Uncritical")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.Cardi_Yellow)
                                            } else {
                                                Text("No Warnings")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.Calming_Green)
                                            }
                                        }
                                        Image(systemName: "exclamationmark.octagon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20,
                                                   height: 20)
                                            .foregroundColor(Color.black)
                                        VStack(){
                                            if (myselftest.hasRedErrors  == "false") {
                                                Text("No Error")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.Calming_Green)
                                            } else {
                                                
                                                Text("Red Error")
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.colorCardiRed)
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(10.0)
                    }
                }
                Spacer()
                VStack(){
                    Image(systemName: "eye.slash")
                        .font(.title)
                        .frame(width: 40.0, height: 40.0)
                        .padding(.bottom, 30)
                    Text("This AED")
                        .fontWeight(.bold)
                        .font(.title3)
                    Text("has no Self Test")
                        .fontWeight(.bold)
                        .font(.title3)
                }.padding(.top, 100.0)
                
            }
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
