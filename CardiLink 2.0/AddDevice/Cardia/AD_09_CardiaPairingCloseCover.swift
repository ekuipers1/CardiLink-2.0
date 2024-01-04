//
//  AD_09_CardiaPairingCloseCover.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 23.03.23.
//

import SwiftUI

struct AD_09_CardiaPairingCloseCover: View {
    
    @State private var isActive = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                VStack() {
                    HStack() {
                        Button(action: {
                            TimerManager.shared.stopAllTimers()
                            navigationManager.navigateTo(.adcardiapairingstages)
                        }) {
                            Image(systemName: "arrow.left")
                                .leftArrow()
                        }
                        Spacer()
                        Text("Pairing HearthConnect")
                            .addDevice()
                        Spacer()
                        Button(action: {
                            navigationManager.navigateTo(.dashboard)
                        }) {
                            Image(systemName: "x.square.fill")
                                .hamburgerMenu()
                        }
                    }
                    .padding(.top, 0.0)
                }
                .frame(height: 50)
                .navigationBarHidden(true)
            }
            
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(alignment: .leading){
                    
                    ScrollView(){
                        
                        Text("Finish Pairing")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInner, height: 40)
                            .padding(.bottom, 40.0)
                        
                        VStack(){
                            
                            Image("CAClosed")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150,
                                       height: 150)
                                .padding(.top, 0.0)
                            
                            Text("Please close the cover of your AED!")
                            
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 25.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 160)
                                .offset(x: 0, y: 0)
                            
                        }
                    }
                    .padding(.top, 40.0)
                    
                    Button(action: {
                        navigationManager.push(.adcardiaparingcheck)
                    }, label: {
                        HStack {
                            Text("Cover is closed")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .lineLimit(1)
                                .truncationMode(.tail)
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
                        .offset(x: 17, y: 0)
                    })
                    
                }
                
            }.offset(x: 15, y: 0)
            Spacer()
            
        }
        .frame(width:width)
        .navigationBarHidden(true)
        
    }
    
}
