//
//  AD_122_LocationAddress.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 17.11.22.
//

import SwiftUI
import Combine
import CoreLocation
import MapKit

struct AD_122_LocationAddress: View {

    var heightInner = UIScreen.main.bounds.height / 2.1 - (10)

    @StateObject private var mapSearch = MapSearch()

    func reverseGeo(location: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: searchRequest)
        var coordinateK : CLLocationCoordinate2D?
        search.start { (response, error) in
        if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
            coordinateK = coordinate
        }

        if let c = coordinateK {
            let location = CLLocation(latitude: c.latitude, longitude: c.longitude)
//            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "en_US")
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in

            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }

            let reversedGeoLocation = ReversedGeoLocation(with: placemark)

            address = "\(reversedGeoLocation.streetName)"
            addressNumber = "\(reversedGeoLocation.streetNumber)"
            city = "\(reversedGeoLocation.city)"
            state = "\(reversedGeoLocation.state)"
            zip = "\(reversedGeoLocation.zipCode)"
            country = "\(reversedGeoLocation.country)"
            mapSearch.searchTerm = address

                }
            }
        }
    }

    @State private var btnHover = false
    @State private var isBtnActive = false

    @State private var address = ""
    @State private var addressNumber = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zip = ""
    @State private var country = ""
//    @State private var myLat: Double
//    @State private var myLon: Double
    @State private var me: String = ""


    //UserDefaults.standard.set("true", forKey: "editAdressInfo")
    @AppStorage("editAdressInfo") var updateInfo: String?
    
    @State private var isActive = false

    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @AppStorage("placemarkStreet") var OLDstreet = "Avenue Anatole France"
    @AppStorage("placemarkStreetNumber") var OLDstreetNumber = "1234"
    @AppStorage("placemarkPostal") var OLDpostal = "97229"
    @AppStorage("placemarkCity") var OLDcity =  "Taumatawhakatangi­hangakoauauotamatea­turipukakapikimaunga­horonukupokaiwhen­uakitanatahu "
    @AppStorage("placemarkCountry") var OLDcountry = "Unites States of America"

    
    
    
    
    
    
    var body: some View {
//        NavigationView {


        VStack(alignment: .leading){
    
            ZStack(alignment: .top) {
                
                if updateInfo == "false" {
                    Header(title: "Location information")
                    
                }else {
                    HeaderAddress(title: "Location information")
                }

            }


                ZStack(alignment: .top){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()

                    VStack {



                        List {
                            Section {
                                
                                
                                if updateInfo == "false" {
                                    
                                    VStack(alignment: .leading){
                                        Text("Manual Location")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .multilineTextAlignment(.leading)
                                            .padding(.bottom, 10.0)
                                            .frame(width:widthInner, height: 40)
                                            .offset(x: 0, y: 40)
                                        //                    Spacer()
                                        Text("Search your address by street, house no. & city")
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .frame(width:widthInnerText, height: 60)
                                            .offset(x: 20, y: 20)

                                    }
                                    
                                    
                                    
                                    TextField("Address", text: $mapSearch.searchTerm)
                                    
                                    if address != mapSearch.searchTerm {//&& isFocused == false {
                                        ForEach(mapSearch.locationResults, id: \.self) { location in
                                            Button {
                                                
                                                reverseGeo(location: location)
                                                
                                            } label: {
                                                VStack(alignment: .leading) {
                                                    Text(location.title)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                    Text(location.subtitle)
                                                        .font(.system(.caption))
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                }
                                            } // End Label
                                        } // End ForEach
                                    } // End if
                                    TextField("Number", text: $addressNumber)
                                    TextField("City", text: $city)
                                    TextField("State", text: $state)
                                    TextField("Postal Code", text: $zip)
                                    TextField("Country", text: $country)
                                    
                                    @AppStorage("latitudeAdd") var latitude: String = "12345"
                                    @AppStorage("longitudeAdd") var longitude: String = "67890"
                                    
                                    //                                } // End Section
                                    
                                } else {
                                    
                                    
                                    VStack(alignment: .leading){
                                        Text("Manual Location")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .multilineTextAlignment(.leading)
                                            .padding(.bottom, 10.0)
                                            .frame(width:widthInner, height: 40)
                                            .offset(x: 0, y: 40)
                                        //                    Spacer()
                                        Text("Edit your address")
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .frame(width:widthInnerText, height: 60)
                                            .offset(x: 20, y: 20)

                                    }
                                    
                                    
                                    TextField("Address", text:$OLDstreet)
                                    TextField("Number", text: $OLDstreetNumber)
                                    TextField("City", text: $OLDcity)
                                    TextField("State", text: $state)
                                    TextField("Postal Code", text: $OLDpostal)
                                    TextField("Country", text: $OLDcountry)
                                    
                                    
                                    @AppStorage("latitudeAdd") var latitude: String = "12345"
                                    @AppStorage("longitudeAdd") var longitude: String = "67890"
                                    
                                    
                                }
                                
                            }
                            
                            } // End List
                            .listStyle(.plain)
                            .background(Color.Cardi_Text)
                            .frame(width: widthInnerText)
                            .padding(.top, 20)
                            .id(2)
                            
                       

                        Button {
                            
                            
                            if updateInfo == "false" {
                                
                                let streetname = mapSearch.searchTerm
                                let streetnumber = addressNumber
                                let mycity = city
                                let myState = state
                                let myZip = zip
                                let myCountry = country

                                let newstringadress = streetname + "," +  streetnumber + "," + mycity + "," + myState + "," + myZip + "," + myCountry

                                print("STREET: \(newstringadress)")

                                let geocoder = CLGeocoder()
                                geocoder.geocodeAddressString(newstringadress) { placemarks, error in
                                    if let error = error {
                                        alertTitle = "Error"
                                        alertMessage = "Sorry, we couldn't locate the address you provided, and we're unable to determine your geographical location. Please try entering the address again, or use the automated positioning feature in the previous window and manually adjust the location pointer."
//                                        alertMessage = "Geocoding failed: \(error.localizedDescription)"
                                        showAlert = true
                                        return
                                    }
                                    
                                    guard let placemark = placemarks?.first,
                                          let lat = placemark.location?.coordinate.latitude,
                                          let lon = placemark.location?.coordinate.longitude else {
                                        alertTitle = "Error"
                                        alertMessage = "Sorry, we couldn't locate the address you provided, and we're unable to determine your geographical location. Please try entering the address again, or use the automated positioning feature in the previous window and manually adjust the location pointer."
//                                        alertMessage = "No coordinates found."
                                        showAlert = true
                                        return
                                    }
                                    
                                    let myDoubleLat = Double(lat)
                                    let myDoubleLon = Double(lon)
                                    
                                    if myDoubleLat == 0.0 && myDoubleLon == 0.0 {
                                        alertTitle = "Warning"
                                        alertMessage = "Latitude and Longitude are zero."
                                        showAlert = true
                                        return
                                    }
                                        
                                        UserDefaults.standard.set(myDoubleLat, forKey: "latitudeAdd")
                                        UserDefaults.standard.set(myDoubleLon, forKey: "longitudeAdd")
                                        
                                        UserDefaults.standard.set(self.mapSearch.searchTerm, forKey: "placemarkStreet")
                                        UserDefaults.standard.set(self.addressNumber, forKey: "placemarkStreetNumber")
                                        UserDefaults.standard.set(self.city, forKey: "placemarkCity")
                                        UserDefaults.standard.set(self.state, forKey: "placemarkState")
                                        UserDefaults.standard.set(self.zip, forKey: "placemarkPostal")
                                        UserDefaults.standard.set(self.country, forKey: "placemarkCountry")

                                        navigationManager.push(.adlocationmap)
//                                    }
                                }
                                    
                                } else {
                                    

                                    navigationManager.push(.adlocationmap)
                                    UserDefaults.standard.set("false", forKey: "editAdressInfo")
                                    
                                }
                                
                                
//                            }
                        } label: {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.title2)
                                Text("Next")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            UIApplication.shared.endEditing()
                        })
                        .frame(width: widthInnerText, height: 110)


                    } // End Main VStack

                } .offset(x: 15, y: 0)
            // End Var Body

                Spacer()


            }.frame(width:width)
        
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        
        
//        .padding(.bottom, 20)
//        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
} // End Struct


struct AD_122_LocationAddress_Previews: PreviewProvider {
    static var previews: some View {
        AD_122_LocationAddress()
            .previewDevice("iPhone SE (2nd generation)")
//        //            .previewDevice("iPhone 14 Pro")
        AD_122_LocationAddress()
            .previewDevice("iPhone 14 Pro")
    }
}

