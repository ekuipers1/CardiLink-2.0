//
//  MapView2.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.02.22.
//

import SwiftUI
import MapKit

struct MapView2: View {
    
    let location: PlaceDefi
    let places: [PlaceDefi]
    
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        let _ =  print("Top currentPage", currentPage)
        let _ =  print("Top totalPages", totalPages)
        
        if currentPage > totalPages{
            
            Home(location: MapDirectory().places[0], places: MapDirectory().places)
        }
        else{
            WalkthroughScreen()
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        //        MapView2()
        MapView2(location: MapDirectory().places[0], places: MapDirectory().places)
    }
}


struct Home: View {
    let location: PlaceDefi
    let places: [PlaceDefi]
    
    @State var isActive: Bool = false
    @State var selectedAnnotation: MKAnnotation?
    
    
    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) private var presentationMode
    
    init(location: PlaceDefi, places: [PlaceDefi]) {
        self.location = location
        self.places = places
        _region = State(initialValue: location.region)
    }
    
    var body: some View{
        
        ZStack {
            
            MapViewUI(location: location, places: places, mapViewType: mapType)
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                    }
                    
                    Spacer()
                }
                .padding()
                Spacer()
                Picker("", selection: $mapType) {
                    Text("Standard").tag(MKMapType.standard)
                    Text("Hybrid").tag(MKMapType.hybrid)
                    Text("Satellite").tag(MKMapType.satellite)
                }
                //        .padding(.horizontal, 20.0)
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.colorCardiOrange)
                .cornerRadius(8)
                .opacity(0.8)
                .padding(.horizontal, 20)
                .offset(y: -65)
                .frame(width: 300, height: 40)
            }.overlay(
                
                
                HStack(alignment: .center, spacing: 12) {
                    Button(action:{ self.presentationMode.wrappedValue.dismiss()
                        
                    UserDefaults.standard.set("", forKey: "SelectedDefi")
                    }){
                        
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                    }
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Map")
                            .fontWeight(.bold)
                            .font(.title)
                    }.padding(.trailing, 0.0).frame(width: 200, height: 50)
                    
                    let defaults = UserDefaults.standard
                    let backend = defaults.string(forKey: "Backend")
                    if backend == "NEW" {
                    
                    
                    
                    NavigationLink(destination: DefibrillatorOverview()) {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                    }.simultaneousGesture(TapGesture().onEnded{
//                        DefiGetsingleData()
//                        getNKMessagesData()
//                        getmovementData()
                        LoadMyData()
                    })
                    } else {
                    
                        NavigationLink(destination: DefibrillatorDetailed()) {
                            Image(systemName: "info.circle")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }.simultaneousGesture(TapGesture().onEnded{
    //                        DefiGetsingleData()
    //                        getNKMessagesData()
    //                        getmovementData()
                            LoadMyData()
                        })
                    } //: HSTACK
                    
                    
                }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        Color.colorCardiOrange
                            .cornerRadius(25)
                            .opacity(0.8)
                    )
                    .padding(.vertical, 55)
                , alignment: .top
            )
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
}




struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    let defaults = UserDefaults.standard
    
    var body: some View{
        
        
        let _ =  print("Walk currentPage", currentPage)
        let _ =  print("Walk totalPages", totalPages)
        
        // For Slide Animation...
        
        ZStack{
            MainBackground()
            // Changing Between Views....
            
            if currentPage == 1{
                ScreenView(image: "Map_Old", title: "New maps".localized, detail: "We have updated our map architecture to have better performance, less clutter and a updated user experience".localized, bgColor: Color("Cardi_Orange"))
                    .transition(.scale)
            }
            if currentPage == 2{
                
                ScreenView(image: "Map_New", title: "Pin clusters".localized, detail: "We have introduced pin clusters, pinch and zoom (out or in) will cluster or un-cluster a amount of pins that are in close reach of each other, resulting is a cleaner look and feel".localized, bgColor: Color("color2"))
                    .transition(.scale)
            }
            
            if currentPage == 3{
                
                ScreenView(image: "Map_Detail", title: "Pin Information".localized, detail: "To get more detailed information you can click on a pointer, it will show the AED number and the owner".localized, bgColor: Color("color3"))
                    .transition(.scale)
            }
            
            if currentPage == 4{
                
                ScreenView(image: "Map_Info", title: "Detailed Information".localized, detail: "After you select a pointer and you wish to see more detailed information simply click on the ( i ) button in the upper right of the screen. This will take you to the Detailed Defibrillator page".localized, bgColor: Color("color3"))
                    .transition(.scale)
            }
            
            if currentPage == 5{
                
                ScreenView(image: "Map_Types", title: "Map Types".localized, detail: "We have also introduced two extra types of maps, Hybrid and Satellite. If you want to view this onboarding again, go to the dashboard, select About, go to settings and flip the switch.".localized, bgColor: Color("color3"))
                    .transition(.scale)
            }
            
        }      //  .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .overlay(
            
            // Button...
            Button(action: {
                // changing views...
                withAnimation(.easeInOut){
                    defaults.set("NO", forKey: "mapOnboarding")
                    // checking....
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.colorCardiOrange)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                // Circlular Slider...
                    .overlay(
                        
                        ZStack{
                            
                            Circle()
                                .stroke(Color.colorCardiOrange.opacity(0.2),lineWidth: 4)
                            
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.colorCardiOrange,lineWidth: 6)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
            })
                .padding(.bottom,20)
            
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("userOwner") var userOwner: String?
    
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                
                // Showing it only for first Page...
                if currentPage == 1{
                    Text("Hello ".localized + (userOwner ?? ".."))
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading, 60)
                        .padding(.top, 60)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                    // Letter Spacing...
                    //                        .kerning(1.4)
                }
                else{
                    // Back Button...
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                            .padding(.leading, 60)
                            .padding(.top, -10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 6
                    }
                }, label: {
                    Text("Skip")
                        .font(.title2)
                        .frame(width: 120.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(50)
                        .padding(.top, -10)
                        .padding(.trailing, 60)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                })
            }
            //            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            //            Spacer()
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            
            // Change with your Own Thing....
            Text(detail)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 70)
            // Minimum Spacing When Phone is reducing...
            Spacer()
            Spacer(minLength: 120)
        }
        //        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

// total Pages...
var totalPages = 5
