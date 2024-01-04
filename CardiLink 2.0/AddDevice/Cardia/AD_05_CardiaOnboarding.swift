//
//  AD_05_CardiaOnboarding.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 12.12.22.
//

import SwiftUI

struct AD_05_CardiaOnboarding: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var show = false
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(){
                    
                    VStack(alignment: .leading){
                        HStack(){
                            Text("Pairing HeartConnect")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10.0)
                                .frame(width:widthInner, height: 40)
                                .offset(x: 0, y: 40)
                        }
                        
                        VStack(alignment: .center){
                            HStack(){
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.title)
                                    .padding(.top, 25.0)
                                    .foregroundColor(Color.Cardi_Yellow)
                                Text("Important Notice")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .padding(.top, 25.0)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.6)
                                    .frame(width: 180, height: 40)
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.title)
                                    .padding(.top, 25.0)
                                    .foregroundColor(Color.Cardi_Yellow)
                            }
                        }
                        .padding(.bottom, 30.0)
                        .frame(width:widthInnerText)
                        .offset(x: 10, y: 30)
                        
                        VStack(alignment: .leading){
                            HStack(){
                                
                                Image(systemName: "1.circle")
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeIn.delay(0.5), value: show)
                                    .font(.title)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .cornerRadius(50)
                                
                                Text("Make sure that there is only one HeartConnect in pairing mode nearby!")
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeIn.delay(0.5), value: show)
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 15.0)
                            }
                            
                            HStack(){
                                Image(systemName: "2.circle")
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeIn.delay(1.0), value: show)
                                    .font(.title)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .cornerRadius(50)
                                
                                Text("Please have a paper clip or similar ready")
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeIn.delay(1.0), value: show)
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 15.0)
                            }
                            
                        }.frame(width:widthInnerText)
                            .offset(x: 10, y: 30)
                        
                    }
                    Spacer()
                    
                    Button(action: {
                        navigationManager.push(.adcardiaonboardingpreserial)
                    }) {
                        HStack {
                            Image(systemName: "checkmark.seal")
                                .font(.title2)
                            Text("OK")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .id(1)
                    }
                    .frame(width: widthInnerText)
                    .opacity(show ? 1 : 0)
                    .animation(.easeIn.delay(1.5), value: show)
                    
                }
                
            }.offset(x: 15, y: 0)
            
            Spacer()
            
        }.frame(width:width)
            .onAppear {show = true }
        
            .navigationBarHidden(true)
    }
}

