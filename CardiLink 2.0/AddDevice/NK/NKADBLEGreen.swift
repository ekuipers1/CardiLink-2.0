//
//  NKADBLEGreen.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 12.12.22.
//

import SwiftUI

struct NKADBLEGreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(alignment: .leading){
                    
                    Text("Status of your AED")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width:widthInnerText, height: 40)
                        .offset(x: 0, y: 40)
                    
                    Spacer()
                    HStack(){
                        Text("**Is the indicator on the AED still green?**")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .offset(x: 0, y: 10)
                    }.frame(width:widthInnerText, height: 180)
                    
                    Spacer()
                    HStack(){
                        
                        Button(action: {
                        }, label: {
                            NavigationLink(destination: AD_11_LocationMainScreen()) {
                                
                                HStack {
                                    
                                    Text("Yes")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                            }
                        })
                        
                        Button(action: {
                            
                            withAnimation {
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            
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
                            
                        }
                    }
                    .padding(.bottom, 20.0)
                    .frame(width:widthInnerText)
                    .offset(x: 5, y: 20)
                }
            }
            .offset(x: 15, y: 0)
            
            Spacer()
            
        }.frame(width:width)
        
            .navigationBarHidden(true)
    }
}

