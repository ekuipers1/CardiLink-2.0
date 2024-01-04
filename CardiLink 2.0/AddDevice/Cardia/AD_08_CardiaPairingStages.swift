//
//  AD_08_CardiaPairingStages.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 18.04.23.
//

import SwiftUI

struct AD_08_CardiaPairingStages: View {

    @State private var shouldNavigate = false
    @State private var unableToConnect = false
    @State var shouldShowNext = true
    
    @AppStorage("ADPageIndex") var DeviceState: Int!
    @AppStorage("ADstate") var ADstate = 3
    @AppStorage("ADstateText") var ADstateText = "Execute order 66"
    @AppStorage("DemoProd") var demoProd: String?
    
    @State private var scale: CGFloat = 0.2
    @State private var timerIsActive = false
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(alignment: .leading){
                    
                    VStack(){
                        
                        Text("Check pairing status")
                            .padding(.top, 100.0)
                        
                        Spacer()
                        
                        if ADstate == 0 {
                            Text(ADstateText)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.Cardi_Text_Inf)
                                .frame(width:widthInnerTextButton)
                                .offset(x: 0, y: 0)
                            
                            Spacer()
                            
                            Button(action: {
                                navigationManager.navigateTo(.adIntro)
                            }, label: {
                                HStack {
                                    Image(systemName: "arrowshape.backward.fill")
                                        .font(.title2)
                                    Text("Restart")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.colorCardiRed)
                                .cornerRadius(20)
                                .padding(.bottom, 50)
                            }).frame(width:widthInnerTextButton)
                                .offset(x: 0, y: 0)
                        }
                        if ADstate == 1 || ADstate == 2 {
                            
                            if unableToConnect == true {
                                if demoProd == "Demo" || demoProd == "Test" {
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        navigationManager.navigateTo(.adcardiapairingclosecover)
                                    }, label: {
                                        HStack {
                                            Text("Continue")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                            Image(systemName: "arrowshape.forward.fill")
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.Calming_Green)
                                        .cornerRadius(20)
                                        .padding(.bottom, 50)
                                    }).frame(width:widthInnerTextButton)
                                    
                                    Text("For testing only")
                                        .offset(x: 0, y: -40)
                                    
                                } else {
                                    
                                    Text("For testing only")
                                        .offset(x: 0, y: -40)
                                    
                                    Button("FOR TESTING ONLY") {
                                        shouldNavigate.toggle()
                                    }.frame(width: 180, height: 20)
                                    
                                    Text("Pairing failed.\nPlease try again.")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.Cardi_Text_Inf)
                                        .frame(width:widthInnerTextButton)
                                        .offset(x: 0, y: 0)
                                    
                                    Button(action: {
                                        navigationManager.navigateTo(.adcardiapairingclosecover)
                                    }) {
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        navigationManager.navigateTo(.adIntro)
                                    }, label: {
                                        HStack {
                                            Image(systemName: "arrowshape.backward.fill")
                                                .font(.title2)
                                            Text("Restart")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.colorCardiRed)
                                        .cornerRadius(20)
                                        .padding(.bottom, 50)
                                    }).frame(width:widthInnerTextButton)
                                        .offset(x: 0, y: 0)
                                    
                                }
                                
                            } else {
                                
                                Text(ADstateText)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.Calming_Green)
                                    .frame(width:widthInnerTextButton)
                                    .offset(x: 0, y: 0)
                                
                                
                                HStack {
                                    Circle()
                                        .foregroundColor(.colorCardiGray)
                                        .scaleEffect(scale)
                                        .animation(
                                            Animation.easeInOut(duration: 1)
                                                .repeatForever(autoreverses: true)
                                                .delay(0.2),
                                            value: scale
                                        )
                                    Circle()
                                        .foregroundColor(.colorCardiGray)
                                        .scaleEffect(scale)
                                        .animation(
                                            Animation.easeInOut(duration: 1)
                                                .repeatForever(autoreverses: true)
                                                .delay(0.4),
                                            value: scale
                                        )
                                    Circle()
                                        .foregroundColor(.colorCardiGray)
                                        .scaleEffect(scale)
                                        .animation(
                                            Animation.easeInOut(duration: 1)
                                                .repeatForever(autoreverses: true)
                                                .delay(0.6),
                                            value: scale
                                        )
                                }.frame(width:100)
                                    .onAppear() {
                                        self.scale = 0.5
                                    }
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    
                                    HStack {
                                        Text("Please wait")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                        Image(systemName: "ellipsis")
                                            .font(.title2)
                                            .offset(x: 0, y: 6)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.Cardi_Yellow)
                                    .cornerRadius(20)
                                    .padding(.bottom, 50)
                                    
                                }).frame(width:widthInnerTextButton)
                            }
                        }
                        if ADstate == 3 {
                            
                            Text(ADstateText)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.Calming_Green)
                                .frame(width:widthInnerTextButton)
                                .offset(x: 0, y: 0)
                            Spacer()
                            
                            Button(action: {
                                self.shouldNavigate = true
                                navigationManager.push(.adcardiapairingclosecover)
                            }, label: {
                                HStack {
                                    Text("Next")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                    Image(systemName: "arrowshape.forward.fill")
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 50)
                            }).frame(width:widthInnerTextButton)
                                .offset(x: 0, y: 0)
                                .simultaneousGesture(TapGesture().onEnded{
                                    self.shouldNavigate = true
                                })
                        }
                        
                    }.padding(.bottom, 0)
                    
                    Spacer()
                    
                }
                
            }.offset(x: 0, y: 0)
            Spacer()
            
        }
        
        .onChange(of: shouldNavigate) { value in
            if value {
                TimerManager.shared.stopAllTimers()
                navigationManager.navigateTo(.adcardiapairingclosecover)
            }
        }
        
        .onAppear {
            @AppStorage("ADstate") var ADstate: Int!
            @AppStorage("ADPageIndexCheck") var ADPageIndexCheck: Int!
            @AppStorage("ADPageCount") var ADPageCount: Int!
            @AppStorage("DemoProd") var demoProd: String?
            
            if demoProd == "Demo" || demoProd == "Test" {
                var counter = 0
                Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                    if counter >= 1 {
                        timer.invalidate()
                        unableToConnect.toggle()
                        return
                    }
                    if ADstate == 0 {
                        timer.invalidate()
                    } else if ADstate == 1 || ADstate == 2 {
                        if ADPageCount - 1 == ADPageIndexCheck {
                            timer.invalidate()
                            return
                            
                        } else {
                            ADActivationCheck()
                        }
                    } else if ADstate == 3 {
                        timer.invalidate()
                        return
                    }
                    counter += 1
                }
            } else {
                
                var counter = 0
                Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                    if counter >= 22 {
                        timer.invalidate()
                        unableToConnect.toggle()
                        return
                    }
                    if ADstate == 0 {
                        timer.invalidate()
                    } else if ADstate == 1 || ADstate == 2 {
                        if ADPageCount - 1 == ADPageIndexCheck {
                            timer.invalidate()
                            return
                            
                        } else {
                            ADActivationCheck()
                        }
                    } else if ADstate == 3 {
                        timer.invalidate()
                        return
                    }
                    counter += 1
                }
            }
        }
        
        .navigationBarHidden(true)
    }
    
}

class TimerManager {
    static let shared = TimerManager()
    
    private var timers: [Timer] = []
    
    func addTimer(_ timer: Timer) {
        timers.append(timer)
    }
    
    func stopAllTimers() {
        for timer in timers {
            timer.invalidate()
        }
        timers.removeAll()
    }
}




