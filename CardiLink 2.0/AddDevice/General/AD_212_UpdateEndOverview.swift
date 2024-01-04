//
//  AD_212_UpdateEndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.08.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AD_212_UpdateEndOverview: View {
    
    @AppStorage("ADSerialNumber") var ADSerialNumber = "123456789"
    @AppStorage("placemarkStreet") var street = "Avenue Anatole France"
    @AppStorage("placemarkStreetNumber") var streetNumber = "1234"
    @AppStorage("floorLevel") var floorLevel = "612"
    @AppStorage("placemarkPostal") var postal = "97229"
    @AppStorage("placemarkCity") var city =  "Taumatawhakatangi­hangakoauauotamatea­turipukakapikimaunga­horonukupokaiwhen­uakitanatahu "
    @AppStorage("placemarkCountry") var country = "Unites States of America"
    @AppStorage("comments") var comments = "We don’t serve their kind here! What? Your droids. They’ll have to wait outside. We don’t want them here. Listen, why don’t you wait out by the speeder. We don’t want any trouble. I heartily agree with you sir."
    @AppStorage("latitudeAdd") var latitude: String?
    @AppStorage("longitudeAdd") var longitude: String?
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var showAddress = false
    @State private var showAddressAdditional = false
    @State private var showAvailability = false
    @State private var showImages = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                HeaderAlert(title: "AED Activation".localized)
                
            }
            
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(){
                    
                    VStack(){
                        Text("Summary")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInner, height: 20)
                            .offset(x: 0, y: 40)
                    }.padding(.bottom, 10.0)
                    
                    ScrollView{
                        
                        VStack(){
                            
                            VStack(alignment: .leading){
                                Text("Please activate the AED!")
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width:widthInnerText, height: 20)
                                    .offset(x: 0, y: 0)
                                Text(ADSerialNumber)
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width:widthInnerText, height: 20)
                                    .offset(x: 0, y: 0)
                            }.padding(.bottom, 15.0)
                            
                            
                            VStack(){
                                
                                AddressInformationSection(showAddress: $showAddress)
                                AdditionalAddressInformation(showAddressAdditional: $showAddressAdditional)
                                
                                HStack{
                                    Text("Opening hours")
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 10.0)
                                        .offset(x: 0, y: 0)
                                    
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            self.showAvailability.toggle()
                                        }
                                    }) {
                                        Image(systemName: self.showAvailability ? "chevron.up" : "chevron.down")
                                            .font(.headline)
                                            .frame(width: 15, height: 15)
                                            .padding()
                                    }
                                    
                                }.frame(width: widthInnerText, height: 20)
                                RoundedRectangle(cornerRadius: 1, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .frame(width: widthInnerText, height: 4)
                                    .offset(x: 0, y: -0)
                                    .padding(.bottom, 20.0)
                                
                                if showAvailability {
                                    AD_212_AvaillabilityEndOverview()
                                    
                                }
                                
                                HStack{
                                    Text("Photograph(s)")
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 10.0)
                                        .offset(x: 0, y: 0)
                                    
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            self.showImages.toggle()
                                        }
                                    }) {
                                        Image(systemName: self.showImages ? "chevron.up" : "chevron.down")
                                            .font(.headline)
                                            .frame(width: 15, height: 15)
                                            .padding()
                                    }
                                    
                                }.frame(width: widthInnerText, height: 20)
                                RoundedRectangle(cornerRadius: 1, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .frame(width: widthInnerText, height: 4)
                                    .offset(x: 0, y: -0)
                                    .padding(.bottom, 20.0)
                                
                                if showImages {
                                    AD_212_ImagesUpdateEndOverview()
                                    
                                }
                                
                            }
                            
                        }
                        
                    }.padding(.top, 30.0) .frame(width: widthInner, height: height )
                    
                    Spacer()
                    
                    Button(action: {
                        ADIspublicAvailable()
                        ADCabinetPinNumber()
                        ADCabinetWithPin()
                        ADInsideCabinet()
                        ADOutsideBuilding()
                        ADIOkforShare()
                        ADAvailable247()
                        
                        let defaults = UserDefaults.standard
                        
                        let parameters: [String: Any] = [
                            "address": [
                                "street": street,
                                "houseNumber": streetNumber,
                                "floorLevel": floorLevel,
                                "postalCode": postal,
                                "postalCodeSub": "",
                                "city": city,
                                "country": country,
                                "timezone": "CET",
                                "comment": comments
                            ],
                            "geoCoordinate": [
                                "Latitude":latitude!,
                                "Longitude":longitude!
                            ],
                            "geoFence": NSNull()
                            
                        ]
                        
                        let myURL = defaults.string(forKey: "myPortal")
                        let AuthKey = defaults.string(forKey: "DATASTRING")
                        let authKey = AuthKey!
                        let defibrillatorsAddress = "defibrillatoraddress/"
                        let adDdefibrillatorId = defaults.string(forKey: "ADdefibrillatorId")
                        let url_defi = myURL! + defibrillatorsAddress + (adDdefibrillatorId ?? "0000000000")
                        UserDefaults.standard.set("false", forKey: "ADExisting")
                        AF.request(url_defi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [
                            "authkey" : authKey,
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "Connection" : "keep-alive"
                        ])
                        .responseJSON { response in
                        }
                        
                        navigationManager.push(.adLocationEnd)
                    }, label: {
                        
                        let defaults = UserDefaults.standard
                        let newOrExisting = defaults.string(forKey: "ADExisting")
                        
                        if newOrExisting == "false" {
                            
                            HStack {
                                Text("Activate AED")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                            
                        }else {
                            
                            HStack {
                                Text("Update AED")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                        }
                        
                    })
                    .frame(width:widthInnerText)
                    .offset(x: 0, y: 0)
                    .padding(.bottom,20)
                    
                }
            }.offset(x: 25, y: 0)
        }.onAppear(){
            
            
        }
    }
}

