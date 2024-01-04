//
//  DefibrillatorOverviewBattery.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//

import SwiftUI

struct BatteryStatus: View{
    @State private var showButtons = false
    @AppStorage("batteryLevel") var batteryLevel: String?
    @AppStorage("defridetailAdminStatusValue") var defridetailAdminStatusValue: String?
    @AppStorage("defridetailAdminStatusColor") var defridetailAdminStatusColor: Int?
    @AppStorage("commHardwarebatteryPercentage") var commHardwarebatteryPercentage: String?
    
    var basebutton: CGFloat = 0
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        let basebutton: CGFloat = 98
        let texButtonOne: CGFloat = 80
        
        HStack(spacing: 18){
            VStack(){
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                        .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                        .frame(width: basebutton, height: 120)
                    HStack(spacing: 5){
                        Button(action:
                                {  }) {
                            NavigationLink(destination: AED_Hardware()) {
                                VStack(alignment: .center){
                                    HStack(){
                                        HStack(spacing: -20){
                                            Image(systemName: "bolt.heart.fill")
                                                .font(.title)
                                                .frame(width: 40.0, height: 40.0)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                            Spacer()
                                            let percentBattery = Int(batteryLevel ?? "0") ?? 0
                                            switch percentBattery {
                                            case 0...10:
                                                Image("battery_0")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                            case 11...37:
                                                Image("battery_25")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                            case 38...64:
                                                Image("battery_50")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                            case 65...89:
                                                Image("battery_75")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                            case 90...100:
                                                Image("battery_100")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                            default:
                                                Image(systemName: "battery.25")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40,
                                                           height: 40)
                                                    .foregroundColor(Color.black)
                                            }
                                        } .frame(width: basebutton - 20, height: 40)
                                    }
                                    HStack(){
                                        Text(batteryLevel ?? "N/A")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                        + Text(" %")
                                            .fontWeight(.bold)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }
                                    .frame(width:texButtonOne + 10, height: 70)
                                } .offset(x: 5, y: 5)
                            }.simultaneousGesture(TapGesture().onEnded{
                                gethardwaredata()
                            })
                        }
                    }
                }
            } .offset(x: 5)
            VStack(){
                ZStack(alignment: .leading){
                    let whatStatusImage = defridetailAdminStatusColor
                    switch whatStatusImage {
                    case 0:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Calming_Green)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.white)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 1:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cardi_Yellow)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "calendar.badge.exclamationmark")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.Cardi_Text)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 2:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.colorCardiRed)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "stop.circle.fill")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.white)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 3:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cardi_Yellow)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.Cardi_Text)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 4:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.colorCardiRed)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "xmark.octagon.fill")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.white)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 5:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.colorCardiGray)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "antenna.radiowaves.left.and.right.slash")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.white)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    case 6:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cadri_BLE)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "wrench.and.screwdriver")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.white)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    default:
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.colorCardiGray)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            VStack(alignment: .center){
                                HStack(){
                                    HStack(spacing: -20){
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.largeTitle)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.black)
                                    } .frame(width: basebutton - 20, height: 40)
                                }
                                Text(defridetailAdminStatusValue ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(width:texButtonOne + 10, height: 70)
                            } .offset(x: 5, y: 5)
                        }
                    }
                }
            } .offset(x: 5)
            
            
            let whatStatusImage = defridetailAdminStatusColor
            if whatStatusImage == 6{
            } else {
                
                VStack(){
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.Cardi_Text)
                            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                            .frame(width: basebutton, height: 120)
                        HStack(spacing: 5){
                            Button(action:
                                    {  }) {
                                NavigationLink(destination: CommHardware()) {
                                    VStack(alignment: .center){
                                        HStack(){
                                            HStack(spacing: -20){
                                                Image(systemName: "antenna.radiowaves.left.and.right")
                                                    .font(.title)
                                                    .frame(width: 40.0, height: 40.0)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                Spacer()
                                                let percentBattery = Int(commHardwarebatteryPercentage ?? "N/A") ?? 0
                                                switch percentBattery {
                                                case 0...10:
                                                    Image("battery_0")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                case 11...37:
                                                    Image("battery_25")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                case 38...64:
                                                    Image("battery_50")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                case 65...89:
                                                    Image("battery_75")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                case 90...100:
                                                    Image("battery_100")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                default:
                                                    Image(systemName: "battery.25")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40,
                                                               height: 40)
                                                        .foregroundColor(Color.black)
                                                }
                                                
                                            } .frame(width: basebutton - 20, height: 40)
                                        }
                                        HStack(){
                                            Text(commHardwarebatteryPercentage ?? "N/A")
                                                .fontWeight(.bold)
                                                .font(.headline)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                            + Text(" %")
                                                .fontWeight(.bold)
                                                .font(.headline)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                        }
                                        .frame(width:texButtonOne + 10, height: 70)
                                        
                                    } .offset(x: 5, y: 5)
                                }.simultaneousGesture(TapGesture().onEnded{
                                    getCommhardwaredata()
                                })
                            }
                        }
                    }
                }   .offset(x: 5)
            }
        }
        .onAppear {
            getCommhardwaredata()
        }
        .offset(x: -5, y: 0)
    }
}
