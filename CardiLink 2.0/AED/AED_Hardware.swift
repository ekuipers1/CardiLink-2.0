//
//  AED_Hardware.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 25.09.23.
//

import SwiftUI

struct AED_Hardware: View {
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("dashboardState") var dashboardState: String?
    
    var body: some View {
        VStack(){
            
            ZStack(){
                
                let defaults = UserDefaults.standard
                let backend = defaults.string(forKey: "Backend")
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
                        Button(action:{
                            LoadMyData()
                            self.presentationMode.wrappedValue.dismiss()
                            UserDefaults.standard.set("N/A", forKey: "harwareModel")
                            UserDefaults.standard.set("N/A", forKey: "harwareLanguage")
                            UserDefaults.standard.set("N/A", forKey: "hardwareBatchID")
                            UserDefaults.standard.set("N/A", forKey: "harwareProddate")
                            UserDefaults.standard.set("N/A", forKey: "hardwareActicatonDate")
                            UserDefaults.standard.set("N/A", forKey: "serialPCB")
                            UserDefaults.standard.set("N/A", forKey: "batchPCB")
                            UserDefaults.standard.set("N/A", forKey: "manufacturerPCB")
                            UserDefaults.standard.set("N/A", forKey: "hardwarePCB")
                            UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                            UserDefaults.standard.set("N/A", forKey: "productionDatePCB")
                            UserDefaults.standard.set("N/A", forKey: "modelElectrodes")
                            UserDefaults.standard.set("N/A", forKey: "batchElectrodes")
                            UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                            
                            UserDefaults.standard.set("N/A", forKey: "modelBattery")
                            UserDefaults.standard.set("N/A", forKey: "batchBattery")
                            UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                            UserDefaults.standard.set("N/A", forKey: "addressBLE")
                        }){
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .padding(.leading, 100.0)
                        Text(" Hardware ")
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
                    defiMainInfo()
                        .padding(.top, 20.0)
                    hardwareBaseData()
                        .padding(.top, 20.0)
                    hardwarePCBData()
                        .padding(.top, 20.0)
                    hardwareElectrodesData()
                        .padding(.top, 20.0)
                    hardwareBatteryDataNK()
                        .padding(.top, 20.0)
                    hardwareBLE()
                        .padding(.top, 20.0)
                        .padding(.bottom, 60.0)
                    Spacer()
                }
                
            }
            
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


