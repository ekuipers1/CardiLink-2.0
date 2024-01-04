//
//  XXDefibrillatorMovement.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 03.11.21.
//

import SwiftUI
import MapKit

struct XXDefibrillatorMovement: View {
    
    @State private var animation: Double = 0.0
    @State private var expand = false
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(){
            ZStack(){
                
                MainBackground()
                    .padding(.top, 240.0)
//                TopViewBackround()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            
                        }){
                            
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
//                                .padding(.trailing, 20.0)
                        }
                        .padding(.leading, 100.0)
                        Text(" Movement ")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
//                            .fontWeight(.bold)
//                            .font(.title2)
//                            .foregroundColor(Color.black)
//                            .padding(.trailing, 80.0)
                        
                    }
                    .padding(.top, 60.0)
                    .padding(.bottom, 30)
//                    .padding(.top, 20.0)
//                    .frame(width: 350, height: 70)
                }
            }
            .frame(width: 450, height: 100)
            
            ZStack(){
                
                ScrollView {
                    
                    defiMainInfo()
                        .padding(.top, 20.0)
                    mapData()
                        .padding(.top, 20.0)
                    geoAddressData()
                        .padding(.top, 20.0)
                    geoLatLonsData()
                        .padding(.top, 20.0)
                    geoFencesData()
                        .padding(.vertical, 20.0)
                        .padding(.bottom, 60.0)
                    Spacer()
                }
                
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct XXDefibrillatorMovement_Previews: PreviewProvider {
    static var previews: some View {
        XXDefibrillatorMovement()
    }
}

struct PlaceMovement: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct mapDataMovement: View {
    
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.380898, longitude: 2.122820),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @AppStorage("geoLocationLat") var geoLocationLat: String?
    @AppStorage("geoLocationLon") var geoLocationLon: String?
    @AppStorage("defridetailID") var defridetailID: String?
    
    var body: some View {
        
        let myDoubleLat = Double(geoLocationLat ?? "33.814971")
        let myDoubleLon = Double(geoLocationLon ?? "-117.921279")
        
        let _ = print("DEFILAT1", myDoubleLat as Any)
        let _ = print(myDoubleLon as Any)
        
        
        if myDoubleLat == nil {
            
            let places = [
                Place(name: "No Data Available", latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100)
            ]
            
            Map(coordinateRegion: $coordinateRegion, interactionModes: [], annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    
                    VStack(){
                        Image(systemName: "xmark.octagon.fill").foregroundColor(.colorCardiRed)
                            .font(.title)
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
                    
                }
                
            }.frame(width: 350, height: 300, alignment: .center)
            .cornerRadius(25)
            .shadow(radius: 5, y: 5)
            .opacity(0.5)
            
        } else {
            
            let places = [
                Place(name: defridetailID ?? "Camp Nou", latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820)
            ]
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myDoubleLat ?? 41.380898, longitude: myDoubleLon ?? 2.122820), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))), annotationItems: places) { place in
                
                
                MapAnnotation(coordinate: place.coordinate) {
                
                    
                    //MARK: Possible solution GEO Fence
                    //Devide by map box with?
//                    ZStack(){
//                    Circle()
//                           .fill(Color.Calming_Green)
//                           .opacity(0.3)
//                           .frame(width: 132, height: 132)
                    
                    VStack(){
                        HStack(){
                            Image(systemName: "wave.3.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,
                                       height: 30)
                                .padding([.top, .trailing], -20)
                                .foregroundColor(Color.Cardi_MapBlue)
                            
                            Image(systemName: "mappin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,
                                       height: 30)
                                .foregroundColor(Color.Cardi_MapBlue)
                            
                            Image(systemName: "wave.3.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,
                                       height: 30)
                                .padding([.top, .leading], -20)
                                .foregroundColor(Color.Cardi_MapBlue)

                        }
                        Text(defridetailID ?? "Camp Nou")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color.Cardi_MapBlue)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
//                    .overlay(
//                    Circle()
////                        .fill(Color.blue)
////                        .frame(width: 283, height: 283)
////                        .opacity(0.15)
//                    )
//                } CIRCLE
            }
            }.frame(width: 350, height: 300, alignment: .center)
            .cornerRadius(25)
            .shadow(radius: 5, y: 5)
            
            
        }
    }
}





struct geoAddressDataMovement: View {
    
    @AppStorage("geoAddressStreet") var geoAddressStreet: String?
    @AppStorage("geoAddressNumber") var geoAddressNumber: String?
    @AppStorage("geoAddressFloor") var geoAddressFloor: String?
    @AppStorage("geoAddressPostal") var geoAddressPostal: String?
    @AppStorage("geoAddressCity") var geoAddressCity: String?
    @AppStorage("geoAddressCountry") var geoAddressCountry: String?
    @AppStorage("geoAddressComment") var geoAddressComment: String?
    
    
    @State private var presentingSheet = false
//    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Address") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Street:")
                            HStack(){
                                Image(systemName: "house")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(geoAddressStreet ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("House number:")
                        HStack(){
                            Image(systemName: "number.square")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressNumber ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Floor level:")
                        
                        HStack(){
                            Image(systemName: "arrow.up.square")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressFloor ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                        
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Postal Code:")
                        HStack(){
                            Image(systemName: "00.square")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressPostal ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("City:")
                        HStack(){
                            Image(systemName: "map")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressCity ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Country:")
                        HStack(){
                            Image(systemName: "globe")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressCountry ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Comment:")
                        HStack(){
                            Image(systemName: "text.quote")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoAddressComment ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}


struct geoLatLonsDataMovement: View {
    
    @AppStorage("geoLocationLat") var geoLocationLat: String?
    @AppStorage("geoLocationLon") var geoLocationLon: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Geo location") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Latitude:")
                            HStack(){
                                Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(geoLocationLat ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Longitude:")
                        HStack(){
                            Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoLocationLon ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct geoFencesDataMovement: View {
    
    @AppStorage("geoFenceType") var geoFenceType: String?
    @AppStorage("geoFenceRadius") var geoFenceRadius: String?
    
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Geo fence") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Type:")
                            HStack(){
                                Image(systemName: "dot.squareshape.split.2x2")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(geoFenceType ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Radius: ")
                        HStack(){
                            Image(systemName: "checkmark.icloud")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(geoFenceRadius ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}

