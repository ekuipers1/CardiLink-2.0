//
//  DefibrillatorOverviewSettings.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.08.22.
//

import Foundation
import SwiftUI

struct DefibrillatorOverviewSettings: View {
    @Binding var layoutData: SelectedData
    
    @State private var showDefault = false
    @State private var showCritical = false
    @State private var showButtons = false
    //    @Environment(\.presentationMode) var presentationMode
    @State private var dropdown = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                ZStack(alignment: .top) {
                    
                    VStack(){
                        HStack(){
                            
                            Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            }){
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .background(Color.white)
                                    .cornerRadius(50)
                            }
                            Text("Overview Layout")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .frame(width: 200, height: 75)
                                .padding(.trailing, 50.0)
                        }
                        
                        .padding(.top, 30.0)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .navigationBarHidden(true)
                        .edgesIgnoringSafeArea(.all)
                        
                    }.background(Rectangle())
                        .foregroundColor(Color.Calming_Green)
                }
                
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    DefaultViewDrop(layoutData:  $layoutData)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 20.0)

                }
                
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
    }
}

struct DefibrillatorOverviewSettings_Previews: PreviewProvider {
    
    @State static var layoutData = SelectedData(layoutSelection: "Default")
    static var previews: some View {
        
        DefibrillatorOverviewSettings(layoutData: $layoutData)
        //            .previewDevice("iPhone 12 mini")
        //            .previewDevice("iPhone SE (3rd generation)")
            .previewDevice("iPhone SE (1st generation)")
        DefibrillatorOverviewSettings(layoutData: $layoutData)
            .previewDevice("iPhone 13 Pro")
        
    }
}


struct SelectedData {
    var layoutSelection = ""
    //    var lastName = ""
}


//MARK: DefaultViewDrop
struct DefaultViewDrop: View {
    
    @State private var agreeToTerms = false
    @State private var showButtons = false
    //    @Environment(\.presentationMode) var presentationMode
    @State private var dropdown = false
    @State private var dropdownCritical = false
    @State private var dropdownMap = false
    @State private var dropdownMinimum = false
    @State private var dropdownDIY = false
    
    
    @State private var showDefault = false
    @State private var showCritical = false
    @State private var showMap = false
    @State private var showMinimum = false
    @State private var showDIY = false
    
    //    @State private var showHorizon = false
    //    @State private var showText = false
    @Binding var layoutData: SelectedData
    
    @AppStorage("OverviewSelection") var OverviewSelection: String?
    
    var body: some View {
        ZStack(alignment: .leading){

            HStack(){
                Button(action: {
                    
                    showDefault.toggle()
                    showCritical = false
                    showMap = false
                    showMinimum = false
                    showDIY = false
                    layoutData.layoutSelection = "Default"
                    UserDefaults.standard.set("Default", forKey: "OverviewSelection")
                    
                }) {
                    
                    if showDefault {
                        
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Calming_Green)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle.inset.filled")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.white)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Default")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                            
                        }

                    } else {
                         
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                Image(systemName: "circle")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Default")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                        }
                        
                        .foregroundColor(Color.green)
                    }
                    
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.horizontal, 20.0)
                .frame(width: 280, height: 40)
            