struct AddressInformationSection: View {
    @Binding var showAddress: Bool
    
    var body: some View {
        HStack{
            Text("Address Information")
                .font(.headline)
                .foregroundColor(Color.Cardi_Text_Inf)
                .multilineTextAlignment(.leading)
                .padding(.top, 10.0)
                .offset(x: 0, y: 0)
            
            Spacer()
            Button(action: {
                withAnimation {
                    self.showAddress.toggle()
                }
            }) {
                Image(systemName: self.showAddress ? "chevron.up" : "chevron.down")
                    .font(.headline)
                    .frame(width: 15, height: 15)
                    .padding()
            }
            
        }.frame(width: widthInnerText, height: 20)
        
        RoundedRectangle(cornerRadius: 1, style: .continuous)
            .fill(Color.Calming_Green)
            .frame(width: widthInnerText, height: 4)
            .offset(x: 0, y: -0)
            .padding(.bottom, 20.0)
        
        if showAddress {
            AD_212_AddressUpdateEndOverview(street: "YourStreet", streetNumber: "YourNumber", postal: "YourPostal", city: "YourCity", country: "YourCountry", latitude: "YourLatitude", longitude: "YourLongitude")
        }
    }
}

struct AdditionalAddressInformation: View {
    
    @Binding var showAddressAdditional: Bool
    
    var body: some View {
        
        HStack{
            Text("Additional Information")
                .font(.headline)
                .foregroundColor(Color.Cardi_Text_Inf)
                .multilineTextAlignment(.leading)
                .padding(.top, 10.0)
                .offset(x: 0, y: 0)
            
            Spacer()
            Button(action: {
                withAnimation {
                    self.showAddressAdditional.toggle()
                }
            }) {
                Image(systemName: self.showAddressAdditional ? "chevron.up" : "chevron.down")
                    .font(.headline)
                    .frame(width: 15, height: 15)
                    .padding()
            }
            
        }.frame(width: widthInnerText, height: 20)
        RoundedRectangle(cornerRadius: 1, style: .continuous)
            .fill(Color.Calming_Green)
            .frame(width: widthInnerText, height: 4)
            .offset(x: 0, y: -0)
            .padding(.bottom, 20.0)
        if showAddressAdditional {
            AD_212_AddressAdditionalUpdateEndOverview(floorLevel: "YourFloorLevel", comments: "YourComments")
            
        }
    }
}
