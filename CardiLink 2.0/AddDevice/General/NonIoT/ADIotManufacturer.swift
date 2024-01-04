//
//  ADIotManufacturer.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 02.02.23.
//

import SwiftUI

struct ADIotManufacturer: View {
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width - (10 + 10)
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    @Environment(\.presentationMode) private var presentationMode
    
    
//    @State private var SectionOneEnd: Bool = false
//    @State private var SectionTwoStart: Bool = false
//    @State private var SectionTwoEnd: Bool = false
//    @State private var SectionThreeStart: Bool = false
//    @State private var SectionThreeEnd: Bool = false
//
//
//    @State private var SectionZero: Bool = false
//    @State private var SectionOneFirstLine: Bool = false
//    @State private var SectionOneSecondLine: Bool = false
//    @State private var SectionOneThirdLine: Bool = false
//
//    @State private var SectionTwoFirstLine: Bool = false
//    @State private var SectionTwoSecondLine: Bool = false
//
//    @State private var SectionThreeFirstLine: Bool = false
    
    @State private var showNext = false
    @State private var showNextAni = false
    
    @State private var indicatorGreen = false
    
    @State var noDamage = false
    @State var padsConnected = false
    @State var batteryConnected = false
    //    @State var indicatorGreen = false
    
    @State private var animationAmount = 1.0
    
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")

            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                let defaults = UserDefaults.standard
                
                let backend = defaults.string(forKey: "BackendAdd")
                
                VStack(){
                
                if backend == "NK" {
                    
                    VStack(){
                        Text("Do you want to add a Nihon Kohden AED")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInnerText, height: 60)
                            .offset(x: 0, y: 40)
                        Spacer()
                        Image("NKDevice")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200,
                                   height: 200)
                            .padding(.top, 10.0)
                       Spacer()
                        
                        
                    }
                    
                }else{
                        VStack(){
                            Text("Do you want to add a CardiAid AED")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10.0)
                                .frame(width:widthInnerText, height: 60)
                                .offset(x: 0, y: 40)
                            Spacer()
                            Image("CAOpen")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200,
                                       height: 200)
                                .padding(.top, 10.0)
                            Spacer()
                            
                        }
                }
                        //                    }
                        //
                        //
                        
//                        Spacer()
                        HStack(){
                            
                            
                            
                            if backend == "NK" {
                                
                                
                                
                                Button(action: {
                                    print("Floating Button Click")
                                    
                                }, label: {
                                    NavigationLink(destination: ADIotDeviceInformation()) {
                                        
                                        HStack {
                                            Image(systemName: "hand.thumbsup")
                                                .font(.title2)
                                            Text("Yes")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(20)
                                        .padding(.bottom, 20)
                                        //                            .padding([.leading, .bottom, .trailing], 20)
                                        //
                                    }
                                })                                .simultaneousGesture(TapGesture().onEnded{
                                    UserDefaults.standard.set("NK", forKey: "BackendSelection")
                                })
                                
                            }else {
                                
                                Button(action: {
                                    print("Floating Button Click")
                                    
                                }, label: {
                                    NavigationLink(destination: ADIotDeviceInformation()) {
                                        
                                        HStack {
                                            Image(systemName: "hand.thumbsup")
                                                .font(.title2)
                                            Text("Yes")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(20)
                                        .padding(.bottom, 20)
                                        //                            .padding([.leading, .bottom, .trailing], 20)
                                        //
                                    }
                                }).simultaneousGesture(TapGesture().onEnded{
                                    UserDefaults.standard.set("CA", forKey: "BackendSelection")
                                })
                            }
                            
                            Button(action: {
                                
                                //SectionTwoFirstLine.toggle()
                                withAnimation {
                                    //                                    proxy.scrollTo(2, anchor: .leading)
                                }
                                
                                print("Edit tapped!")
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }) {
                                
                                Button(action: {
                                    print("Floating Button Click")
                                    
                                }, label: {
                                    NavigationLink(destination: ADIotDeviceInformation()) {
                                        
                                        HStack {
                                            Image(systemName: "hand.thumbsdown")
                                                .font(.title2)
                                            Text("No")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(20)
                                        .padding(.bottom, 20)

                                    }
                                })
                                .simultaneousGesture(TapGesture().onEnded{
                                    UserDefaults.standard.set("", forKey: "BackendSelection")
                                })
                            }
                        }
                                    .frame(width:widthInnerText, height: 130)
                            .offset(x: 0, y: 20)
                        
                        
                    
                }//.offset(x: 15, y: 0)
                
            } .offset(x: 15, y: 0)
            Spacer()
            
//            
//            //MARK: Start BOTTOM
//            ProgressIndicator(SectionOneFirstLine: $SectionOneFirstLine, SectionOneSecondLine: $SectionOneSecondLine, SectionOneThirdLine: $SectionOneThirdLine, SectionTwoFirstLine: $SectionTwoFirstLine, SectionTwoSecondLine: $SectionTwoSecondLine, SectionOneEnd: $SectionOneEnd, SectionTwoStart: $SectionTwoStart, SectionTwoEnd: $SectionTwoEnd, SectionThreeStart: $SectionThreeStart, SectionThreeEnd: $SectionThreeEnd)
            //                    .offset(x:50, y:0),
            //                    .padding(.leading, 50.0)
            //                }
            //                .padding(.bottom, 10.0)
        }.frame(width:width)
        //        }
        //        .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}

struct ADIotManufacturer_Previews: PreviewProvider {
    static var previews: some View {
        ADIotManufacturer()
            .previewDevice("iPhone SE (2nd generation)")
        ADIotManufacturer()
            .previewDevice("iPhone 14 Pro")
    }
}
