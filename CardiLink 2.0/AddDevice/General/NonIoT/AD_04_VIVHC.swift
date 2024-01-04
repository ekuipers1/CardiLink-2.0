//
//  AD_04_VIVHC.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 18.09.23.
//

import SwiftUI

struct AD_04_VIVHC: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("myPortal") var myPortal: String?
    
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(){
                    Text("Pairing HeartConnect")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width:widthInner, height: 40)
                        .offset(x: 0, y: 40)
                    Text("Do you have a CardiLink HeartConnect?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .frame(width:widthInnerText, height: 60)
                        .offset(x: 0, y: 40)
                    Spacer()
                    Image("ComV2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200,
                               height: 200)
                        .padding(.top, 0.0)
                    Spacer()
                    HStack(){
                        
                        let defaults = UserDefaults.standard
                        
                        let backend = defaults.string(forKey: "BackendAdd")
                        
                        Button(action: {
                            navigationManager.push(.adcardiaparingcheck)
                            //                                navigationManager.currentView = .adcardiaonboarding
                            UserDefaults.standard.set("Yes", forKey: "NONIOT")
                            
                            print("Floating Button Click")
                        }, label: {
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                    .font(.title2)
                                Text("No")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                        })
                        
                        
                    }
                        
                    
                    .frame(width:widthInnerText, height: 130)
                    .offset(x: 0, y: 20)
                    
                    
                    
                }//.offset(x: 15, y: 0)
                
            } .offset(x: 15, y: 0)
            Spacer()

        }.frame(width:width)

            .navigationBarHidden(true)
    }
}

struct AD_04_VIVHC_Previews: PreviewProvider {
    static var previews: some View {
        AD_04_VIVHC()
    }
}
