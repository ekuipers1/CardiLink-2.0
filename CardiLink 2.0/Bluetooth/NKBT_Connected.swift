//
//  NKBT_Connected.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 27.10.21.
//

import SwiftUI
import CoreBluetooth

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()


struct NKBT_Connected: View {
    
    @State var timeRemainingDemo = 1*10
    @State var timeRemaining = 3*60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var value = ""
    @State private var withOutline = ""
    @ObservedObject var textFieldManager = TextFieldManager()
    @ObservedObject var bleManager = BLEManager()
    
    @State var isLoading = false
    @State var on = false
    
    @AppStorage("bteName") var mynameis: String?
    @AppStorage("ConnectionSuccess") var donework: String!
    @AppStorage("connection_ble") var AEDpinOk: String!
    @AppStorage("DemoProd") var demoProd: String?
    
    var peripheral : CBPeripheral?
    
    var body: some View {
        ZStack {
            VStack() {
                if AEDpinOk == "True" {
                    MainBackgroundGreenNEW().edgesIgnoringSafeArea(.all)
                } else {
                    MainBackgroundRedNEW().edgesIgnoringSafeArea(.all)
                }
                
                VStack() {
                    
                    if demoProd == "Demo" || demoProd == "Test" {
                        
                        Text("\(timeString(time: timeRemainingDemo))")
                            .font(.system(size: 60))
                            .frame(height: 80.0)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .onReceive(timer) { _ in
                                if self.timeRemainingDemo > 0 {
                                    self.timeRemainingDemo -= 1
                                } else {
                                    self.timer.upstream.connect().cancel()
                                    self.presentation.wrappedValue.dismiss()
                                    if donework == "NO" {
                                        donework = "YES"
                                    }
                                }
                            }
                        
                    } else {
                        
                        Text("\(timeString(time: timeRemaining))")
                            .font(.system(size: 60))
                            .frame(height: 80.0)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .onReceive(timer) { _ in
                                if self.timeRemaining > 0 {
                                    self.timeRemaining -= 1
                                } else {
                                    self.timer.upstream.connect().cancel()
                                    self.presentation.wrappedValue.dismiss()
                                    if donework == "NO" {
                                        donework = "YES"
                                    }
                                }
                            }
                    }
                    
                    Text(donework == "NO" ? "Bluetooth Onboarding" : "Bluetooth Connected")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(donework == "NO" ? Color.black : Color.Cardi_Text_Inf)
                        .padding(.top, donework == "NO" ? 30.0 : 20.0)
                }
                
                ZStack() {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 5, y: 5)
                        .frame(width: 340, height: 400)
                    VStack(){
                        
                        Text(mynameis ?? "BLE Connection UID")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.top, 30.0)
                            .frame(width: 260)
                            .padding(.vertical, 10.0)
                        
                        if AEDpinOk == "True" {
                            
                            Text("The AED serial number is successfully verified.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.top, 30.0)
                                .frame(width: 260)
                                .padding(.vertical, 10.0)
                            
                        } else {
                            
                            Text("We're unable to confirm your AED serial number at the moment, but we'll keep trying.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.top, 30.0)
                                .frame(width: 260)
                            Text("If it is unsuccessful after 3 minutes please try again.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.vertical, 10.0)
                                .frame(width: 260)
                            
                        }
                        
                        if AEDpinOk == "True" {
                            
                            Button(action: {
                                UserDefaults.standard.set("False", forKey: "connection_ble")
                                UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
                                navigationManager.push(.adnkparingopencover)
                                
                            }) {
                                Text("Next")
                                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                    .foregroundColor(Color.white)
                                    .background(Color.Calming_Green)
                                    .cornerRadius(15)
                                
                            }
                            .padding(.top, 50.0)
                        }else {
                            
                            
                            if demoProd == "Demo" || demoProd == "Test"  {
                                
                                
                                Button(action: {
                                    navigationManager.navigateTo(.adnkparingopencover)
                                    AEDpinOk =  "false"
                                    donework = "NO"
                                }) {
                                    Text("FOR TESTING ONLY")
                                        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                        .foregroundColor(Color.white)
                                        .background(Color.Calming_Green)
                                        .cornerRadius(15)
                                    
                                }
                                
                            } else {
                                
                                Button(action: {
                                    UserDefaults.standard.set("False", forKey: "connection_ble")
                                    UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
                                    
                                    
                                    AEDpinOk =  "false"
                                    donework = "NO"
                                    navigationManager.pop()
                                    
                                    self.timer.upstream.connect().cancel()
                                    
                                }) {
                                    Text("Dismiss")
                                        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                        .foregroundColor(Color.white)
                                        .background(Color.colorCardiRed)
                                        .cornerRadius(15)
                                }
                                .padding(.top, 50.0)
                            }
                        }
                    }
                }.padding(.bottom, 100.0)
                
            }
            
            if donework == "NO" {
                
                MyLoadingView()
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

struct MyLoadingView: View {
    var body: some View {
        ZStack {
            
            Color.colorCardiGray
                .ignoresSafeArea()
                .opacity(0.8)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .colorCardiOrange))
                .scaleEffect(5)
        }
    }
}
