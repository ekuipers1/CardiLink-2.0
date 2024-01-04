//
//  AD_20_LocationShareData.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI

struct AD_20_LocationShareData: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isOKforShare: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "Location Information")
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(alignment: .leading){
                    
                    ScrollView(){
                        
                        VStack(){
                            
                            VStack(alignment: .leading){
                                Text("Help saving lives!")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 20.0)
                                    .frame(width:widthInner, height: 20)
                                    .offset(x: 0, y: 40)
                                Text("Are you willing to make the information about your AED available to the public in order to potentially save lives in emergency situations?")
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width:widthInnerText)
                                    .offset(x: 20, y: 40)
                                    .padding(.bottom, 20.0)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("By agreeing, you consent to CardiLink automatically sharing AED information (e.g., location data, operating status) needed by first responders.")
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width:widthInnerText)
                                    .offset(x: 20, y: 40)
                                    .padding(.bottom, 20.0)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                Text("Privacy Statement")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .frame(width:widthInnerText, height: 10)
                                    .offset(x: 20, y: 40)
                                Link("https://www.cardi-link.com/PrivacyEnglish.html", destination: URL(string: "https://www.cardi-link.com/PrivacyEnglish.html")!)
                                    .foregroundColor(Color.Cardi_MapBlue)
                                    .frame(width:widthInnerText)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .offset(x: 20, y: 40)
                                Spacer()
                                
                            }
                        }
                        
                    }.padding(.top, 40.0) .frame(width: widthInner)
                    
                    HStack(){
                        
                        Button(action: {
                            self.isOKforShare = true
                            UserDefaults.standard.set(isOKforShare, forKey: "isOKforShare")
                            navigationManager.push(.adendoverview)
                        }, label: {
                            HStack {
                                Text("Agree")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                        })
                        
                        Button(action: {
                            self.isOKforShare = false
                            UserDefaults.standard.set(isOKforShare, forKey: "isOKforShare")
                            navigationManager.push(.adendoverview)
                        }, label: {
                            HStack {
                                Text("No")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                        })
                    }.offset(x: 15, y: 0)
                } .frame(width:widthInnerText)
                
            } .offset(x: 15, y: 0)
            
                .padding(.bottom, 10.0)
        }.frame(width:width)
        
            .navigationBarHidden(true)
    }
}

struct ShareData: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var acknowladge = false
    
    let proxy: ScrollViewProxy
    
    var body: some View {
        
        ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.Cardi_Text)
                .padding(.horizontal, 5.0)
                .padding(.top, 20)
                .shadow(color: .gray, radius: 3, y: 1)
                .frame(width: widthInner, height: height)
            
            VStack(){
                VStack(alignment: .leading){
                    Text("Location Information")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width:widthInner, height: 40)
                        .offset(x: 0, y: 40)
                    Text("Do you agree to share the information bout your AED with the public, to save lives in case of emergency?")
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .frame(width:widthInnerText, height: 150)
                        .offset(x: 20, y: 40)
                    Text("By agreeing you confirm your AED address to be published and shared with the public.")
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .frame(width:widthInnerText, height: 100)
                        .offset(x: 20, y: 40)
                    Spacer()
                    
                }
                
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        
                        NavigationLink(destination: AD_21_EndOverview()) {
                            
                            HStack {
                                
                                Text("YES")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding([.leading, .bottom, .trailing], 20)
                            
                        }
                    })
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        NavigationLink(destination:  AD_22_LocationEnd()) {
                            HStack {
                                Text("No")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding([.leading, .bottom, .trailing], 20)
                            .id(1)
                            
                        }
                    })
                }.frame(width:widthInnerText, height: 120)
                    .offset(x: 0, y: 30)
                Spacer()
            }
        }
        .padding(.bottom, 20)
    }
}