            ZStack(){
                Button(action: { withAnimation {

                    dropdown.toggle()
                } }) {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
                    
                }
                .background(Circle().fill(Color.white))
                
                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
                .offset(x: -55, y: -25)
                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
            }  .offset(x: 305, y: 40)
        }.padding(.vertical, 20)
        
        
        if dropdown {

            DefaultViewOverview()
        }

        //MARK: Critical
        ZStack(alignment: .leading){
            
            HStack(){
                Button(action: {
                    
                    showDefault = false
                    showCritical.toggle()
                    showMap = false
                    showMinimum = false
                    showDIY = false
                    layoutData.layoutSelection = "Critical"
                    UserDefaults.standard.set("Critical", forKey: "OverviewSelection")
                    
                }) {
                    
                    if showCritical {
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Calming_Green)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle.inset.filled")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.white)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Critical")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                        }
                        .foregroundColor(Color.green)
                    } else {
                        
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Critical")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                            
                        }
                    }
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.horizontal, 20.0)
                .frame(width: 280, height: 40)
            
            
            ZStack(){
                Button(action: { withAnimation {
                    
                    dropdownCritical.toggle()
                } }) {

                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdownCritical ? 180 : 0))

                }
                .background(Circle().fill(Color.white))
                .offset(x: -55, y: -20)
                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
            }  .offset(x: 305, y: 40)
        }.padding(.vertical, 20)
        
        
        if dropdownCritical {
            
            CriticalViewOverview()

        }
        
        //MARK: Map
        
        ZStack(alignment: .leading){
            
            HStack(){
                Button(action: {
                    
                    showMap.toggle()
                    
                    showDefault = false
                    showCritical = false
                    showMinimum = false
                    showDIY = false
                    layoutData.layoutSelection = "Map"
                    UserDefaults.standard.set("Map", forKey: "OverviewSelection")
                    
                }) {
                    
                    if showMap {
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Calming_Green)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                Image(systemName: "circle.inset.filled")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.white)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Map")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                        }
                        .foregroundColor(Color.green)
                    } else {
                        
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Map")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                            
                        }
                    }
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.horizontal, 20.0)
                .frame(width: 280, height: 40)
            
            
            ZStack(){
                Button(action: { withAnimation {
                    
                    dropdownMap.toggle()
                } }) {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdownMap ? 180 : 0))
                    
                }
                .background(Circle().fill(Color.white))
                
                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
                .offset(x: -55, y: -25)
                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
            }  .offset(x: 305, y: 40)
        }.padding(.vertical, 20)
        
        if dropdownMap {
            
            MapViewOverview()
            //.padding(.vertical, 20.0)
            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
        }
        
        //MARK: Minimum
        
        ZStack(alignment: .leading){
            
            HStack(){
                Button(action: {
                    
                    showMinimum.toggle()
                    showDefault = false
                    showCritical = false
                    showMap = false
                    showDIY = false
                    layoutData.layoutSelection = "Minimum"
                    UserDefaults.standard.set("Minimum", forKey: "OverviewSelection")
                    
                }) {
                    
                    if showMinimum {
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Calming_Green)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                Image(systemName: "circle.inset.filled")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.white)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Minimum")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                        }
                        .foregroundColor(Color.green)
                    } else {
                        
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("Minimum")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                            
                        }
                    }
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.horizontal, 20.0)
                .frame(width: 280, height: 40)
            
            
            ZStack(){
                Button(action: { withAnimation {
                    
                    dropdownMinimum.toggle()
                } }) {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdownMinimum ? 180 : 0))
                    
                }
                .background(Circle().fill(Color.white))
                
                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
                .offset(x: -55, y: -25)
                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
            }  .offset(x: 305, y: 40)
        }.padding(.vertical, 20)
        
        if dropdownMinimum {
            
            MinimumViewOverview()
            //.padding(.vertical, 20.0)
            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
        }
        
        //MARK: DIY
        
        ZStack(alignment: .leading){
            
            HStack(){
                Button(action: {
                    
                    showDIY.toggle()
                    showDefault = false
                    showCritical = false
                    showMinimum = false
                    showMap = false
                    layoutData.layoutSelection = "DIY"
                    UserDefaults.standard.set("DIY", forKey: "OverviewSelection")
                    
                }) {
                    
                    if showDIY {
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Calming_Green)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                Image(systemName: "circle.inset.filled")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.white)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("DIY")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                        }
                        .foregroundColor(Color.green)
                    } else {
                        
                        
                        ZStack(alignment: .leading){
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
                                .frame(width: 330, height: 60)
                            
                            HStack(spacing: 20){
                                
                                
                                Image(systemName: "circle")
                                    .font(.title2)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .padding(10.0)
                                VStack(alignment: .leading){
                                    Text("DIY")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .padding(-10)
                                }
                            }
                            
                        }
                    }
                }.buttonStyle(PlainButtonStyle())
                
            }.padding(.horizontal, 20.0)
                .frame(width: 280, height: 40)
            
            
            ZStack(){
                Button(action: { withAnimation {
                    
                    dropdownDIY.toggle()
                } }) {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdownDIY ? 180 : 0))
                    
                }
                .background(Circle().fill(Color.white))
                
                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
                .offset(x: -55, y: -25)
                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
            }  .offset(x: 305, y: 40)
        }.padding(.vertical, 20)
        
        if dropdownDIY {
            
            DIYViewOverview()
            //.padding(.vertical, 20.0)
            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
        }
        
        
    }
}

