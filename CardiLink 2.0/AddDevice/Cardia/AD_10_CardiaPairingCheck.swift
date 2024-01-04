//
//  AD_10_CardiaPairingCheck.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 13.12.22.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct InfoPair: Identifiable {
    let id = UUID()
    let key: String
    let value: String
}

struct AD_10_CardiaPairingCheck: View {
    
    @State var infoPairs: [InfoPair] = []
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("ADSerialNumber") var ADserial: String!
    @AppStorage("ADactivationTime") var ADactivationTime: Int!
    @AppStorage("ADdefibrillatorId") var ADdefibrillatorId: String!
    @AppStorage("ADcommunicatorId") var ADcommunicatorId: String!
    @AppStorage("ADManufacturerValue") var ADManufacturerValue: String!
    @AppStorage("ADManufacturerKey") var ADManufacturerKey: String!
    @AppStorage("ADExisting") var ADExisting: String!
    @State private var isExisting: Bool = false
    @AppStorage("ADModel") var ADModel: String!
    @AppStorage("ADDailySelf") var ADDailySelf: String!
    @AppStorage("ADBattery") var ADBattery: String!
    @AppStorage("ADLastDaily") var ADLastDaily: String!
    @AppStorage("NONIOT") var NonIot: String!
    
    @State private var isLoading = false
    @State private var showNextButton = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(){
                    
                    Text("Overview")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .frame(width:widthInnerText, height: 40)
                        .offset(x: 0, y: 0)
                    
                    
                    List {
                        Section(header: Text("AED:\(ADserial ?? "N/A")") .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.Cardi_Text_Inf))
                        {
                            ForEach(infoPairs) { infoPair in
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(infoPair.key)
                                        Spacer()
                                        Text(infoPair.value)
                                    }
                                }
                            }
                        }
                    }.frame(width:widthInner)
                        .offset(x: 0, y: 0)
                        .scrollContentBackground(.hidden)
                        .listRowInsets(.none)
                        .background(Color.clear)
                    
                    VStack(alignment: .leading){
                        Text(ADcommunicatorId ?? "N/A")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.Cardi_Text_Inf)
                    }
                    .padding(.top, 20.0)
                    .frame(width:widthInnerText, height: 30, alignment: .leading)
                    .offset(x: 15, y: 20)
                    
                    
                }.offset(x: 0, y: 40)
                VStack(){
                    Spacer()
                    Spacer()
                    if showNextButton {
                        if NonIot == "Yes" {
                            if isExisting == false {
                                Button(action: {
                                    navigationManager.push(.adlocationmainscreen)
                                    UserDefaults.standard.set("No", forKey: "NONIOT")
                                    UserDefaults.standard.set("false", forKey: "ADExisting")
                                }) {
                                    HStack {
                                        Text("Next")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                        Image(systemName: "arrowshape.forward.fill")
                                            .font(.title2)
                                    }
                                }
                                .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                            }
                            else {
                                VStack(){
                                    Button(action: {
                                        navigationManager.push(.adendoverview)
                                        UserDefaults.standard.set("No", forKey: "NONIOT")
                                        UserDefaults.standard.set("true", forKey: "ADExisting")
                                        
                                        let currentdefie = defaults.string(forKey: "ADdefibrillatorId")
                                        UserDefaults.standard.set(currentdefie, forKey: "SelectedDefi")
                                        
                                        getAddressInfo()
                                        getOutsideTheBuilding()
                                        getInsideaCabinet()
                                        getNeedsPinToOpen()
                                        getPinToOpen()
                                        getADIspublicAvailable()
                                        getADIOkforShare()
                                        
                                        
                                    }) {
                                        HStack {
                                            Text("Open Overview Page")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                            Image(systemName: "list.clipboard")
                                                .font(.title2)
                                        }
                                    }
                                    .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                                    
                                    Button(action: {
                                        navigationManager.push(.adlocationmainscreen)
                                        UserDefaults.standard.set("No", forKey: "NONIOT")
                                        UserDefaults.standard.set("false", forKey: "ADExisting")
                                    }) {
                                        HStack {
                                            Text("Next")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                            Image(systemName: "arrowshape.forward.fill")
                                                .font(.title2)
                                        }
                                    }
                                    .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                                }
                            }
                        }
                        else {
                            
                            if isExisting == true {
                                VStack(){
                                    Button(action: {
                                        navigationManager.push(.adendoverview)
                                        UserDefaults.standard.set("No", forKey: "NONIOT")
                                        UserDefaults.standard.set("true", forKey: "ADExisting")
                                        
                                        let currentdefie = defaults.string(forKey: "ADdefibrillatorId")
                                        UserDefaults.standard.set(currentdefie, forKey: "SelectedDefi")
                                        
                                        getAddressInfo()
                                        getOutsideTheBuilding()
                                        getInsideaCabinet()
                                        getNeedsPinToOpen()
                                        getPinToOpen()
                                        getADIspublicAvailable()
                                        getADIOkforShare()
                                        
                                    }) {
                                        HStack {
                                            Text("Open Overview Page")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                            Image(systemName: "list.clipboard")
                                                .font(.title2)
                                        }
                                    }
                                    .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                                    
                                    Button(action: {
                                        navigationManager.push(.adcardiapairingredgreen)
                                        UserDefaults.standard.set("No", forKey: "NONIOT")
                                        UserDefaults.standard.set("false", forKey: "ADExisting")
                                    }) {
                                        HStack {
                                            Text("Next")
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                            Image(systemName: "arrowshape.forward.fill")
                                                .font(.title2)
                                        }
                                    }
                                    .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                                }
                                
                            } else {
                                
                                Button(action: {
                                    navigationManager.push(.adcardiapairingredgreen)
                                    UserDefaults.standard.set("false", forKey: "ADExisting")
                                    
                                }) {
                                    HStack {
                                        Text("Next")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                        Image(systemName: "arrowshape.forward.fill")
                                            .font(.title2)
                                    }
                                }
                                .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
                            }
                        }
                    }
                    
                }
                
            }.offset(x: 15, y: 0)
                .padding(.bottom, 10.0)
        }.frame(width:width)
            .navigationBarHidden(true)
            .onAppear {
                isLoading = true
                ADNONIOTActivation()
            }
        
    }
    
    func ADNONIOTActivation(){
        
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myDefibrillators = "activation/"
        let serialnumber = defaults.string(forKey: "ADSerialNumber") ?? "0000000000"
        let url_defi = myURL! + myDefibrillators + serialnumber + "/start?isnoniot=true"
        
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseData {response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                if let errorMessage = json["error"].string, errorMessage == "Activation Failed" {
                    
                    UserDefaults.standard.set("STOP", forKey: "ActivationError")
                    
                } else {
                    
                    let json = JSON(value)
                    fetchData()
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func fetchData() {
        let defaults = UserDefaults.standard
        
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myDefibrillators = "activation/"
        let serialnumber = defaults.string(forKey: "ADSerialNumber") ?? "0000000000"
        let url_defi = myURL! + myDefibrillators + serialnumber + "/info"
        
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]
        )
        
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.isExisting = json["data"]["hasPreviousPropertyData"].boolValue
                UserDefaults.standard.set(json["data"]["defibrillatorId"].string, forKey: "ADdefibrillatorId")
                UserDefaults.standard.set(json["data"]["hasPreviousPropertyData"].string, forKey: "ADExisting")
                let infoPairsArray = json["data"]["infoPairs"].arrayValue
                self.infoPairs = infoPairsArray.map { infoPairJSON in
                    InfoPair(
                        key: infoPairJSON["key"].stringValue,
                        value: infoPairJSON["value"].stringValue
                    )
                }
                
                if let addressModel = json["data"]["address"]["addressModel"].dictionary {
                    UserDefaults.standard.setValue(addressModel["city"]?.string, forKey: "placemarkCity")
                    UserDefaults.standard.setValue(addressModel["comment"]?.string, forKey: "comments")
                    UserDefaults.standard.setValue(addressModel["floorLevel"]?.string, forKey: "floorLevel")
                    UserDefaults.standard.setValue(addressModel["houseNumber"]?.string, forKey: "placemarkStreetNumber")
                    UserDefaults.standard.setValue(addressModel["street"]?.string, forKey: "placemarkStreet")
                    UserDefaults.standard.setValue(addressModel["postalCode"]?.string, forKey: "placemarkPostal")
                    UserDefaults.standard.setValue(addressModel["country"]?.string, forKey: "placemarkCountry")
                }
                
                if let gpsLat = json["data"]["address"]["gpsLat"].double {
                    UserDefaults.standard.set(gpsLat, forKey: "latitudeAdd")
                }
                
                if let gpsLon = json["data"]["address"]["gpsLon"].double {
                    UserDefaults.standard.set(gpsLon, forKey: "longitudeAdd")
                }
                
                UserDefaults.standard.set(false, forKey: "AEDOutsideBuilding")
                UserDefaults.standard.set(false, forKey: "AEDIsInsideCabinet")
                UserDefaults.standard.set(false, forKey: "AEDisYesPinSelected")
                UserDefaults.standard.set(false, forKey: "aedisPubAvailable")
                UserDefaults.standard.set(false, forKey: "isOKforShare")
                
                isLoading = false
                showNextButton = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
}




