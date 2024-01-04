//
//  CommSimCard.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.03.21.
//

import SwiftUI

struct CommSimCard: View {
    
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
                            
                            //                            UserDefaults.standard.set("N/A", forKey: "harwareModel")
                            //                            UserDefaults.standard.set("N/A", forKey: "harwareLanguage")
                            //                            UserDefaults.standard.set("N/A", forKey: "hardwareBatchID")
                            //                            UserDefaults.standard.set("N/A", forKey: "harwareProddate")
                            //                            UserDefaults.standard.set("N/A", forKey: "serialPCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "batchPCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "manufacturerPCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "hardwarePCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
                            //                            UserDefaults.standard.set("N/A", forKey: "modelBattery")
                            //                            UserDefaults.standard.set("N/A", forKey: "batchBattery")
                            //                            UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                            //                            UserDefaults.standard.set("N/A", forKey: "addressBLE")

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
                        Text("SIM Card")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
//                            .fontWeight(.bold)
//                            .font(.title2)
//                            .foregroundColor(Color.black)
//                            .padding(.trailing, 110.0)
                    }
                    .padding(.top, 60.0)
                    .padding(.bottom, 30)
//                    .padding(.top, 20.0)
//                    .frame(width: 350, height: 70)
                }
            }
            .frame(width: 450, height: 100)
//            .frame(width: 450, height: 120)
            
            ZStack(){
                
                ScrollView {
                    
                    let defaults = UserDefaults.standard
                    let backend = defaults.string(forKey: "Backend")
                    
                    if backend == "NEW" {
                        comMainInfo()
                            .padding(.top, 20.0)
                        commhardwareSIMDataNK()
                            .padding(.top, 20.0)
//                            .padding(.top, 20.0)
//                            .padding(.top, 20.0)
                        Spacer()
                    }else {
                        comMainInfo()
                            .padding(.top, 20.0)
                        commhardwareSIMData()
                            .padding(.top, 20.0)
                            .padding(.top, 20.0)
                            .padding(.top, 20.0)
                        Spacer()
                    }
                    

                }
                
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}


struct CommSimCard_Previews: PreviewProvider {
    static var previews: some View {
        CommSimCard()
    }
}


struct commhardwareSIMDataNK: View {
    
    @AppStorage("SIMserial") var SIMserial: String?
    @AppStorage("SIMoperator") var SIMoperator: String?
    @AppStorage("SIMcountryCode") var SIMcountryCode: String?
    @AppStorage("SIMnetworkCode") var SIMnetworkCode: String?
    
    @AppStorage("SIMsignalStrength") var SIMsignalStrength: String?
    @AppStorage("SIMsignalQuality") var SIMsignalQuality: String?
//    @AppStorage("SIMCardActive") var SIMCardActive: String?
//    @AppStorage("SIMCarddeliveryDateSIM") var SIMCarddeliveryDateSIM: String?
//    @AppStorage("myPortal") var myPortal: String?

    
    @State private var presentingSheet = false
//    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("SIM Card Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("SIM card Id:")
                            HStack(){
                                Image(systemName: "simcard")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(SIMserial ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile network operator (MNO):")
                        HStack(){
                            Image(systemName: "phone.circle")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMoperator ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile country code (MCC):")
                        HStack(){
                            Image(systemName: "globe")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMcountryCode ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile network code (MNC):")
                        HStack(){
                            Image(systemName: "barcode")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMnetworkCode ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Signal strength:")
                        HStack(){
                            Image(systemName: "dot.radiowaves.left.and.right")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMsignalStrength ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Signal quality:")
                        HStack(){
                            Image(systemName: "antenna.radiowaves.left.and.right")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMsignalQuality ?? "N/A")
                            
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

struct commhardwareSIMData: View {
    
    @AppStorage("SIMCardid") var SIMCardid: String?
    @AppStorage("SIMCardactivationCode") var SIMCardactivationCode: String?
    @AppStorage("SIMCardphoneNumber") var SIMCardphoneNumber: String?
    @AppStorage("SIMCardIPAddress") var SIMCardIPAddress: String?
    @AppStorage("SIMCardActive") var SIMCardActive: String?
    @AppStorage("SIMCarddeliveryDateSIM") var SIMCarddeliveryDateSIM: String?

    
    
    @AppStorage("myPortal") var myPortal: String?

    
    @State private var presentingSheet = false
//    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("SIM Card Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("SIM Id: ")
                            HStack(){
                                Image(systemName: "simcard")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(SIMCardid ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation code:")
                        HStack(){
                            Image(systemName: "barcode")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMCardactivationCode ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation status:")
                        HStack(){
                            Image(systemName: "arrow.left.arrow.right.circle")//.foregroundColor(.colorCardiGray)

                            let longtext = SIMCardActive

                            let returntext_CleanUp = longtext?.replacingOccurrences(of: "success(", with: "")
                            let returntext_CleanUp2 = returntext_CleanUp?.replacingOccurrences(of: ")", with: "")
                            let finalStatus = returntext_CleanUp2?.replacingOccurrences(of: "\"", with: "")
                            
                            
                            if finalStatus == "notactivated" {
                                SwiftUI.Text("Not Activated")

                            }
   
                            if finalStatus == "ready" {
                                SwiftUI.Text("Ready")
                                    .foregroundColor(Color.colorCardiOrange)
                            }
                            
                            if finalStatus == "test" {
                                SwiftUI.Text("Test")
                                    .foregroundColor(Color.colorCardiOrange)
                            }
                            
                            if finalStatus == "live" {
                                SwiftUI.Text("Live")
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                            
                            if finalStatus == "suspend" {
                                SwiftUI.Text("Suspended")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            
                            if finalStatus == "bar" {
                                SwiftUI.Text("Bar")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            
                            if finalStatus == "unknown" {
                                SwiftUI.Text("Unknown")

                            }
                            if finalStatus == "terminated" {
                                SwiftUI.Text("Terminated")
                                    .foregroundColor(Color.Calming_Green)
                                
                            }
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation date:")
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(SIMCarddeliveryDateSIM ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation URL:")
                        HStack(){
                            Image(systemName: "link")//.foregroundColor(.colorCardiGray)
                            
                                let myURL = myPortal
                                let sim = "activation?"
                                let theone =  SIMCardactivationCode ?? ""
                                let url = myURL! + sim + theone
                            
                            
                            if theone == "" {
                                SwiftUI.Text("Unavailable")
                            } else {
                            Link(url, destination: URL(string: url)!)
                            }
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
