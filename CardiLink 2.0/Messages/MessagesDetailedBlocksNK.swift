//
//  MessagesDetailedBlocksNK.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.11.21.
//

import Foundation
import SwiftUI
import MapKit


struct messSelfTestDailyNK: View {
    
    @AppStorage("message_selfTestResult") var message_selfTestResult: String?
    @AppStorage("message_bateryErrors") var message_bateryErrors: String?
    @AppStorage("message_redErrors") var message_redErrors: String?
    @AppStorage("message_warnings") var message_warnings: String?
    @AppStorage("message_aedVisibileOnBluetooth") var message_aedVisibileOnBluetooth: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Test Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Self Test Result:")
                            HStack(){
                                Image(systemName: "text.badge.checkmark")
                                SwiftUI.Text(message_selfTestResult ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Errors:")
                        HStack(){
                            Image(systemName: "battery.0")
                            if message_bateryErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Red Errors:")
                        HStack(){
                            Image(systemName: "stop.circle")
                            if message_redErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Warnings:")
                        HStack(){
                            Image(systemName: "exclamationmark.triangle")
                            if message_warnings == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("AED visible on bluetooth")
                        HStack(){
                            Image(systemName: "waveform")
                            if message_aedVisibileOnBluetooth == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                                
                            }
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct messSyncDefNK: View {
    
    @AppStorage("message_padExpirationDate") var message_defibrillatorTimestamp: String?
    @AppStorage("message_defibrillatorModel") var message_defibrillatorModel: String?
    @AppStorage("message_defibrillatorMacAddress") var message_defibrillatorBluetoothMACAddress: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("AED Information") {
                VStack {
                    Group {
                        
                        Divider().opacity(0)
                        
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Pads until")
                        HStack(){
                            Image(systemName: "heart.text.square")
                            Text(message_defibrillatorTimestamp ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("AED Model")
                        HStack(){
                            Image(systemName: "greetingcard")
                            SwiftUI.Text(message_defibrillatorModel ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("AED MAC Address")
                        HStack(){
                            Image(systemName: "number")
                            SwiftUI.Text(message_defibrillatorBluetoothMACAddress ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messBatteryInfoNK: View {
    
    @AppStorage("message_batteryModel") var message_batteryModel: String?
    @AppStorage("message_batterySerialNumber") var message_batterySerialNumber: String?
    @AppStorage("message_mainBatteryExpirationDate") var message_mainBatteryExpirationDate: String?
    @AppStorage("message_activationDate") var message_activationDate: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery Information") {
                VStack {
                    Group {
                        
                        Divider().opacity(0)
                        
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Model")
                        HStack(){
                            Image(systemName: "greetingcard")
                            Text(message_batteryModel ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Serial Number")
                        HStack(){
                            Image(systemName: "number")
                            Text(message_batterySerialNumber ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery until")
                        HStack(){
                            Image(systemName: "calendar.badge.exclamationmark")
                            Text(message_mainBatteryExpirationDate ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation Date")
                        HStack(){
                            Image(systemName: "calendar.badge.plus")
                            Text(message_activationDate ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messMovementNK: View {
    
    @AppStorage("message_lat") var message_lat: String?
    @AppStorage("message_lng") var message_lng: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Geo location") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Latitude:")
                            HStack(){
                                Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                                SwiftUI.Text(message_lat ?? "")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Longitude:")
                        HStack(){
                            Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")
                            SwiftUI.Text(message_lng ?? "")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messMapDataNK: View {

    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 00.100, longitude: 00.100),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @AppStorage("message_lat") var message_lat: String?
    @AppStorage("message_lng") var message_lng: String?
    
    var body: some View {
        
        let myDoubleLat = Double(message_lat ?? "")
        let myDoubleLon = Double(message_lng ?? "")
        if myDoubleLat == nil {
            
            let places = [
                Place(name: "No Data Available", latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100)
            ]
            
            Map(coordinateRegion: $coordinateRegion, interactionModes: [], annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    
                    VStack(){
                        HStack(){
                            Image(systemName: "xmark.octagon.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130,
                                       height: 130)
                                .foregroundColor(.colorCardiRed)
                        }
                        Text("No Data Available")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color.colorCardiRed)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
                    
                }
                
            }.frame(width: 300, height: 320, alignment: .center)
                .cornerRadius(25)
                .shadow(radius: 5, y: 5)
                .opacity(0.5)
            
        } else {
            
            let places = [
                Place(name: "" , latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820)
            ]
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))), annotationItems: places) { place in
                
                MapAnnotation(coordinate: place.coordinate) {
                    
                    VStack(){
                        HStack(){
                            Image(systemName: "bolt.heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,
                                       height: 30)
                                .foregroundColor(Color.Map_Calming_Green)
                        }
                        Text("")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color.Cardi_MapBlue)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
                    
                }
                
            }.frame(width: 310, height: 220, alignment: .center)
                .cornerRadius(25)
                .shadow(radius: 5, y: 5)
            
        }
    }
}

struct messPairingNK: View {
    
    
    @AppStorage("message_success") var message_success: String?
    @AppStorage("message_pairedCommunicatorSerial") var message_pairedCommunicatorSerial: String?
    @AppStorage("message_pairedDefibrillatorSerial") var message_pairedDefibrillatorSerial: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Paired devices Information") {
                VStack {
                    Group {
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(){
                            Text("Pairing Successful")
                                .fontWeight(.bold)
                                .font(.body)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 15.0)
                            
                            if message_success == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            
                        }
                        Divider().opacity(0)
                            .padding(.trailing)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Communicator Serial")
                        HStack(){
                            Image(systemName: "number")
                            Text(message_pairedCommunicatorSerial ?? "N/A")
                        }
                        Divider().opacity(0)
                    }

                    VStack(alignment: .leading){
                        SwiftUI.Text("AED Serial")
                        HStack(){
                            Image(systemName: "number")
                            Text(message_pairedDefibrillatorSerial ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct messMobileNK: View {
    
    @AppStorage("message_mno") var message_mno: String?
    @AppStorage("message_mcc") var message_mcc: String?
    @AppStorage("message_signalStrength") var message_signalStrength: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Mobile Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Mobile network operator (MNO):")
                            HStack(){
                                Image(systemName: "simcard")
                                SwiftUI.Text(message_mno ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile Country Code (MCC):")
                        HStack(){
                            Image(systemName: "globe")
                            SwiftUI.Text(message_mcc ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Signal Strength:")
                        HStack(){
                            Image(systemName: "waveform")
                            
                            let longtext = message_signalStrength
                            let newoneText = longtext?.replacingOccurrences(of: "-", with: "")
                            let percentBattery = Int(newoneText ?? "N/A") ?? 0
                            
                            switch percentBattery {
                            case 0...66:
                                Text("Excellent")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            case 66 ..< 76:
                                Text("Good")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Yellow)
                            case 76 ..< 86:
                                Text("Fair")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiOrange)
                            case 86 ..< 96:
                                Text("Poor")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed50)
                            case 96 ..< 1000:
                                Text("No Signal")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            default:
                                Text("Unknown")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messBootNK: View {
    
    @AppStorage("message_imei") var message_imei: String?
    @AppStorage("message_imsi") var message_imsi: String?
    @AppStorage("message_bluetoothMACAddress") var message_bluetoothMACAddress: String?
    @AppStorage("message_bluetoothChipsetStatus") var message_bluetoothChipsetStatus: Bool?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Bootup Information") {
                VStack {
                    Group {
                        
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("IMEI: ")
                        HStack(){
                            Image(systemName: "key")
                            SwiftUI.Text(message_imei ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("IMSI: ")
                        HStack(){
                            Image(systemName: "key")
                            SwiftUI.Text(message_imsi ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth Chipset Status:")
                        HStack(){
                            Image(systemName: "memorychip")
                            
                            if message_bluetoothChipsetStatus == true {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            }
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth MAC Address:")
                        HStack(){
                            Image(systemName: "number")
                            SwiftUI.Text(message_bluetoothMACAddress ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messErrorNK: View {
    
    @AppStorage("message_category") var message_category: String?
    @AppStorage("message_message") var message_message: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Error Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Category:")
                            HStack(){
                                Image(systemName: "menucard")
                                SwiftUI.Text(message_category ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Message:")
                        HStack(){
                            Image(systemName: "note.text")
                            SwiftUI.Text(message_message ?? "N/A")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(Color.colorCardiRed)
                            
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messSelfTestMonthNK: View {
    
    @AppStorage("message_selfTestResult") var message_selfTestResult: String?
    @AppStorage("message_bateryErrors") var message_bateryErrors: String?
    @AppStorage("message_redErrors") var message_redErrors: String?
    @AppStorage("message_warnings") var message_warnings: String?
    @AppStorage("message_aedVisibileOnBluetooth") var message_aedVisibileOnBluetooth: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Test Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Self Test Result:")
                            HStack(){
                                Image(systemName: "text.badge.checkmark")
                                SwiftUI.Text(message_selfTestResult ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Error")
                        HStack(){
                            Image(systemName: "battery.0")
                            if message_bateryErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Red Error")
                        HStack(){
                            Image(systemName: "stop.circle")
                            if message_redErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Warnings:")
                        HStack(){
                            Image(systemName: "exclamationmark.triangle")
                            if message_warnings == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("AED visible on bluetooth")
                        HStack(){
                            Image(systemName: "waveform")
                            if message_aedVisibileOnBluetooth == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                                
                            }
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct messSelfTestYearNK: View {
    
    @AppStorage("message_selfTestResult") var message_selfTestResult: String?
    @AppStorage("message_bateryErrors") var message_bateryErrors: String?
    @AppStorage("message_redErrors") var message_redErrors: String?
    @AppStorage("message_warnings") var message_warnings: String?
    @AppStorage("message_aedVisibileOnBluetooth") var message_aedVisibileOnBluetooth: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Test Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Self Test Result:")
                            HStack(){
                                Image(systemName: "text.badge.checkmark")
                                SwiftUI.Text(message_selfTestResult ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Error")
                        HStack(){
                            Image(systemName: "battery.0")
                            if message_bateryErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Red Error")
                        HStack(){
                            Image(systemName: "stop.circle")
                            if message_redErrors == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Warnings:")
                        HStack(){
                            Image(systemName: "exclamationmark.triangle")
                            if message_warnings == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("AED visible on bluetooth")
                        HStack(){
                            Image(systemName: "waveform")
                            if message_aedVisibileOnBluetooth == "1" {
                                let motion = "Yes".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.Calming_Green)
                            } else {
                                let motion = "No".localized
                                Text(motion)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(Color.colorCardiRed)
                                
                            }
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 290)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 320)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}
