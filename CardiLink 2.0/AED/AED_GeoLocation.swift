//
//  AED_GeoLocation.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 25.09.23.
//

import SwiftUI
import MapKit

struct AED_GeoLocation: View {
    
    @State private var animation: Double = 0.0
    @State private var expand = false
    @AppStorage("dashboardState") var dashboardState: String?
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(){
            ZStack(){
                let backroundColor = Int(dashboardState ?? "N/A") ?? 0
                switch backroundColor {
                case 0:
                    MainBackgroundGreen()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 1:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 2:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 3:
                    MainBackgroundYellow()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 4:
                    MainBackgroundRed()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                case 5:
                    MainBackgroundGray()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                default:
                    MainBackground()
                        .padding(.top, 240.0)
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .leading){
                    
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            
                            UserDefaults.standard.set("N/A", forKey: "geoLocationLat")
                            UserDefaults.standard.set("N/A", forKey: "geoLocationLon")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressStreet")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressNumber")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressFloor")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressPostal")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressCity")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressCountry")
                            UserDefaults.standard.set("N/A", forKey: "geoAddressComment")
                            UserDefaults.standard.set("N/A", forKey: "geoFenceType")
                            UserDefaults.standard.set("N/A", forKey: "geoFenceRadius")
                            
                        }){
                            
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .padding(.leading, 100.0)
                        Text("Geo location")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
                        
                    }
                    .padding(.top, 60.0)
                    .padding(.bottom, 30)
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

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

struct mapData: View {
    
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 00.100, longitude: 00.100),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @AppStorage("geoLocationLat") var geoLocationLat: String?
    @AppStorage("geoLocationLon") var geoLocationLon: String?
    @AppStorage("defridetailID") var defridetailID: String?
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    
    var body: some View {
        
        let defaults = UserDefaults.standard
        let myDoubleLat = Double(geoLocationLat ?? "00.100")
        let myDoubleLon = Double(geoLocationLon ?? "00.100")
        
        let _ = print("DEFILAT1NEW", myDoubleLat as Any)
        let _ = print(myDoubleLon as Any)
        
        if myDoubleLat == nil {
            let places = [
                Place(name: "No Data Available", latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100)
            ]
            
            Map(coordinateRegion: $coordinateRegion, interactionModes: [], annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    
                    VStack(){
                        HStack(){
                            Image(systemName: "xmark.octagon.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130,
                                       height: 130)
                                .foregroundColor(.colorCardiRed)
                        }
                        Text("No Data Available")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color.colorCardiRed)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
                    
                }
                
            }.frame(width: 350, height: 300, alignment: .center)
                .cornerRadius(25)
                .shadow(radius: 5, y: 5)
            
        } else {
            
            let places = [
                Place(name: defridetailSerial ?? "No Data Available", latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100)
            ]
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myDoubleLat ?? 00.100, longitude: myDoubleLon ?? 00.100), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))), annotationItems: places) { place in
                
                MapAnnotation(coordinate: place.coordinate) {
                    VStack(){
                        HStack(){
                            Image(systemName: "bolt.heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,
                                       height: 30)
                                .foregroundColor(Color.Cardi_MapBlue)
                        }
                        Text(defridetailSerial ?? "No Data Available")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color.Cardi_MapBlue)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .shadow(radius: 5, y: 5)
                }
            }.frame(width: 350, height: 300, alignment: .center)
                .cornerRadius(25)
                .shadow(radius: 5, y: 5)
            
        }
    }
}

