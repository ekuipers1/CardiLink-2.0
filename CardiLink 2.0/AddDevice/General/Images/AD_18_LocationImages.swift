//
//  AD_18_LocationImages.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI
import UIKit

struct AD_18_LocationImages: View {
//
//    @State var username: String = ""
//    @State var comments: String = ""
    
    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager

    @State private var isPubAvailable: Bool = false
    @State private var addImages: Bool = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
//        NavigationView {

        VStack(alignment: .leading){

            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)

            }
            
                ZStack(){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    
                    VStack(){
                        //                Spacer()
                        
                        VStack(alignment: .leading){
                            Text("Location Information")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10.0)
                                .frame(width:widthInner, height: 40)
                                .offset(x: 0, y: 40)
        //                    Spacer()
                            Text("Do you want to add a picture of the AED and location?")
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 250)
                                .offset(x: 20, y: 40)
                            Spacer()
                            
                        }
                        
                        
                        HStack(){
                            
                            Button(action: {
                                print("Floating Button Click")
                        
                                navigationManager.push(.adimageselection)
                            }, label: {
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
                            })

                            
                            Button(action: {
                                print("Edit tapped!")
                                
                                let selectedDefi = defaults.string(forKey: "ADdefibrillatorId")
                                UserDefaults.standard.set(selectedDefi, forKey: "defridetailID")
                                
                                navigationManager.push(.adlocationsharedata)
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
                        }.frame(width:widthInnerText, height: 120)
                            .offset(x: 0, y: 30)
                        Spacer()
                    }
                    
                }
                .offset(x: 15, y: 0)
                .padding(.bottom, 20)
                
                Spacer()

            }.frame(width:width)
//        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}

struct AD_18_LocationImages_Previews: PreviewProvider {
    static var previews: some View {
        AD_18_LocationImages()
            .previewDevice("iPhone SE (2nd generation)")
        AD_18_LocationImages()
            .previewDevice("iPhone 14 Pro")
    }
}



