//
//  AD_212_AddressAdditionalUpdateEndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.08.23.
//

import SwiftUI

struct AD_212_AddressAdditionalUpdateEndOverview: View {
    
    @AppStorage("floorLevel") var floorLevel = "612"
    @State var aedOutsideBuilding = UserDefaults.standard.bool(forKey: "AEDOutsideBuilding")
    @State var aedIsInsideCabinet = UserDefaults.standard.bool(forKey: "AEDIsInsideCabinet")
    @State var aedisYesPinSelected = UserDefaults.standard.bool(forKey: "AEDisYesPinSelected")
    @State var aedPin = UserDefaults.standard.string(forKey: "AEDcabinetPin")
    @AppStorage("comments") var comments = "We don’t serve their kind here! What? Your droids. They’ll have to wait outside. We don’t want them here. Listen, why don’t you wait out by the speeder. We don’t want any trouble. I heartily agree with you sir."
    
    @State var isOKforShare = UserDefaults.standard.bool(forKey: "isOKforShare")
    @State var aedisPubAvailable = UserDefaults.standard.bool(forKey: "aedisPubAvailable")
    
    @State private var showTextField = false
    @State private var cabinetPin = ""
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text("Floor")
                    .truncationMode(.tail)
                Text(floorLevel)
                    .font(.headline)
                    .foregroundColor(Color.Cardi_Text_Inf)
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
                .offset(x: 0, y: 0)
            
            VStack(alignment: .leading){
                Text("Comments")
                    .offset(x: 0, y: 0)
                VStack(alignment: .leading){
                    Text(comments)
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(width:widthInnerText)
                    .offset(x: 0, y: 0)
                
            }
            
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
                
            }.frame(width:widthInnerText, height: 40)
            
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
            
            HStack(){
                Text("Is the AED public available?")
                Spacer()
                Button(action: {
                    self.aedisPubAvailable.toggle()
                    UserDefaults.standard.set(aedisPubAvailable, forKey: "aedisPubAvailable")
                    
                }) {
                    Image(systemName: aedisPubAvailable ? "checkmark.circle.fill" : "stop.circle.fill")
                        .resizable()
                        .foregroundColor(aedisPubAvailable ? .Calming_Green : .colorCardiRed)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
            }.frame(width:widthInnerText, height: 40, alignment: .leading)
            
            HStack(){
                Text("Allow CardiLink to share the data")
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
            
            if aedIsInsideCabinet {
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
                    .offset(x: 0, y: 0)
            } else if showTextField {
                TextField("Please enter a value", text: .constant(""))
                
            }
            
            if aedisYesPinSelected {
                HStack {
                    TextField(aedPin ?? "0000", text: $cabinetPin)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                        .background(Color.Cardi_Text)
                        .cornerRadius(8)
                        .border(Color.gray, width: 2)
                }.frame(width:widthInnerText)
            }
            
            HStack(){
                Spacer()
                Button(action: {
                    
                    UserDefaults.standard.set(false, forKey: "loadStoredData")
                    UserDefaults.standard.set(true, forKey: "EditingInformation")
                    navigationManager.push(.adlocationadditional)
                    UserDefaults.standard.set("", forKey: "AEDcabinetPin")
                    
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
                        .offset(x: -10, y: 10)
                        .padding(.bottom,20)
                    
                }
            } .frame(width:widthInnerText)

        }.frame(width:width)
            .navigationBarHidden(true)
    }
}



