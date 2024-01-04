//
//  ADCardiaMotionDetection.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 08.03.23.
//

import SwiftUI

struct ADCardiaMotionDetection: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var selectedOption = "Yes"
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")
            }
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(){
                    VStack(alignment: .leading){
                        Text("Motion configuration")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInner, height: 40)
                            .offset(x: -10, y: 40)
                        Text("Do you want motion detection enabled?")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .frame(width:widthInnerText, height: 60)
                            .offset(x: 15, y: 40)
                    }
                    Spacer()
                    VStack {
                        Toggle(isOn: Binding<Bool>(get: { self.selectedOption == "Yes" },
                                                   set: { newValue in
                            if newValue {
                                self.selectedOption = "Yes"
                                UserDefaults.standard.set(1, forKey: "motionConfig")
                            }
                        })) {
                            Text("Yes")
                        }.toggleStyle(RadioGroupStyle())
                        
                        Toggle(isOn: Binding<Bool>(get: { self.selectedOption == "No" },
                                                   set: { newValue in
                            if newValue {
                                self.selectedOption = "No"
                                UserDefaults.standard.set(2, forKey: "motionConfig")
                            }
                        })) {
                            Text("No")
                        }.toggleStyle(RadioGroupStyle())
                    }.frame(width:widthInnerText - 50, height: 60)
                    Spacer()
                    Button(action: {
                        navigationManager.push(.adcardiapairingredgreen)
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
                        .padding(.bottom, 20)
                        .frame(width:widthInnerText)
                        .offset(x: 0, y: -10)
                    })
                    .simultaneousGesture(TapGesture().onEnded{
                        ADMotionDetectionMode()
                    })
                    .environmentObject(navigationManager)
                }
            }.offset(x: 15, y: 0)
        }.frame(width:width)
            .navigationBarHidden(true)
            .onAppear {
                UserDefaults.standard.set(1, forKey: "motionConfig")
            }
        
    }
}



