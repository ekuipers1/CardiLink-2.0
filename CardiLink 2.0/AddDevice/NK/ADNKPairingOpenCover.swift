//
//  ADNKPairingOpenCover.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.03.23.
//

import SwiftUI


struct ADNKPairingOpenCover: View {
    
    @State private var counter = 0
    @State private var isActive = false
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var timer: Timer?
    @State private var shouldNavigate = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "Pairing HeartConnect".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(alignment: .leading){
                    
                    ScrollView(){
                        VStack(){
                            Text("Activate AED")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 80)
                                .offset(x: 0, y: 0)
                            Image("NKOpen")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200,
                                       height: 200)
                                .padding(.top, 0.0)
                            Text("Please open the cover of your AED to activate the pairing mode")
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 160)
                                .offset(x: 0, y: 0)
                        }
                    }
                    .padding(.top, 40.0)
                }
                
            }.offset(x: 15, y: 0)
            Spacer()
            
        }
        
        .onAppear {
            ADActivation()
            
            @AppStorage("ADstate") var DeviceState: Int!
            @AppStorage("ActivationError") var ActivationError: String?
            UserDefaults.standard.set("STOP", forKey: "ActivationError")

            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                
                if DeviceState! == 1 {
                    timer.invalidate()
                    
                    if ActivationError == "STOP" {
                        
                        showAlert = true
                        
                    } else {
                        
                        navigationManager.push(.adnkparingstages)
                        ADActivationCheck()
                        return
                        
                    }
                } else {
                    
                    ADActivation()
                    self.isActive = true
                }
            }
            
        }
        
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
        
        .frame(width:width)
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Activation Failed"),
                message: Text("The pairing with the AED failed. Please try it again"),
                primaryButton: .destructive(Text("Yes")) {
                    
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                        
                        if counter == 3 {
                            TimerManager.shared.stopAllTimers()
                            UserDefaults.standard.set("STOP", forKey: "ActivationError")
                            
                        } else {
                            counter += 1
                            ADActivation()
                            timer.invalidate()
                        }
                    }
                },
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
}