//MARK: CriticalViewDrop
//struct CriticalViewDrop: View {
//
//    @State private var showButtons = false
//    //    @Environment(\.presentationMode) var presentationMode
//    @State private var dropdown = false
//
//    @State private var showDefault = false
//
////    State private var showDefault : Bool = false
////    @State private var showDefault = true
//    @State private var showCritical = false
////    @State private var showHorizon = false
////    @State private var showText = false
//    @Binding var layoutData: SelectedData
//
//    var body: some View {
////        ZStack(alignment: .leading){
////            RoundedRectangle(cornerRadius: 15, style: .continuous)
////                .fill(Color.white)
////            //                    .opacity(0.4)
////            //                    .padding(.leading, 120.0)
////                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
////                .frame(width: 330, height: 50)
////
////
////            HStack(){
////
////                HStack(spacing: -20){
////                    Image(systemName: "bolt.heart.fill")
////                        .font(.title2)
////                        .frame(width: 40.0, height: 40.0)
////                        .foregroundColor(Color.black)
////                        .padding(10.0)
////                }
////                VStack(alignment: .leading){
////                    Text("Critical")
////                        .font(.title3)
////                        .foregroundColor(Color.black)
////                        .fontWeight(.semibold)
////                }
////            }
//        ZStack(alignment: .leading){
//
//            HStack(){
//                Button(action: {
//                    //                        image = Image("Circle_Stack")
////                    showDefault = false
//                    showCritical.toggle()
//                    showDefault.toggle()
////                    showText = false
////                    showHorizon = false
//
//                    layoutData.layoutSelection = "Circle_Stack"
//
//                }) {
//
//                    if showCritical {
//
//                        ZStack(alignment: .leading){
//
//                            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                                .fill(Color.Calming_Green)
//                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                                .frame(width: 330, height: 60)
//
//                            HStack(spacing: 20){
//
//                                Image(systemName: "circle.inset.filled")
//                                    .font(.title2)
//                                    .frame(width: 40.0, height: 40.0)
//                                    .foregroundColor(Color.white)
//                                    .padding(10.0)
//                                VStack(alignment: .leading){
//                                    Text("Critical")
//                                        .font(.title3)
//                                        .foregroundColor(Color.white)
//                                        .fontWeight(.semibold)
//                                        .padding(-10)
//                                }
//                            }
//                        }
//                        .foregroundColor(Color.green)
//                    } else {
//
//
//                        ZStack(alignment: .leading){
//
//                            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                                .fill(Color.white)
//                                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                                .frame(width: 330, height: 60)
//
//                            HStack(spacing: 20){
//
//
//                                Image(systemName: "circle")
//                                    .font(.title2)
//                                    .frame(width: 40.0, height: 40.0)
//                                    .foregroundColor(Color.black)
//                                    .padding(10.0)
//                                VStack(alignment: .leading){
//                                    Text("Critical")
//                                        .font(.title3)
//                                        .foregroundColor(Color.black)
//                                        .fontWeight(.semibold)
//                                        .padding(-10)
//                                }
//                            }
//
//                        }
//                    }
//                }.buttonStyle(PlainButtonStyle())
//
//            }.padding(.horizontal, 20.0)
//                .frame(width: 280, height: 40)
//
//
//            ZStack(){
//                Button(action: { withAnimation {
//
//                    dropdown.toggle()
//                } }) {
//                    Image(systemName: "chevron.down")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .padding(showButtons ? 15.0 : 15.0)
//                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
//
//                }
//                .background(Circle().fill(Color.white))
//
//                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
//                .offset(x: -55, y: -25)
//                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
//            }  .offset(x: 305, y: 40)
//        }.padding(.vertical, 20)
//
//
//        if dropdown {
//
//            CriticalViewOverview()
//            //.padding(.vertical, 20.0)
//            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
//        }
//
//    }
//}

