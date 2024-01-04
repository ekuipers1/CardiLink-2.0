//
//  CommHardware.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 18.03.21.
//

import SwiftUI

struct CommHardware: View {
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(){
            
            ZStack(){
                MainBackground()
                    .padding(.top, 240.0)
//                TopViewBackround()
                    
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            
                            //Cleanup
                            
                            UserDefaults.standard.set("N/A", forKey: "commharwareModel")
                            UserDefaults.standard.set("N/A", forKey: "commassemblyDate")
                            UserDefaults.standard.set("N/A", forKey: "hardwareBatchID")
                            UserDefaults.standard.set("N/A", forKey: "commactiveSince")
                            
                            UserDefaults.standard.set("N/A", forKey: "commserialPCB")
                            UserDefaults.standard.set("N/A", forKey: "commfinaldeliveryDatePCB")
                            
                            
                            UserDefaults.standard.set("N/A", forKey: "commBatteryBatch")
                            UserDefaults.standard.set("N/A", forKey: "commBatteryVoltage")
                            UserDefaults.standard.set("N/A", forKey: "commactivationsDateBattery")
                            
                            UserDefaults.standard.set("N/A", forKey: "commHardwarefirmwareVersion")
                            UserDefaults.standard.set("N/A", forKey: "commHardwarebatteryPercentage")
                            UserDefaults.standard.set("N/A", forKey: "commHardwarelot")
                            UserDefaults.standard.set("N/A", forKey: "GPSAntennasAttached")
                            
                            UserDefaults.standard.set("N/A", forKey: "commbootupStatus")
                            UserDefaults.standard.set("N/A", forKey: "commbluetoothChipset")
                            UserDefaults.standard.set("N/A", forKey: "commbluetoothMacAddress")
    
                            
                        }){
                            
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
//                                .padding(.trailing, 40.0)
                        }
                        .padding(.leading, 100.0)

                        Text("Hardware")
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
            .frame(width: 450, height: 100)
            
            ZStack(){
                
                ScrollView {
                    
                    let defaults = UserDefaults.standard
                    let backend = defaults.string(forKey: "Backend")
                    
                    if backend == "NEW" {
                    
                    
                    comMainInfo()
                        .padding(.top, 20.0)
                    commhardwareBaseDataNK()
                        .padding(.top, 20.0)
                    commInternalChecks()
                        .padding(.top, 20.0)
                        .padding(.bottom, 60.0)
                    Spacer()
                    } else {
                        
                        comMainInfo()
                            .padding(.top, 20.0)
                        commhardwareBaseData()
                            .padding(.top, 20.0)
                        commhardwarePCBData()
                            .padding(.top, 20.0)
                        commhardwareBatteryData()
                            .padding(.top, 20.0)
                            .padding(.bottom, 60.0)
                        Spacer()
                    }
                }
            
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct CommHardware_Previews: PreviewProvider {
    static var previews: some View {
        CommHardware()
    }
}


//MARK: commhardwareBaseDataNK
struct commhardwareBaseDataNK: View {
    
    @AppStorage("commharwareModel") var commharwareModel: String?
    @AppStorage("commHardwarefirmwareVersion") var commHardwarefirmwareVersion: String?
    @AppStorage("commHardwarebatteryPercentage") var commHardwarebatteryPercentage: String?
    @AppStorage("commHardwarelot") var commHardwarelot: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Base Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Model")
                            HStack(){
                                Image(systemName: "greetingcard")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(commharwareModel ?? "N/A")
                                
                                
                            }
                            Divider().opacity(0)
                        }
//                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Firmware Version")
                        HStack(){
                            Image(systemName: "cube.transparent")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commHardwarefirmwareVersion ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Percentage")
                        HStack(){
                            Image(systemName: "minus.plus.batteryblock")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commHardwarebatteryPercentage ?? "N/A")
                            SwiftUI.Text("%")
                        }
                        Divider().opacity(0)
                    }
                    
                        VStack(alignment: .leading){
                            SwiftUI.Text("LOT")
                            HStack(){
                                Image(systemName: "number.square")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(commHardwarelot ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct commhardwareBaseData: View {
    
    @AppStorage("commharwareModel") var commharwareModel: String?
    @AppStorage("commassemblyDate") var commassemblyDate: String?
    @AppStorage("commactiveSince") var commactiveSince: String?
    @AppStorage("GPSAntennasAttached") var GPSAntennasAttached: Bool?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Base Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")//.foregroundColor(.colorCardiGray)
                                
                                let longtext = commharwareModel
                                let newone = longtext?.replacingOccurrences(of: "cloud.cardilink.communicator.models.", with: "")
                                
                                SwiftUI.Text(newone ?? "N/A")
                                
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Assembly Date:")
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commassemblyDate ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Active since:")
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commactiveSince ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        
                        HStack(){
                            Image(systemName: "antenna.radiowaves.left.and.right")//.foregroundColor(.colorCardiGray)
                            
                        
                        
                        if GPSAntennasAttached ?? true {
                            SwiftUI.Text("GPS antennas: attached")
                        } else {
                            SwiftUI.Text("GPS antennas: not attached")
                        }
                        }

                        Divider()//.foregroundColor(Color.Cardi_group)
                            .opacity(0)
//                        Divider().background(Color.Cardi_group)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}

//MARK: commInternalChecks
struct commInternalChecks: View {
    
    @AppStorage("commbootupStatus") var commbootupStatus: String?
    @AppStorage("commbluetoothChipset") var commbluetoothChipset: String?
    @AppStorage("commbluetoothMacAddress") var commbluetoothMacAddress: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Internal Checks") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            SwiftUI.Text("Bootup Status:")
                            if commbootupStatus == "true" {
                            
                            HStack(){
                                Image(systemName: "captions.bubble")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text("Success")
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            Divider().opacity(0)
                                
                            }else {
                                Divider().opacity(0)
                                HStack(){
                                    Image(systemName: "captions.bubble")//.foregroundColor(.colorCardiGray)
                                    SwiftUI.Text("Failed")
                                        .foregroundColor(Color.colorCardiRed)
                                    
                                }
                                Divider().opacity(0)
                                
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth chipset:")
                        if commbluetoothChipset == "true" {
   
                        HStack(){
                            Image(systemName: "memorychip")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text("Success")
                                .foregroundColor(Color.Calming_Green)
                        }
                        Divider().opacity(0)
                            
                        } else {
                            HStack(){
                                Image(systemName: "memorychip")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text("Failed")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            Divider().opacity(0)
                            
                        }
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth MAC address:")
                        
                        HStack(){
                            Image(systemName: "waveform")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commbluetoothMacAddress ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}




struct commhardwarePCBData: View {
    
    @AppStorage("commserialPCB") var commserialPCB: String?
    @AppStorage("commfinaldeliveryDatePCB") var commfinaldeliveryDatePCB: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("PCB Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Serial Number:")
                            HStack(){
                                Image(systemName: "greetingcard")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(commserialPCB ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Delivery Date:")
                        
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commfinaldeliveryDatePCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwareBatteryData: View {
    
    @AppStorage("commBatteryBatch") var commBatteryBatch: String?
    @AppStorage("commBatteryVoltage") var commBatteryVoltage: String?
    @AppStorage("commactivationsDateBattery") var commactivationsDateBattery: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Batch:")
                            HStack(){
                                Image(systemName: "cube.transparent")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(commBatteryBatch ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Voltage:")
                        HStack(){
                            Image(systemName: "minus.plus.batteryblock")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commBatteryVoltage ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation Date:")
                        
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commactivationsDateBattery ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}


