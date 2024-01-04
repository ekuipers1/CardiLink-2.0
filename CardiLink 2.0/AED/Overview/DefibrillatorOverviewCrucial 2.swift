//
//  DefibrillatorOverviewCrucial.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//

import SwiftUI

//MARK: CrucialInfo
struct CrucialInfo: View{
    @State private var showButtons = false
    
    @AppStorage("activationsDateBattery") var activationsDateBattery: String?
    @AppStorage("experationDateElectrodes") var experationDateElectrodes: String?
    
    @AppStorage("SIMsignalStrength") var SIMsignalStrength: String?
    @AppStorage("SIMsignalQuality") var SIMsignalQuality: String?
    
    var basebutton: CGFloat = 0
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        let basebutton: CGFloat = 100
        let texButtonTwo: CGFloat = 80
        let texButtonThree: CGFloat = 85
        
        HStack(spacing: 18){
            VStack(){
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                        .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    //                .frame(width: 110, height: 120)
                        .frame(width: basebutton, height: 120)
                    HStack(spacing: 5){
                        
                        
                        Button(action:
                                {  }) {
                            NavigationLink(destination: DefibrillatorHardware()) {
                                
                                
                                VStack(alignment: .leading){
                                    HStack(){
                                        Text("Battery expiration")
                                            .font(.body)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width:  texButtonTwo, height: 50)
                                            .offset(x: 2, y: 5)
                                            .minimumScaleFactor(0.8)
                                        
                                    }
                                    
                                    HStack(){
                                        
                                        Text("\(activationsDateBattery ?? "September 16 2026")")
                                        //                                Text("September 2024")
                                            .font(.callout)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: texButtonTwo + 10, height: 70)
                                            .offset(x: 2, y: -5)
                                    }
                                }
                            }.simultaneousGesture(TapGesture().onEnded{
                                gethardwaredata()
                            })
                        }
                    }.offset(x: 5)
                    //                    }
                } .padding(.top, 50.0)
                
            }
            
            VStack(){
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                        .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    //                .frame(width: 110, height: 120)
                        .frame(width: basebutton, height: 120)
                    HStack(spacing: 5){
                        
                        Button(action:
                                {  }) {
                            NavigationLink(destination: DefibrillatorHardware()) {
                                
                                
                                VStack(alignment: .leading){
                                    HStack(){
                                        Text("Electrodes expiration")
                                            .font(.body)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width:  texButtonTwo + 10, height: 50)
                                            .offset(x: 2, y: 5)
                                            .minimumScaleFactor(0.8)
                                        
                                    }
                                    
                                    HStack(){
                                        
                                        
                                        Text("\(experationDateElectrodes ?? "N/A")")
                                            .font(.callout)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: texButtonTwo + 10, height: 70)
                                        //                    .frame(width: 90, height: 70)
                                            .offset(x: 2, y: -5)
                                    }
                                }
                            }.simultaneousGesture(TapGesture().onEnded{
                                gethardwaredata()
                            })
                        }
                    } .offset(x: 5)
                    
                    
                    //                    }
                } .padding(.top, 50.0)
                
            } .offset(x: -5)
            
            VStack(){
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                        .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    //                    .frame(width: 110, height: 120)
                        .frame(width: basebutton, height: 120)
                    
                    HStack(spacing: 5){
                        
                        Button(action:
                                {  }) {
                            NavigationLink(destination: CommSimCard()) {
                                
                                
                                
                                VStack(alignment: .leading){
                                    HStack(){
                                        Text("Signal Strength")
                                            .font(.body)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width:  texButtonThree, height: 50)
                                        //                            .frame(width: 85, height: 50)
                                            .offset(x: 5, y: -5)
//                                            .minimumScaleFactor(2)
                                        
                                    }
                                    VStack(alignment: .leading){
                                        Text("\(SIMsignalQuality ?? "N/A")")
                                        
                                            .font(.callout)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: texButtonTwo + 10, height: 20)
                                            .offset(x: 0, y: -5)
                                        
                                        VStack(alignment: .leading){
                                            HStack(){
                                                Text("\(SIMsignalStrength ?? "N/A")")
                                                    .font(.callout)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                    .fontWeight(.regular)
                                                    .offset(x: 8, y: -8)
                                                Image(systemName: "chart.bar.fill")
                                                    .font(.callout)
                                                //      .frame(width: 20.0, height: 30.0)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                    .offset(x: 2, y: -8)
                                                Image(systemName: "simcard")
                                                    .font(.callout)
                                                //      .frame(width: 20.0, height: 30.0)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                    .offset(x: 2, y: -8)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } .padding(.top, 50.0)
                
            }.offset(x: -10)
            
        }
        .offset(x: 2)
        
    }
}