//MARK: MapViewDrop
//struct MapViewDrop: View {
//
//    @State private var showButtons = false
//    //    @Environment(\.presentationMode) var presentationMode
//    @State private var dropdown = false
//
//    var body: some View {
//        ZStack(alignment: .leading){
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color.white)
//            //                    .opacity(0.4)
//            //                    .padding(.leading, 120.0)
//                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                .frame(width: 330, height: 50)
//
//
//            HStack(){
//
//                HStack(spacing: -20){
//                    Image(systemName: "bolt.heart.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(10.0)
//                }
//                VStack(alignment: .leading){
//                    Text("Map")
//                        .font(.title3)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.semibold)
//                }
//            }
//
//            ZStack(){
//                Button(action: { withAnimation {
//
//                    dropdown.toggle()
//                } }) {
//                    Image(systemName: "chevron.down")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .padding(showButtons ? 15.0 : 15.0)
//                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
//
//                }
//                .background(Circle().fill(Color.white))
//
//                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
//                .offset(x: -55, y: -25)
//                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
//            }  .offset(x: 325, y: 40)
//        }
//
//        if dropdown {
//
//            MapViewOverview()
//            //.padding(.vertical, 20.0)
//            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
//        }
//
//    }
//}

//MARK: MinimumDrop
//struct MinimumDrop: View {
//
//    @State private var showButtons = false
//    //    @Environment(\.presentationMode) var presentationMode
//    @State private var dropdown = false
//
//    var body: some View {
//        ZStack(alignment: .leading){
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color.white)
//            //                    .opacity(0.4)
//            //                    .padding(.leading, 120.0)
//                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                .frame(width: 330, height: 50)
//
//
//            HStack(){
//
//                HStack(spacing: -20){
//                    Image(systemName: "bolt.heart.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(10.0)
//                }
//                VStack(alignment: .leading){
//                    Text("Minimum")
//                        .font(.title3)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.semibold)
//                }
//            }
//
//            ZStack(){
//                Button(action: { withAnimation {
//
//                    dropdown.toggle()
//                } }) {
//                    Image(systemName: "chevron.down")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .padding(showButtons ? 15.0 : 15.0)
//                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
//
//                }
//                .background(Circle().fill(Color.white))
//
//                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
//                .offset(x: -55, y: -25)
//                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
//            }  .offset(x: 325, y: 40)
//        }
//
//        if dropdown {
//
//            MinimumViewOverview()
//            //.padding(.vertical, 20.0)
//            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
//        }
//
//    }
//}


