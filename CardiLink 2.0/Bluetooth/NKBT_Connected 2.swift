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
    
    @State var timeRemaining = 3*60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var isNKBT_Connected: Bool
    @State private var value = ""
    @State private var withOutline = ""
    @ObservedObject var textFieldManager = TextFieldManager()
    @ObservedObject var bleManager = BLEManager()
    
    
    @State var isLoading = false
    @State var on = false
    
    @AppStorage("bteName") var mynameis: String?
    @AppStorage("ConnectionSuccess") var donework: String!
    @AppStorage("connection_ble") var AEDpinOk: String!
        
    var peripheral : CBPeripheral?

    
    var body: some View {
        ZStack {
            MainBackgroundBlue()

            VStack(){
                if donework == "NO" {
                    ZStack(){
                        MainBackgroundRed()
                        Spacer()
                        VStack(){
                            Text("\(timeString(time: timeRemaining))")
                                .font(.system(size: 60))
                                .frame(height: 80.0)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .onReceive(timer){ _ in
                                    if self.timeRemaining > 0 {
                                        self.timeRemaining -= 1
                                    }else{
                                        self.timer.upstream.connect().cancel()
                                        self.presentation.wrappedValue.dismiss()
                                    }
                                }
                            
                            
                            Text("Bluetooth Onboarding")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.top, 30.0)
                        }
                    }.edgesIgnoringSafeArea(.all)
                    
                } else {
                    ZStack(){
                        MainBackgroundGreen()
                        Spacer()
                        VStack(){
                            Text("\(timeString(time: timeRemaining))")
                                .font(.system(size: 60))
                                .frame(height: 80.0)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .onReceive(timer){ _ in
                                    if self.timeRemaining > 0 {
                                        self.timeRemaining -= 1
                                    }else{
                                        self.timer.upstream.connect().cancel()
                                        self.presentation.wrappedValue.dismiss()
                                    }
                                }
                            Text("Bluetooth Connected")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .padding(.top, 40.0)
                        }
                    }.edgesIgnoringSafeArea(.all)
                }
                Spacer()
                
                ZStack(){
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
                            
                            Text("We are unable to verify your AED serial number and will keep on trying.")
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
                                print("Disconnected : \(bleManager.peripheral?.name ?? "No Name")")
                                UserDefaults.standard.set("False", forKey: "connection_ble")
                                UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
                                
                                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                                
                            }) {
                                Text("Close")
                                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                    .foregroundColor(Color.white)
                                    .background(Color.Calming_Green)
                                    .cornerRadius(15)
                            }
                            .padding(.top, 50.0)
                        }else {
                            
                            Button(action: {
                                print("Disconnected : \(bleManager.peripheral?.name ?? "No Name")")
                                UserDefaults.standard.set("False", forKey: "connection_ble")
                                UserDefaults.standard.set("BLE Connection UID", forKey: "bteName")
                                
                                
                                self.timer.upstream.connect().cancel()
                                self.presentation.wrappedValue.dismiss()
                                
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
                .padding(.bottom, 50.0)
            }
            
            if donework == "NO" {
                
                MyLoadingView()
                
            }
        }
    }
    
    func timeString(time: Int) -> String {
        //        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

struct NKBT_Connected_Previews: PreviewProvider {
    @State private var isNKBT_Connected: Bool = true
    static var previews: some View {
        NKBT_Connected(isNKBT_Connected: .constant(true))
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
