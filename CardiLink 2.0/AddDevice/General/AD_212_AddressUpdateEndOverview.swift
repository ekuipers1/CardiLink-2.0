//
//  AD_212_AddressUpdateEndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 03.08.23.
//

import SwiftUI

struct AD_212_AddressUpdateEndOverview: View {
    
    @AppStorage("placemarkStreet") var street = "Avenue Anatole France"
    @AppStorage("placemarkStreetNumber") var streetNumber = "1234"
    @AppStorage("placemarkPostal") var postal = "97229"
    @AppStorage("placemarkCity") var city =  "Taumatawhakatangi­hangakoauauotamatea­turipukakapikimaunga­horonukupokaiwhen­uakitanatahu "
    @AppStorage("placemarkCountry") var country = "Unites States of America"
    @AppStorage("latitudeAdd") var latitude: String = "12345"
    @AppStorage("longitudeAdd") var longitude: String = "67890"
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Street")
                Text(street)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
                .offset(x: 0, y: 0)
            HStack(){
                VStack(alignment: .leading){
                    
                    Text("House number")
                    Text(streetNumber)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                    
                }.frame(width:200, height: 40, alignment: .leading)
                    .offset(x: 0, y: 0)
                
                VStack(alignment: .leading){
                    Text("Postal Code")
                    
                    Text(postal)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }.frame(width:120, height: 40, alignment: .leading)
                    .offset(x: -25, y: 0)
                
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
                .offset(x: 0, y: 0)
            HStack(){
                VStack(alignment: .leading){
                    Text("City")
                    
                    Text(city)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
                .offset(x: 0, y: 0)
            VStack(alignment: .leading){
                Text("Country")
                
                Text(country)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
                .offset(x: 0, y: 0)
            HStack(){
                VStack(alignment: .leading){
                    Text("latitude")
                    
                    let str2 = String(latitude)
                    Text(str2)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }.frame(width:120, height: 40, alignment: .leading)
                    .offset(x: 0, y: 0)
                Spacer()
                VStack(alignment: .leading){
                    Text("longitude")
                    
                    let str = String(longitude)
                    Text(str)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }.frame(width:120
                        , height: 40, alignment: .leading)
                Spacer()
            }.frame(width:widthInnerText)
                .offset(x: 0, y: 0)
                .padding(.bottom, 20.0)
            HStack(){
                Spacer()
                Button(action: {
                    
                    
                    UserDefaults.standard.set("true", forKey: "editAdressInfo")
                    UserDefaults.standard.set("true", forKey: "ADExisting")
                    
                    if let street = UserDefaults.standard.string(forKey: "placemarkStreet") {
                        UserDefaults.standard.set(street, forKey: "placemarkStreet-Back")
                    }
                    
                    if let number = UserDefaults.standard.string(forKey: "placemarkStreetNumber") {
                        UserDefaults.standard.set(number, forKey: "placemarkStreetNumber-Back")
                    }
                    
                    if let postal = UserDefaults.standard.string(forKey: "placemarkPostal") {
                        UserDefaults.standard.set(postal, forKey: "placemarkPostal-Back")
                    }
                    
                    if let city = UserDefaults.standard.string(forKey: "placemarkCity") {
                        UserDefaults.standard.set(city, forKey: "placemarkCity-Back")
                    }
                    if let country = UserDefaults.standard.string(forKey: "placemarkCountry") {
                        UserDefaults.standard.set(country, forKey: "placemarkCountry-Back")
                    }
                    if let latpos = UserDefaults.standard.string(forKey: "latitudeAdd") {
                        UserDefaults.standard.set(latpos, forKey: "latitudeAdd-Back")
                    }
                    if let lonpos = UserDefaults.standard.string(forKey: "longitudeAdd") {
                        UserDefaults.standard.set(lonpos, forKey: "longitudeAdd-Back")
                    }
                    
                    navigationManager.push(.adlocationaddress)
                    
                }) {
                    HStack {
                        Text("Edit")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }.padding(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(lineWidth: 3.0)
                                .frame(width: widthInnerText * 0.2)
                        )
                        .offset(x: 0, y: 10)
                        .padding(.bottom,20)
                }
                
                Spacer()
                
                Button(action: {
                    
                    UserDefaults.standard.set("true", forKey: "ADExisting")
                    navigationManager.push(.adlocationposition)
                    
                }) {
                    HStack {
                        Text("Update with GPS")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }.padding(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(lineWidth: 3.0)
                                .frame(width: widthInnerText * 0.6)
                        )
                        .offset(x: 0, y: 10)
                        .padding(.bottom,20)
                }
                
                Spacer()
                
            }.frame(width: widthInnerText)
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}