//MARK: DoItYourselfDrop
//struct DoItYourselfDrop: View {
//
//    @State private var showButtons = false
//    //    @Environment(\.presentationMode) var presentationMode
//    @State private var dropdown = false
//
//    var body: some View {
//        ZStack(alignment: .leading){
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color.white)
//            //                    .opacity(0.4)
//            //                    .padding(.leading, 120.0)
//                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                .frame(width: 330, height: 50)
//
//
//            HStack(){
//
//                HStack(spacing: -20){
//                    Image(systemName: "bolt.heart.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(10.0)
//                }
//                VStack(alignment: .leading){
//                    Text("DIY")
//                        .font(.title3)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.semibold)
//                }
//            }
//
//            ZStack(){
//                Button(action: { withAnimation {
//
//                    dropdown.toggle()
//                } }) {
//                    Image(systemName: "chevron.down")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .padding(showButtons ? 15.0 : 15.0)
//                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
//
//                }
//                .background(Circle().fill(Color.white))
//
//                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
//                .offset(x: -55, y: -25)
//                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
//            }  .offset(x: 325, y: 40)
//        }
//
//        if dropdown {
//
//            DIYViewOverview()
//            //.padding(.vertical, 20.0)
//            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
//        }
//
//    }
//}



//struct ExtractedView2: View {
//    
//    @State private var showButtons = false
//    //    @Environment(\.presentationMode) var presentationMode
//    @State private var dropdown = false
//    
//    var body: some View {
//        ZStack(alignment: .leading){
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color.white)
//            //                    .opacity(0.4)
//            //                    .padding(.leading, 120.0)
//                .shadow(color: Color.colorCardiGray, radius: 3, y: 0)
//                .frame(width: 340, height: 50)
//            
//            
//            HStack(){
//                
//                HStack(spacing: -20){
//                    Image(systemName: "bolt.heart.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(10.0)
//                }
//                VStack(alignment: .leading){
//                    Text("Default")
//                        .font(.title3)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.semibold)
//                }
//            }
//            
//            ZStack(){
//                Button(action: { withAnimation {
//                    
//                    dropdown.toggle()
//                } }) {
//                    Image(systemName: "chevron.down")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .padding(showButtons ? 15.0 : 15.0)
//                        .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
//                    
//                }
//                .background(Circle().fill(Color.white))
//                
//                //                    .offset(showButtons ? (x: -55, y: -2) : (x: -155, y: -2))
//                .offset(x: -55, y: -25)
//                .shadow(color: Color.colorCardiGray, radius: 2, y: 3)
//            }  .offset(x: 305, y: 40)
//        }
//        
//        if dropdown {
//            
//            DefaultViewOverview()
//            //.padding(.vertical, 20.0)
//            //.padding(.trailing, 80.0) //.frame(width: 270, height: 100)
//        }
//        
//    }
//}


//MARK: DefaultViewOverview
struct DefaultViewOverview: View {
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
                .padding(.top, -5.0)
                .shadow(radius: 1, y: 2)
                .frame(width: 320, height: 295)
            
            
            
            //            VStack(alignment: .leading){
            
            VStack(){
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "bolt.heart.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("AED Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Communicator Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "battery.100")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Battery & Status")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Expiration & Signal info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "figure.walk")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Movements")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "checklist")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Self Test")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
//                HStack(spacing: 0){
//                    Image(systemName: "ticket.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(0.0)
//
//                    Text("Service Tickets")
//                        .font(.callout)
//                        .foregroundColor(Color.black)
//                    Spacer()
//
//                }.padding(.horizontal, 0.0)
//                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "envelope.badge.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Messages")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "map.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Map & Info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
            }
        }.padding(.vertical, 20.0)
    }
}

//MARK: CriticalViewOverview
struct CriticalViewOverview: View {
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
                .padding(.top, -5.0)
                .shadow(radius: 1, y: 2)
                .frame(width: 320, height: 255)
            
            
            
            //            VStack(alignment: .leading){
            
            VStack(){
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "bolt.heart.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("AED Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Communicator Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "figure.walk")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Movements")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "battery.100")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Battery & Status")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Expiration & Signal info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "envelope.badge.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Messages")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "checklist")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Self Test")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
            }
        }.padding(.vertical, 20.0)
    }
}

//MARK: MapViewOverview
struct MapViewOverview: View {
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
                .padding(.top, -5.0)
                .shadow(radius: 1, y: 2)
                .frame(width: 320, height: 295)
            
            
            
