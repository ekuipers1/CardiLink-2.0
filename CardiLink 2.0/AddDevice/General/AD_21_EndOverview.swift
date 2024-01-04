//
//  AD_21_EndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.03.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AD_21_EndOverview: View {
    
    @State private var disabled = true
    
    @AppStorage("ADSerialNumber") var ADSerialNumber = ""
    @AppStorage("placemarkStreet") var street = ""
    @AppStorage("placemarkStreetNumber") var streetNumber = ""
    @AppStorage("floorLevel") var floorLevel = ""
    @AppStorage("placemarkPostal") var postal = ""
    @AppStorage("placemarkCity") var city = ""
    @AppStorage("placemarkCountry") var country = ""
    @AppStorage("comments") var comments = ""
    @AppStorage("latitudeAdd") var latitude: String?
    @AppStorage("longitudeAdd") var longitude: String?
    
    @State var aedOutsideBuilding = UserDefaults.standard.bool(forKey: "AEDOutsideBuilding")
    @State var aedIsInsideCabinet = UserDefaults.standard.bool(forKey: "AEDIsInsideCabinet")
    @State var aedisYesPinSelected = UserDefaults.standard.bool(forKey: "AEDisYesPinSelected")
    @State var aedPin = UserDefaults.standard.string(forKey: "AEDcabinetPin")
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    
    @State private var showTextField = false
    @State private var cabinetPin = ""
    
    @State var isOKforShare = UserDefaults.standard.bool(forKey: "isOKforShare")
    @State var isAvailable = UserDefaults.standard.bool(forKey: "aedisPubAvailable")
    
    var body: some View {
        
        let LatInt = Double(latitude ?? "33.814971")
        let LonInt = Double(longitude ?? "-117.921279")
        
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
                                    .offset(x: 15, y: 0)
                                Text(ADSerialNumber)
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .frame(width:widthInnerText, height: 20)
                                    .offset(x: 15, y: 0)
                                Text("Address Information")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 10.0)
                                    .frame(width:widthInner, height: 40)
                                    .offset(x: 0, y: 0)
                                
                                VStack(alignment: .leading){
                                    Text("Street")
                                    
                                    Text(street)
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                                    .offset(x: 15, y: 0)
                                
                                HStack(){
                                    VStack(alignment: .leading){
                                        
                                        Text("House number")
                                        Text(streetNumber)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                        
                                    }.frame(width:200, height: 40, alignment: .leading)
                                        .offset(x: 15, y: 0)
                                    
                                    VStack(alignment: .leading){
                                        Text("Postal Code")
                                        
                                        Text(postal)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }.frame(width:120, height: 40, alignment: .leading)
                                        .offset(x: 15, y: 0)
                                    
                                }
                                HStack(){
                                    VStack(alignment: .leading){
                                        Text("City")
                                        
                                        Text(city)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }.frame(width:200, height: 40, alignment: .leading)
                                        .offset(x: 15, y: 0)
                                    
                                    VStack(alignment: .leading){
                                        Text("Floor")
                                            .truncationMode(.tail)
                                        Text(floorLevel)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }.frame(width:120, height: 40, alignment: .leading)
                                        .offset(x: 15, y: 0)
                                }
                                VStack(alignment: .leading){
                                    Text("Country")
                                    
                                    Text(country)
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                                    .offset(x: 15, y: 0)
                                
                                VStack(alignment: .leading){
                                    Text("Directions")
                                        .offset(x: 15, y: 0)
                                    VStack(alignment: .leading){
                                        Text(comments)
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }.frame(width:widthInnerText)
                                        .offset(x: 15, y: 0)
                                    
                                }
                            }
                            Spacer()
                            HStack(){
                                
                                VStack(alignment: .leading){
                                    Text("latitude")
                                    let str2 = String(latitude ?? "0.0")
                                    Text(str2)
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }.frame(width:120, height: 40, alignment: .leading)
                                    .offset(x: 15, y: 0)
                                Spacer()
                                VStack(alignment: .leading){
                                    Text("longitude")
                                    let str = String(longitude ?? "0.0")
                                    Text(str)
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }.frame(width:120
                                        , height: 40, alignment: .leading)
                                Spacer()
                            }
                            .padding(.vertical)
                            VStack(alignment: .trailing){
                                HStack(){
                                    Text("My AED is outside the building")
                                    Spacer()
                                    Button(action: {
                                        self.aedOutsideBuilding.toggle()
                                        UserDefaults.standard.set(aedOutsideBuilding, forKey: "AEDOutsideBuilding")
                                        
                                    }) {
                                        Image(systemName: aedOutsideBuilding ? "checkmark.circle.fill" : "stop.circle.fill")
                                            .resizable()
                                            .foregroundColor(aedOutsideBuilding ? .Calming_Green : .colorCardiRed)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                            }
                            .padding(.top, 10.0)
                            .offset(x: -5, y: 0)
                            VStack(alignment: .trailing){
                                HStack(){
                                    Text("My AED is inside a cabinet")
                                    Spacer()
                                    Button(action: {
                                        self.aedIsInsideCabinet.toggle()
                                        UserDefaults.standard.set(aedIsInsideCabinet, forKey: "AEDIsInsideCabinet")
                                        
                                    }) {
                                        Image(systemName: aedIsInsideCabinet ? "checkmark.circle.fill" : "stop.circle.fill")
                                            .resizable()
                                            .foregroundColor(aedIsInsideCabinet ? .Calming_Green : .colorCardiRed)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }

                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                            }
                            .offset(x: -5, y: 0)
                            if aedIsInsideCabinet {
                                VStack(alignment: .trailing){
                                    HStack(){
                                        Text("Cabinet needs PIN to open?")
                                        Spacer()
                                        Button(action: {
                                            self.aedisYesPinSelected.toggle()
                                            UserDefaults.standard.set(aedisYesPinSelected, forKey: "AEDisYesPinSelected")
                                            
                                        }) {
                                            Image(systemName: aedisYesPinSelected ? "checkmark.circle.fill" : "stop.circle.fill")
                                                .resizable()
                                                .foregroundColor(aedisYesPinSelected ? .Calming_Green : .colorCardiRed)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                        }
                                    }.frame(width:widthInnerText - 5 , height: 60, alignment: .leading)
                                }
                                .offset(x: -5, y: 0)
                            } else if showTextField {
                                TextField("Please enter a value", text: .constant(""))
                            }
                            if aedisYesPinSelected {
                                VStack(alignment: .trailing){
                                    HStack {
                                        
                                        TextField(aedPin ?? "0000", text: $cabinetPin)
                                            .padding()
                                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                                            .background(Color.Cardi_Text)
                                            .cornerRadius(8)
                                            .border(Color.gray, width: 2)
                                    }.frame(width:widthInnerText)
                                }
                                .frame(width:widthInnerText)
                            }
                            VStack(alignment: .trailing){
                                HStack(){
                                    Text("Is the AED publicly available?")
                                    Spacer()
                                    Button(action: {
                                        self.isAvailable.toggle()
                                        UserDefaults.standard.set(isAvailable, forKey: "aedisPubAvailable")
                                        
                                    }) {
                                        Image(systemName: isAvailable ? "checkmark.circle.fill" : "stop.circle.fill")
                                            .resizable()
                                            .foregroundColor(isAvailable ? .Calming_Green : .colorCardiRed)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                    
                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                            }
                            .offset(x: -5, y: 0)
                            VStack(alignment: .trailing){
                                HStack(){
                                    Text("Publicize AED information?")
                                    Spacer()
                                    Button(action: {
                                        self.isOKforShare.toggle()
                                        UserDefaults.standard.set(isOKforShare, forKey: "isOKforShare")
                                        
                                    }) {
                                        Image(systemName: isOKforShare ? "checkmark.circle.fill" : "stop.circle.fill")
                                            .resizable()
                                            .foregroundColor(isOKforShare ? .Calming_Green : .colorCardiRed)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                }.frame(width:widthInnerText, height: 40, alignment: .leading)
                            }
                            .offset(x: -5, y: 0)
                        }
                        .padding(.bottom, 20.0)
                    }.padding(.top, 30.0) .frame(width: widthInner, height: height )
                    Spacer()
                    Button(action: {
                        ADIspublicAvailable()
                        ADCabinetPinNumber()
                        ADCabinetWithPin()
                        ADInsideCabinet()
                        ADOutsideBuilding()
                        ADIOkforShare()
                        
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
                        HStack {
                            Text("Activate AED")
                                .fontWeight(.semibold)
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    })
                    .frame(width:widthInnerText)
                    .offset(x: 0, y: 0)
                    .padding(.bottom,20)
                }
            }.offset(x: 25, y: 0)
        }
        .onAppear {
            self.isOKforShare = UserDefaults.standard.bool(forKey: "isOKforShare")
            self.isAvailable = UserDefaults.standard.bool(forKey: "aedisPubAvailable")
            self.aedOutsideBuilding = UserDefaults.standard.bool(forKey: "AEDOutsideBuilding")
            self.aedIsInsideCabinet = UserDefaults.standard.bool(forKey: "AEDIsInsideCabinet")
            self.aedisYesPinSelected = UserDefaults.standard.bool(forKey: "AEDisYesPinSelected")
            self.aedPin = UserDefaults.standard.string(forKey: "AEDcabinetPin")
            
        }
    }
}


