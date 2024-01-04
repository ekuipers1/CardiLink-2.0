//
//  DefibrillatorOverviewSelfTest.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//


import SwiftUI


//MARK: SelfTest
struct SelfTestLatest: View{
    
    @ObservedObject var fetcherSelftest = GetSelfTestData()
    
    @State private var showButtons = false
    @State private var dropdownComm = false
    
    
    @AppStorage("defridetailhasBatteryErrorOverview") var defridetailhasBatteryErrorOverview: String?
    @AppStorage("defridetailSelfTesthasWarningsOverview") var defridetailSelfTesthasWarningsOverview: String?
    @AppStorage("defridetailSelfTesthasRedErrorsOverview") var defridetailSelfTesthasRedErrorsOverview: String?
    @AppStorage("message_selfTestResult") var defridetailAdminStatusReason: String?
    
    
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 325, height: 240)
                
                HStack(){
                    Button(action: {
                        print("Movement click")
                        
                    }, label: {
                        
                        HStack(){
                            NavigationLink(destination: SelfTestMainMenuNK()) {
                                
                                VStack(){
                                    
                                    VStack(alignment: .leading){
                                        Text("Last Self Test:")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.semibold)
                                        Text(defridetailAdminStatusReason ?? "No Additional Info")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }.frame(width: 320, height: 90)
                                    
                                    HStack(){
                                        VStack(){
                                            ZStack(alignment: .leading){
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(Color.Cardi_Text)
                                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                                    .frame(width: 100, height: 100)
                                                HStack(spacing: 5){
                                                    
                                                    VStack(alignment: .trailing){
                                                        HStack(){
                                                            
                                                            Image(systemName: "minus.plus.batteryblock.fill")
                                                                .font(.title)
                                                                .frame(width: 40.0, height: 40.0)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .offset(x: 0, y: 5)
                                                        }
                                                        
                                                        let errorText = defridetailhasBatteryErrorOverview
                                                        
                                                        switch errorText {
                                                        case "false":
                                                            Text("Battery OK")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Calming_Green)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                        case "N/A":
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                        case "true":
                                                            Text("Error")
                                                                .font(.callout)
                                                                .foregroundColor(Color.colorCardiRed)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            
                                                        default:
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                        }
                                                        
                                                    } .offset(x: 5, y: 5)
                                                }
                                            }
                                            
                                        } .offset(x: 0)
                                        
                                        VStack(){
                                            ZStack(alignment: .leading){
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(Color.Cardi_Text)
                                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                                    .frame(width: 100, height: 100)
                                                HStack(spacing: 5){
                                                    
                                                    VStack(alignment: .trailing){
                                                        
                                                        HStack(spacing: -20){
                                                            Image(systemName: "exclamationmark.triangle.fill")
                                                                .font(.title)
                                                                .frame(width: 40.0, height: 40.0)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .offset(x: 0, y: 5)
                                                        }
                                                        
                                                        
                                                        let warningText = defridetailSelfTesthasWarningsOverview
                                                        
                                                        switch warningText {
                                                        case "false":
                                                            Text("No Warnings")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Calming_Green)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            //                                                        }
                                                            //                                                        if (defridetailSelfTesthasWarningsOverview  == "N/A") {
                                                            
                                                        case "N/A":
                                                            
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            
                                                        case "true":
                                                            Text("Uncritical")
                                                            //                                                            Text("Uncritical")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Yellow)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            
                                                            
                                                        default:
                                                            
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            
                                                        }
                                                        
                                                    }  .offset(x: 5, y: 5)
                                                }
                                            }
                                            
                                        } .offset(x: 0)
                                        
                                        VStack(){
                                            ZStack(alignment: .leading){
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(Color.Cardi_Text)
                                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                                //                .frame(width: 110, height: 120)
                                                    .frame(width: 100, height: 100)
                                                HStack(spacing: 5){
                                                    
                                                    VStack(alignment: .trailing){
                                                        //                            HStack(){
                                                        HStack(spacing: -20){
                                                            Image(systemName: "xmark.circle.fill")
                                                                .font(.title)
                                                                .frame(width: 40.0, height: 40.0)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .offset(x: 0, y: 5)
                                                        }
                                                        
                                                        let redErrroText = defridetailSelfTesthasRedErrorsOverview
                                                        
                                                        //                                                        if (defridetailSelfTesthasRedErrorsOverview  == "false") {
                                                        switch redErrroText {
                                                        case "false":
                                                            Text("No Error")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Calming_Green)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            //                                                        } else {
                                                        case "true":
                                                            Text("Red Error")
                                                                .font(.callout)
                                                                .foregroundColor(Color.colorCardiRed)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                            
                                                        case "N/A":
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                        default:
                                                            Text("N/A")
                                                                .font(.callout)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .fontWeight(.bold)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width:90, height: 70)
                                                                .offset(x: 0, y: -15)
                                                        }
                                                        
                                                    } .offset(x: 5, y: 5)
                                                }
                                            }
                                            
                                        } .offset(x: 0)
                                        
                                    }.padding(.leading, 5.0)
                                        .padding(.bottom, 10.0)
                                }
                            }
                        }  .simultaneousGesture(TapGesture().onEnded{
                        })
                    })
                }
                
            }.padding(.top, 20.0)
            
        }.offset(x: 0)
    }
}