            //            VStack(alignment: .leading){
            
            VStack(){
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "bolt.heart.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("AED Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Communicator Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "map.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Map & Info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "figure.walk")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Movements")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "battery.100")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Battery & Status")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "checklist")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Self Test")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Expiration & Signal info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "envelope.badge.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Last Messages")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                
                
//                HStack(spacing: 0){
//                    Image(systemName: "ticket.fill")
//                        .font(.title2)
//                        .frame(width: 40.0, height: 40.0)
//                        .foregroundColor(Color.black)
//                        .padding(0.0)
//
//                    Text("Service Tickets")
//                        .font(.callout)
//                        .foregroundColor(Color.black)
//                    Spacer()
//
//                }.padding(.horizontal, 0.0)
//                    .frame(width: 280, height: 20)
                
                
                
            }
        }.padding(.vertical, 20.0)
    }
}


//MARK: MapViewOverview
struct MinimumViewOverview: View {
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
                .padding(.top, -5.0)
                .shadow(radius: 1, y: 2)
                .frame(width: 320, height: 165)
            
            
            
            //            VStack(alignment: .leading){
            
            VStack(){
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "bolt.heart.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("AED Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Communicator Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "battery.100")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Battery & Status")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Expiration & Signal info")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
            }
        }.padding(.vertical, 20.0)
    }
}


//MARK: DIYViewOverview
struct DIYViewOverview: View {
    
    @State var batterySwitch: Bool = false
    @State var expirationSwitch: Bool = false
    @State var movementsSwitch: Bool = false
    @State var selftestSwitch: Bool = false
    @State var serviceTicketsSwitch: Bool = false
    @State var lastMessagesSwitch: Bool = false
    @State var mapSwitch: Bool = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack(){
            
            
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            
                .padding(.top, -5.0)
                .shadow(radius: 1, y: 2)
                .frame(width: 320, height: 420)
            
            
            
            //            VStack(alignment: .leading){
            
            VStack(){
                
                
                
                
                HStack(spacing: 0){
                    Image(systemName: "bolt.heart.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("AED Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                HStack(spacing: 0){
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Text("Communicator Information")
                        .font(.callout)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 20)
                
                
                HStack(spacing: 0){
                    Image(systemName: "battery.100")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    
                    Toggle("Battery & Status", isOn: $batterySwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: batterySwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYBattery")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYBattery")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)
                
                HStack(spacing: 0){
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Toggle("Expiration & Signal info", isOn: $expirationSwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: expirationSwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYCrucial")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYCrucial")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)
                
                HStack(spacing: 0){
                    Image(systemName: "figure.walk")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Toggle("Movements", isOn: $movementsSwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: movementsSwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYMovements")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYMovements")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)
                
                HStack(spacing: 0){
                    Image(systemName: "checklist")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    
                    Toggle("Last Self Test", isOn: $selftestSwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: selftestSwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYLastSelfTests")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYLastSelfTests")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)

                HStack(spacing: 0){
                    Image(systemName: "envelope.badge.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Toggle("Last Message", isOn: $lastMessagesSwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: lastMessagesSwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYLastMessage")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYLastMessage")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)
                
                
                HStack(spacing: 0){
                    Image(systemName: "map.fill")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .padding(0.0)
                    
                    Toggle("Map & Info", isOn: $mapSwitch)
                        .foregroundColor(Color.black)
                        .onChange(of: mapSwitch) { value in
                            print(value)
                            
                            if value == false {
                                
                                defaults.set("NO", forKey: "DIYMapInfo")
                                
                            } else {
                                
                                defaults.set("YES", forKey: "DIYMapInfo")
                            }
                            
                        } .toggleStyle(SwitchToggleStyle(tint: Color.Calming_Green))
                    
                }.padding(.horizontal, 0.0)
                    .frame(width: 280, height: 40)
                
            }
        }.padding(.vertical, 20.0)
    }
    
    
}

