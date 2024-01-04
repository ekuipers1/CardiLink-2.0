//
//  AD_02_CardiaSerialSelect.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 20.04.23.
//

import SwiftUI

struct AD_02_CardiaSerialSelect: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let defaults = UserDefaults.standard

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

                            Text("AED serial number")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10.0)
                                .frame(width:widthInner, height: 40)
                                .offset(x: 0, y: 40)
                            
                            Text("Please enter the AED Serial number")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .frame(width:widthInnerText, height: 60)
                                .offset(x: 15, y: 40)
                            
                            Spacer()

                            Button(action: {
                                navigationManager.push(.scanner)
                            }) {
                                HStack {
                                    Image(systemName: "barcode.viewfinder")
                                        .font(.title2)
                                    Text("Scan barcode")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.Cardi_Text)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                                .offset(x: 20, y: 0)
                                .frame(width: widthInnerText)
                            }


                            Button(action: {
                                navigationManager.push(.serialType)
                            }) {
                                HStack {
                                    Image(systemName: "character.cursor.ibeam")
                                        .font(.title2)
                                    Text("Enter manually")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.Cardi_Text)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiGray, Color.colorCardiGray50]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                                .offset(x: 20, y: 0)
                            }

                        }.frame(width:widthInnerText)

                            .padding(.top, 40.0)

                    }

                    .padding(.bottom, 20)
                    
                } .frame(width:width)
            }
            .frame(width:width)
            .navigationBarHidden(true)
            .onAppear {

            }

    }
}

