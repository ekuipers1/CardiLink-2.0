//
//  AD_121_LocationPosition.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI

struct AD_121_LocationPosition: View {
    
    @State private var modelText: String = ""
//    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var navigationManager: NavigationManager
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width - (10 + 10)
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    @StateObject var lm = LocationManager()
//    @ObservedObject var lm = LocationManager()

    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }

    var placemarkStreet: String {  return("\(lm.placemark?.thoroughfare ?? "XXX")")}
    var placemarkStreetNumber: String { return("\(lm.placemark?.subThoroughfare ?? "XXX")")}
    var placemarkCity: String {  return("\(lm.placemark?.locality ?? "XXX")")}
    var placemarkState: String {  return("\(lm.placemark?.administrativeArea ?? "XXX")")}
    
    var placemarkPostal: String {  return("\(lm.placemark?.postalCode ?? "XXX")")}
//    var placemarkCountry: String {  return("\(lm.placemark?.country ?? "XXX")")}
    

    
    
    var placemarkCountry: String {
        if let country = lm.placemark?.isoCountryCode {
            let locale = Locale(identifier: "en_US")
            
            if let englishCountry = (locale as NSLocale).displayName(forKey: .countryCode, value: country) {
                UserDefaults.standard.set(englishCountry, forKey: "placemarkCountry")
                
                print("YES", englishCountry)
                return englishCountry
            } else {
                UserDefaults.standard.set(country, forKey: "placemarkCountry")
                print("NO", country)
                return country
            }
        } else {
            UserDefaults.standard.set("XXX", forKey: "placemarkCountry")
            return "XXX"
        }
    }
    

    var body: some View {

        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "Location Information")

            }
            
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()

                VStack(){
                    Text("Automatic location")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .frame(width:widthInnerText, height: 10)
                        .padding(.top, 50.0)
                    //                        Spacer()
                    Text("We have automatically detected the following location.")
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .frame(width:widthInnerText, height: 80)
                    
                    VStack(){
                        HStack(){
                            Text("**\(self.placemarkStreet)**")
                            Text("**\(self.placemarkStreetNumber)**")
                            Spacer()
                        }.frame(width:widthInnerText, height: 10)
                            .offset(x: 10, y:10)
                        
                        HStack(){
                            Text("**\(self.placemarkCity)**")
                            Text("**\(self.placemarkState)**")
                            Spacer()
                        }.frame(width:widthInnerText, height: 10)
                            .offset(x: 10, y:10)
                        HStack(){
                            Text("**\(self.placemarkPostal)**")
                            Text("**\(self.placemarkCountry)**")
                            Spacer()
                        }.frame(width:widthInnerText, height: 10)
                            .offset(x: 10, y:10)
                        HStack(){
                            Text("Latitude:")
                            Spacer()
                            Text("**\(self.latitude)**")
                                .padding(.trailing, 10.0)
                        }.frame(width:widthInnerText, height: 20)
                            .offset(x: 10, y:20)
                        HStack(){
                            Text("Longitude:")
                            Spacer()
                            Text("**\(self.longitude)**")
                                .padding(.trailing, 10.0)
                        }.frame(width:widthInnerText, height: 10)
                            .offset(x: 10, y:20)
                    } .frame(width:widthInnerText, height: 90)
                    Spacer()
                   
                    HStack(){
                        
                        Text("Is the location correct?")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInnerText, height: 60)
                            .offset(x: 0, y: 0)
        
                    }.padding(.top, 40.0)
                    
                    Spacer()
                    
                    HStack(){
                        Button(action: {
                            navigationManager.push(.adlocationmap)
//                            navigationManager.currentView = .adlocationmap
                        }, label: {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
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
                            .padding(.bottom, 10)
                        })
                        .environmentObject(navigationManager)

                        .simultaneousGesture(TapGesture().onEnded{

                            var placemarkCountry: String {
                                if let country = lm.placemark?.country {
                                    let locale = Locale(identifier: "en_US")
                                    
                                    if let englishCountry = (locale as NSLocale).displayName(forKey: .countryCode, value: country) {
                                        UserDefaults.standard.set(englishCountry, forKey: "placemarkCountry")
                                        
                                        print("YES", englishCountry)
                                        return englishCountry
                                    } else {
                                        UserDefaults.standard.set(country, forKey: "placemarkCountry")
                                        print("NO", country)
                                        return country
                                    }
                                } else {
                                    UserDefaults.standard.set("XXX", forKey: "placemarkCountry")
                                    return "XXX"
                                }
                            }
                            
                            
                            UserDefaults.standard.set(self.placemarkStreet, forKey: "placemarkStreet")
                            UserDefaults.standard.set(self.placemarkStreetNumber, forKey: "placemarkStreetNumber")
                            UserDefaults.standard.set(self.placemarkCity, forKey: "placemarkCity")
                            UserDefaults.standard.set(self.placemarkState, forKey: "placemarkState")
                            UserDefaults.standard.set(self.placemarkPostal, forKey: "placemarkPostal")

                            UserDefaults.standard.set(self.latitude, forKey: "latitudeAdd")
                            UserDefaults.standard.set(self.longitude, forKey: "longitudeAdd")
                            
                            
                        })

                        Spacer()
                        Button(action: {
                            navigationManager.push(.adlocationaddress)
//                            navigationManager.currentView = .adlocationaddress
                        }, label: {
                            HStack {
                                Image(systemName: "hand.thumbsdown")
                                    .font(.title2)
                                Text("No")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                        })
                        .environmentObject(navigationManager)

                        .simultaneousGesture(TapGesture().onEnded{

                            UserDefaults.standard.set(self.placemarkStreet, forKey: "placemarkStreet")
                            UserDefaults.standard.set(self.placemarkStreetNumber, forKey: "placemarkStreetNumber")
                            UserDefaults.standard.set(self.placemarkCity, forKey: "placemarkCity")
                            UserDefaults.standard.set(self.placemarkState, forKey: "placemarkState")
                            UserDefaults.standard.set(self.placemarkPostal, forKey: "placemarkPostal")
                            UserDefaults.standard.set(self.latitude, forKey: "latitudeAdd")
                            UserDefaults.standard.set(self.longitude, forKey: "longitudeAdd")
                            
                            
                        })
                    }
                    .frame(width:widthInnerText, height: 10)
                    .offset(x: 0, y: -40)

                }
                Spacer()

            }.offset(x: 25, y: 0)

            
        }
        .onAppear {
            lm.checkLocationAuthorization()
                   }
                   .alert(isPresented: $lm.showAlert) {
                       Alert(
                           title: Text("Location Access Denied"),
                           message: Text("To use this feature, we need access to your location. Please change your settings."),
                           dismissButton: Alert.Button.default(Text("Go to Settings"), action: {
                               if let url = URL(string: UIApplication.openSettingsURLString) {
                                   UIApplication.shared.open(url)
                               }
                           })
                       )
                   }

            .navigationBarHidden(true)
            .padding(.bottom, 20)
    }
}

struct AD_121_LocationPosition_Previews: PreviewProvider {
    static var previews: some View {
        AD_121_LocationPosition()
            .previewDevice("iPhone SE (2nd generation)")
//        //            .previewDevice("iPhone 14 Pro")
        AD_121_LocationPosition()
            .previewDevice("iPhone 14 Pro")
    }
}
