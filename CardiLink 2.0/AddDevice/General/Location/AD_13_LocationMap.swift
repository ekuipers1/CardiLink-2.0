//
//  AD_13_LocationMap.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI
import MapKit

struct AD_13_LocationMap: View {

//    @State var username: String = ""
//    @State var comments: String = ""
    
    @State private var modelText: String = ""
//    @Environment(\.presentationMode) private var presentationMode
    
//    var height = UIScreen.main.bounds.height / 1.5
//    var width = UIScreen.main.bounds.width - (10 + 10)
//    var widthInner = UIScreen.main.bounds.width - (10 + 40)
//    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 00.100, longitude: 00.100),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    @AppStorage("MYPIN") var deviceSerialID: String?
    @AppStorage("latitudeAdd") var latitudeAdd: String?
    @AppStorage("longitudeAdd") var longitudeAdd: String?
    
    @State var EditingInformation = UserDefaults.standard.bool(forKey: "ADExisting")
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var disabled = true
    
    
    @State var title = ""
    @State var number = ""
    @State var subtitle = ""
    @State var myState = ""
    @State var myZip = ""
    @State var myCountry = ""
    
   @State private var showingModal = false

    var body: some View {
//        NavigationView {

        VStack(alignment: .leading){
           
            ZStack(alignment: .top) {
                Header(title: "Location Information")

            }
                
                ZStack(alignment: .top){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    
                    
                    ScrollView{
                        VStack(){
                            
                            
                            
                            Text("AED GPS coordinates")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .frame(width:widthInnerText, height: 10)
                                .padding(.vertical, 10.0)
                            
                            
                            Spacer()

                            ZStack(alignment: .bottom){
                                
                                MapViewMovePointer(title: self.$title, number: self.$number, subtitle: self.$subtitle, myState: self.$myState, myZip: self.$myZip, myCountry: self.$myCountry)
                                //.edgesIgnoringSafeArea(.all)
                                    .frame(width: widthInnerText, height: height - 100)
                                    .cornerRadius(25)
                                
                                if self.title != "" {
                                    
                                    HStack(spacing: 12){
                                        Image(systemName: "info.circle.fill").font(.largeTitle).foregroundColor(.orange)
                                        
                                        VStack(alignment: .leading, spacing: 15) {
                                            
                                            Text(self.title).font(.body).foregroundColor(.black)
                                            Text(self.number).font(.body).foregroundColor(.black)
                                            
                                            HStack(){
                                                
                                                Text(self.subtitle).font(.caption).foregroundColor(.gray)
                                                Text(self.myState).font(.caption).foregroundColor(.gray)
                                            }
                                            HStack(){
                                                Text(self.myZip).font(.caption).foregroundColor(.gray)
                                                Text(self.myCountry).font(.caption).foregroundColor(.gray)
                                                
                                            }
                                        }
                                        
                                    }.padding()
                                        .background(Color.Cardi_Text)
                                        .cornerRadius(15)
//                                        .offset(x:0, y:-15)
                                    
                                }
                            }.padding(.vertical, 20.0)

                            Spacer()
                            
                            HStack(){
                                Button(action: {
                                    
//                                    ADExisting
                                    if EditingInformation == true {
                                        
                                        print("Floating Button Click")
                                        navigationManager.push(.adendoverview)
                                        UserDefaults.standard.set("false", forKey: "editAdressInfo")
                                        
                                    }else {
                                        
                                        navigationManager.push(.adlocationadditional)
                                        
                                    }
                                    
                                    
                                }) {
                                    HStack {
                                        Text("Looks good")
                                            .fontWeight(.semibold)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(20)
                                    .padding([.leading, .bottom, .top], 20)
                                }
                                .simultaneousGesture(TapGesture().onEnded {

                                })

                                
                                Button(action: {
                                    
                                    print("Edit tapped!")
                                    showingModal = true
                                }){

                                    HStack {

                                        Text("Change?")
                                            .fontWeight(.semibold)
                                            .font(.headline)
                                    }
                                    
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(20)
                                    .padding([.top, .bottom, .trailing], 20)
                                    //                    .id(1)
                                }
                            }

                    .frame(width:widthInner, height: 120)

                        }

                    
                    }.padding(.top, 30.0) .frame(width: widthInner)
                    
                    if $showingModal.wrappedValue {
                        ZStack {
                        VStack(spacing: 20) {
                            Text("New GPS coordinates")
                            .bold().padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.colorCardiGray)
                            .foregroundColor(Color.white)
                            
                            Text("Hold the marker at the bottom and move it for new GPS coordinates.")
                                .frame(width: 290, height: 100)
                                .foregroundColor(Color.black)
                            Spacer()
                            Button(action: {
                                self.showingModal = false
                                }){
                                Text("Close")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(20)
                                        .padding([.leading, .trailing], 20)
                                        
                                }
                            Spacer()
//                                .padding(.bottom, 20.0)
                            
                        }
                        .frame(width: 300, height: 300)
                        .background(Color.white)
                        .cornerRadius(20).shadow(radius: 20)
                            
                        
                        }
                        .padding(.top, 180.0)
                        
                    }
                    

                }.offset(x: 15, y: 0)

            }.frame(width:width)

            .navigationBarHidden(true)
    }
}

