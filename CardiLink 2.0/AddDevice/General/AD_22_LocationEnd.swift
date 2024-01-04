//
//  AD_22_LocationEnd.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI

struct AD_22_LocationEnd: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var disabled = true
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    @AppStorage("ADSerialNumber") var ADSerialNumber = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                ZStack(alignment: .top) {
                    Header(title: "AED Activation".localized)
                    
                }
                ZStack(){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    VStack(){
                        VStack(alignment: .leading){
                            Text("AED Added")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10.0)
                                .frame(width:widthInner, height: 40)
                                .offset(x: 0, y: 40)
                            Text("Thank you! The data for")
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 40)
                                .offset(x: 20, y: 40)
                            
                            HStack(){
                                Text("AED:")
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .offset(x: 20, y: 40)
                                Text(ADSerialNumber)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .offset(x: 20, y: 40)
                            }.frame(width:widthInnerText, height: 40)
                            
                            Text("is updated!")
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 40)
                                .offset(x: 20, y: 40)
                            
                            Text("What do you want to do next?")
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 50)
                                .offset(x: 20, y: 40)
                            Spacer()
                        }
                        VStack(){
                            Button(action: {
                                navigationManager.navigateTo(.dashboard)
                            }, label: {
                                HStack {
                                    Image(systemName: "list.bullet.rectangle")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                    Text("Open Dashboard")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding([.leading, .bottom, .trailing], 20)
                            })
                            Button(action: {

                                navigationManager.navigateTo(.defibrillatoroverview)
                                UserDefaults.standard.set(ADdefibrillatorId, forKey: "SelectedDefi")
                                UserDefaults.standard.set(true, forKey: "NavFromAD")
                                LoadMyData()
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Image(systemName: "eye.square")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                    Text("Open AED")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding([.leading, .bottom, .trailing], 20)
                            })
                            Button(action: {
                                navigationManager.navigateTo(.adIntro)
                            }, label: {
                                HStack {
                                    Image(systemName: "waveform.path.badge.plus")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                    Text("Add AED")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding([.leading, .bottom, .trailing], 20)
                            })
                        }
                        .frame(width:widthInnerText, height: 200)
                        Spacer()
                    }
                }.offset(x: 10, y: 0)
                Spacer()
                    .padding(.bottom, 10.0)
            } .frame(width:width)
        }
        .navigationBarHidden(true)
    }
}

