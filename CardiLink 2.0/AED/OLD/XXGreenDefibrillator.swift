//
//  XXGreenDefibrillator.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 28.04.23.
//

import SwiftUI

struct XXGreenDefibrillator: View {
    
    @StateObject private var viewModel = XXGreenDefibrillatorViewModel()
    @Environment(\.presentationMode) var presentationMode
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack(){
            ZStack(){
                
                
                MainBackgroundGreenNEW()
                //                    .padding(.top, 60.0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    
                    HStack(){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            
                            UserDefaults.standard.set("Unknown AED", forKey: "defridetailOwner")
                            UserDefaults.standard.set("Please try again", forKey: "defridetailID")
                            UserDefaults.standard.set("Make sure you have Internet connection" ,forKey: "defridetailDescription")
                            UserDefaults.standard.set("", forKey: "defridetailStatusValue")
                            UserDefaults.standard.set("", forKey: "defridetailAdminStatusValue")
                            UserDefaults.standard.set("", forKey: "defridetailpairingDate")
                            UserDefaults.standard.set("", forKey: "defridetailpairingID")
                            
                        }){
                            
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    
                }.frame(width: widthInnerText, height: 60)
                    .offset(x: 0, y: 25)
            }
            .frame(width: width, height: 100)
            
            
            List() {
                
                ScrollView{
                    
                    Section {
                        ForEach(viewModel.defibrillators) { defibrillator in
                            NavigationLink(destination: AED_Overview()) {
                                ZStack(){
                                    
                                    HStack(){
                                        
                                        VStack (alignment: .leading) {
                                            ZStack(){
                                                Rectangle()
                                                    .fill(Color.Calming_Green)
                                                
                                                    .frame(width: width, height: 45.0)
                                                
                                                Text(defibrillator.serial)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                    .foregroundColor(Color.white)
                                                    .frame(width: widthInner, height: 30.0, alignment:.trailing)
                                                    .offset(x: -5)
                                            }
                                            
                                            HStack(){
                                                Image(systemName:"person.2.crop.square.stack")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                
                                                Text(defibrillator.ownerName )
                                                    .fontWeight(.regular)
                                                    .font(.headline)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: widthInnerText, height: 30.0, alignment:.leading)
                                                    .offset(x: 5)
                                                
                                            } .frame(width: widthInner, height: 30.0, alignment:.leading)
                                                .offset(x: 10)
                                            
                                            
                                            HStack(){
                                                Image(systemName:"doc.text")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                
                                                if defibrillator.description == "null" {
                                                    
                                                    Text("N/A")
                                                        .fontWeight(.regular)
                                                        .font(.headline)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                        .multilineTextAlignment(.leading)
                                                        .frame(width: widthInnerText, height: 30.0, alignment:.leading)
                                                        .offset(x: 5)
                                                    
                                                } else {
                                                    
                                                    
                                                    Text(defibrillator.description ?? "N/A" )
                                                        .fontWeight(.thin)
                                                        .font(.subheadline)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                        .multilineTextAlignment(.leading)
                                                        .lineLimit(2)
                                                        .frame(width: widthInnerText, height: 60.0, alignment:.leading)
                                                        .offset(x: 5)
                                                }
                                            }.frame(width: widthInner, height: 60.0, alignment:.leading)
                                                .offset(x: 10)
                                            
                                            HStack {
                                                Circle()
                                                    .fill(Color.Cardi_Text_Inf)
                                                    .frame(width: 5, height: 5)
                                                Circle()
                                                    .fill(Color.Cardi_Text_Inf)
                                                    .frame(width: 5, height: 5)
                                                Circle()
                                                    .fill(Color.Cardi_Text_Inf)
                                                    .frame(width: 5, height: 5)
                                                
                                            }.frame(width: width, height: 10.0, alignment:.center)
                                            //                        .offset(y: -10)
                                            
                                        } .padding(25.0)
                                    }
                                    
                                }
                                
                            }.navigationBarHidden(true)
                                .edgesIgnoringSafeArea(.all)
                                .simultaneousGesture(TapGesture().onEnded{
                                    UserDefaults.standard.set(defibrillator.id, forKey: "SelectedDefi")
                                    UserDefaults.standard.set(0, forKey: "dashboardState")
                                    
                                    UserDefaults.standard.set("Green", forKey: "DefiListStatus")
                                    
                                    UserDefaults.standard.set("YES", forKey: "Overview")
                                    
                                    LoadMyData()
                                    
                                    
                                })
                            
                        }
                        
                    } header: {
                        
                        VStack() {
                            

                            
                            HStack(){
                                Spacer()
                                let counterGreen = defaults.integer(forKey: "GreenCount")
                                Text(String(counterGreen))
                                    .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                Text("Available")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Text_Inf)
//                                Spacer()
             
                                
                            }.frame(width: widthInnerText, height: 20.0)
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.Calming_Green)
                                .frame(width: widthInner, height: 4.0)
                            
                        }
                        .padding(.top, 5.0)
                    }
                    
                }
            } .frame(width: widthList)
                    .padding(.top, 0)
                    .padding(.bottom, 60)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .refreshable {
                        viewModel.fetchDefibrillators()
                    }
                    .onAppear(perform: viewModel.fetchDefibrillators)

//            }
        }.navigationBarHidden(true)
            .mask(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
//

struct XXGreenDefibrillator_Previews: PreviewProvider {
    static var previews: some View {
        XXGreenDefibrillator()
            .previewDevice("iPhone SE (2nd generation)")
        XXGreenDefibrillator()
            .previewDevice("iPhone 14 Pro")
    }
}


