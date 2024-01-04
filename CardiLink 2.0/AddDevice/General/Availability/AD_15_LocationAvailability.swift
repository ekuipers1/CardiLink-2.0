//
//  AD_15_LocationAvailability.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI

struct AD_15_LocationAvailability: View {

    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var isPubAvailable: Bool = false
    @State private var addImages: Bool = false

    var body: some View {

        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)

            }
                ZStack(alignment: .top){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    
                    ScrollView{
                        VStack(){
                            Spacer()
                            
                            AvailabilityQuestion()
                            Spacer()
                            if isPubAvailable == true {
                                AvailabilityQuestion247()
                            }
                            
                            if addImages == true {
                                AddPhotosQuestion()
                            }
                            
                        } .frame(width: widthInner, height: height)
                                            Spacer()
                    }.padding(.top, 30.0) .frame(width: widthInner, height: height - 10)
                }.offset(x: 15, y: 0)

            }.frame(width:width)
//        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}

struct AD_15_LocationAvailability_Previews: PreviewProvider {
    static var previews: some View {
        AD_15_LocationAvailability()
            .previewDevice("iPhone SE (2nd generation)")
        AD_15_LocationAvailability()
            .previewDevice("iPhone 14 Pro")
    }
}

struct AvailabilityQuestion247: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var is247Available: Bool = false
    @State private var addImages: Bool = false
    
    var body: some View {
        VStack(){

            VStack(alignment: .leading){
                HStack(){
                    Text("Is it available 24/7 ?")

                }.frame(width:widthInnerText, height: 10)
                
            } .padding(.top, 10.0)

            HStack(){
                
                Button(action: {
                    print("available 24/7")
                    
                    
                    self.is247Available = true
                    UserDefaults.standard.set(is247Available, forKey: "is247Available")
                    ADAvailable247()
                    addImages.toggle()
                    
                }, label: {

                    HStack {

                        Text("Yes")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)

                })
                
                Button(action: {
                    
                    self.is247Available = false
                    UserDefaults.standard.set(is247Available, forKey: "is247Available")
                    
                 //   getAvialableDayTime()
                    getAvialableDayTime(optionA: true)
                    
                    
                    ADAvailable247()
                    print("Edit tapped!")

                    UserDefaults.standard.set("No", forKey: "Monday")
                    UserDefaults.standard.set("No", forKey: "Tuesday")
                    UserDefaults.standard.set("No", forKey: "Wednesday")
                    UserDefaults.standard.set("No", forKey: "Thursday")
                    UserDefaults.standard.set("No", forKey: "Friday")
                    UserDefaults.standard.set("No", forKey: "Saturday")
                    UserDefaults.standard.set("No", forKey: "Sunday")

                    navigationManager.push(.adavailtimes)
                }) {
                    HStack {
                        Text("No")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }
                .simultaneousGesture(TapGesture().onEnded {

                })

            }.frame(width:widthInnerText, height: 80)

            Spacer()
            
            if addImages == true {
                AddPhotosQuestion()
            }

        }
        .padding(.top, 30.0)
    }
}

struct AddPhotosQuestion: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var navigationManager: NavigationManager
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width - (10 + 10)
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack(){
            //                        Spacer()
            
            VStack(alignment: .center){
                HStack(){
                    Text("Do you want to upload a photo of the location?")
                    .multilineTextAlignment(.center)
                    
                }.frame(width:widthInnerText, height: 60)
                    .offset(x:0,y:0)
                
            } .padding(.top, 30.0)

            HStack(){
                Button(action: {
//                    print("Floating Button Click")
                    
                    let selectedDefi = defaults.string(forKey: "ADdefibrillatorId")
                    UserDefaults.standard.set(selectedDefi, forKey: "defridetailID")
                    UserDefaults.standard.set(selectedDefi, forKey: "SelectedDefi")
                    
                    navigationManager.push(.adimageselection)
                }) {
                    HStack {
                        Text("Yes")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }
                .simultaneousGesture(TapGesture().onEnded {
            
                })

                
                Button(action: {
                    print("Edit tapped!")

                    navigationManager.push(.adlocationsharedata)
                }) {
                    HStack {
                        Text("No")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }


            } .offset(x:0,y:-10)
            .frame(width:widthInnerText, height: 80)
            .padding(.bottom, 60.0)

        }
    }
}

struct AvailabilityQuestion: View {
    
    @State private var isPubAvailable: Bool = false
    @State private var addImages: Bool = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    
    
    var body: some View {
        VStack(){

            Text("Opening hours & photo")
                .font(.headline)
                .foregroundColor(Color.Cardi_Text_Inf)
                .multilineTextAlignment(.leading)
                .frame(width:widthInnerText, height: 10)
                .padding(.top, 50.0)

            VStack(alignment: .leading){
                HStack(){
                    Text("Is the AED public available?")

                }.frame(width:widthInnerText, height: 10)
                
            } .padding(.top, 50.0)
            
            HStack(){
                Button(action: {
                    print("public available?")

                    isPubAvailable = true
                    UserDefaults.standard.set(isPubAvailable, forKey: "aedisPubAvailable")

                }, label: {
                    
                    HStack {

                        Text("Yes")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)

                })
                .simultaneousGesture(TapGesture().onEnded{

                })

                Button(action: {
                    isPubAvailable = false
                    UserDefaults.standard.set(isPubAvailable, forKey: "aedisPubAvailable")
                    addImages.toggle()
                }, label: {
                    
                    HStack {
                        
                        Text("No")
                            .fontWeight(.semibold)
                            .font(.title2)
                    }
                    
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
//                    .padding([.bottom, .trailing], 20)
                    
                })
                .simultaneousGesture(TapGesture().onEnded{
//                    isPubAvailable.toggle()
                    UserDefaults.standard.set(isPubAvailable, forKey: "aedisPubAvailable")
                })
            }
//            .padding(.top, 60.0)
            .frame(width:widthInnerText, height: 80)
            //                        .offset(x: 20, y: 50)
            Spacer()
        }
        
        if isPubAvailable == true {
            AvailabilityQuestion247()
        }
        
        if addImages == true {
            AddPhotosQuestion()
        }
    }
}