struct AD_13_LocationMap_Previews: PreviewProvider {
    static var previews: some View {        
        AD_13_LocationMap()
            .previewDevice("iPhone SE (2nd generation)")
//        //            .previewDevice("iPhone 14 Pro")
        AD_13_LocationMap()
            .previewDevice("iPhone 14 Pro")
//            .previewDevice("iPhone SE (2nd generation) (16.0)")
    }
}



struct MapViewMovePointer : UIViewRepresentable {
    
    
    func makeCoordinator() -> MapViewMovePointer.Coordinator {
        return MapViewMovePointer.Coordinator(parent1: self)
    }

    @Binding var title : String
    @Binding var number : String
    @Binding var subtitle : String
    @Binding var myState : String
    @Binding var myZip : String
    @Binding var myCountry : String
    
    @AppStorage("latitudeAdd") var latitudeAdd: String?
    @AppStorage("longitudeAdd") var longitudeAdd: String?
    
    func makeUIView(context: UIViewRepresentableContext<MapViewMovePointer>) -> MKMapView {
        
        
    let myDoubleLat = Double(latitudeAdd ?? "00.100")
    let myDoubleLon = Double(longitudeAdd ?? "00.100")
        

//    let _ = print(myDoubleLon as Any)
        
        
        
        let map = MKMapView()
        let coordinate = CLLocationCoordinate2D(latitude: myDoubleLat!, longitude: myDoubleLon!)
        map.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotation = MKPointAnnotation ()
        annotation.coordinate = coordinate
        map.delegate = context.coordinator
        
        map.addAnnotation(annotation)
        
        let _ = print("DEFILAT1NEW", myDoubleLat as Any)
        let _ = print("DEFILON1NEW", myDoubleLon as Any)
        
        
        return map
        
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewMovePointer>) {
        
    }
    
    class Coordinator :  NSObject, MKMapViewDelegate {
        
        var parent : MapViewMovePointer
        init(parent1 : MapViewMovePointer) {
            parent = parent1
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let pin = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin.isDraggable = true
            pin.tintColor = .orange
//            pin.pinTintColor = .orange
//            pin.animatesDrop = true
            pin.animatesWhenAdded = true
            
            return pin
                
        }
        /Users/darthvader/1.3.6 GM/CardiLink 2.0/Map2.0/MapviewMoveUI.swift:                    annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)) {
                (places, err) in

                if err != nil {
                    
                    print((err?.localizedDescription)!)
                    return
                }
         

                self.parent.title = (places?.first?.thoroughfare ?? "No additional information")
                
                self.parent.number = (places?.first?.subThoroughfare ?? "")
                
                self.parent.subtitle = (places?.first?.locality ?? "No additional information")
                self.parent.myState = (places?.first?.administrativeArea ?? "")
                self.parent.myZip = (places?.first?.postalCode ?? "")
//                self.parent.myCountry = (places?.first?.country ?? "")
                
                
                if let countryCode = places?.first?.isoCountryCode {
                    let englishLocale = NSLocale(localeIdentifier: "en_US")
                    self.parent.myCountry = englishLocale.displayName(forKey: .countryCode, value: countryCode) ?? ""
                } else {
                    self.parent.myCountry = ""
                }

                
                UserDefaults.standard.set(self.parent.myCountry, forKey: "placemarkCountry")

                UserDefaults.standard.set(self.parent.title, forKey: "placemarkStreet")
                
                UserDefaults.standard.set(self.parent.number, forKey: "placemarkStreetNumber")
                
                
                UserDefaults.standard.set(self.parent.subtitle, forKey: "placemarkCity")
                UserDefaults.standard.set(self.parent.myState, forKey: "placemarkState")
                UserDefaults.standard.set(self.parent.myZip, forKey: "placemarkPostal")
//                UserDefaults.standard.set(self.parent.myCountry, forKey: "placemarkCountry")
                UserDefaults.standard.set(view.annotation?.coordinate.latitude, forKey: "latitudeAdd")
                UserDefaults.standard.set(view.annotation?.coordinate.longitude, forKey: "longitudeAdd")
                
                let _ = print("LAT", view.annotation?.coordinate.latitude as Any)
                let _ = print("LON", view.annotation?.coordinate.longitude as Any)

            }

        }
    }
}
