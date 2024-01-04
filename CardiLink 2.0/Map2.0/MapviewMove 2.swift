//
//  MapviewMove.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.03.22.
//

import SwiftUI
import MapKit

struct MapviewMove: View {
    
    let location: PlaceDefiMove
    let places: [PlaceDefiMove]
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
       
        HomeMove(location: MapDirectoryMove().places[0], places: MapDirectoryMove().places)
        
    }
}

//struct MapviewMove_Previews: PreviewProvider {
//    static var previews: some View {
//        MapviewMove(location: MapDirectory().places[0], places: MapDirectory().places)
//    }
//}



struct HomeMove: View {
    let location: PlaceDefiMove
    let places: [PlaceDefiMove]
    
    @State var isActive: Bool = false
    @State var selectedAnnotation: MKAnnotation?
    
    @AppStorage("NoMoveMents") var NoMoveMents: String?
    
    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) private var presentationMode
    
    init(location: PlaceDefiMove, places: [PlaceDefiMove]) {
        self.location = location
        self.places = places
        _region = State(initialValue: location.region)
    }
    
    
    @State private var lineCoordinates = [
        CLLocationCoordinate2D(latitude : 50.17872061411607, longitude : 9.80948129957236),
//       CLLocationCoordinate2D(latitude : 50.19316025906173, longitude : 10.34794495911499),
////        CLLocationCoordinate2D(latitude : 49.70448745399307, longitude : 11.15535612286288),
//        CLLocationCoordinate2D(latitude : 49.15559640869309, longitude : 11.31715056753865)
    ];
    
    
    
    
    @State private var newRegion: MKCoordinateRegion = {
        
        var currentLocation = CLLocationCoordinate2D(latitude: 48.83869088232576, longitude: 8.861444423693237)
        
        var mapCoordinates = CLLocationCoordinate2D(latitude: 10.39606025, longitude: 99.1301757166667)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 10.0005, longitudeDelta: 10.0005)
        var mapRegion = MKCoordinateRegion(center: currentLocation, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    var body: some View{
        

        
        
        ZStack {

//            MapviewMoveUI(location: location, places: places, mapViewType: mapType)
            MapviewMoveUI(location: location, places: places, mapViewType: mapType, lineCoordinates: lineCoordinates)
            
            ZStack {
            if NoMoveMents == "0" {
            
                VStack(){
                    HStack(){
                    Image(systemName: "xmark.octagon.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130,
                               height: 130)
                        .foregroundColor(.colorCardiRed)
//                                .font(.title)
//                                .frame(width: 160.0, height: 160.0)
//                                .foregroundColor(Color.white)
                    }
                    Text("There are no known GPS coordinates for this defibrillator")
                        .fontWeight(.bold)
                        .foregroundColor(Color.Cardi_Text_Inf)
//                      .background(Color.white)
//                        .foregroundColor(Color.colorCardiRed)
//                      .background(Color.white)
                      .multilineTextAlignment(.leading)
                      .frame(width: 250,
                             height: 130)
                      .font(.system(size: 25))
                }
                .padding()
                .foregroundColor(.black)
                .cornerRadius(40)
                .shadow(radius: 5, y: 5)
                
            }
            
            
            
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
                        
//                        clearGeoMoveHere()
                        
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
                    }.padding(.trailing, 40.0).frame(width: 240, height: 50)
                    

                    
                    
//                    Image(systemName: "info.circle")
//                                                .font(.title)
//                                                .frame(width: 40.0, height: 40.0)
//                                                .foregroundColor(Color.black)
//                                                .background(Color.white)
//                                                .cornerRadius(50)
//                                                .contextMenu {
//                                                    Button(action: {}) {
//                                                    Text("Add color")
//                                                    Image(systemName: "eyedropper.full")
//                                                                                    }
//                                                }
//                    NavigationLink(destination: DefibrillatorDetailed()) {
//                        Image(systemName: "info.circle")
//                            .font(.title)
//                            .frame(width: 40.0, height: 40.0)
//                            .foregroundColor(Color.black)
//                            .background(Color.white)
//                            .cornerRadius(50)
//                            .contextMenu {
//                                Button(action: {}) {
//                                    Text("Add color")
//                                    Image(systemName: "eyedropper.full")
//                                }
//                                Button(action: {}) {
//                                    Image(systemName: "circle.lefthalf.fill")
//                                    Text("Change contrast")
//                                }
//                            }
//                    }.simultaneousGesture(TapGesture().onEnded{
//                        DefiGetsingleData()
//                    })
                    
                    
                } //: HSTACK
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
            

//            MapMotionData(
//                region: newRegion,
//                lineCoordinates: lineCoordinates
//    //            center: mapCoordinates
//            )
            }
            //HIER
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
}


func clearGeoMoveHere() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
//        clearGreen()
    } catch {
//        clearGreen()
        //        clearCache()
        return
    }
}
