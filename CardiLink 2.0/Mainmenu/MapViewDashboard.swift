//
//  MapViewDashboard.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.09.23.
//

import SwiftUI
import MapKit
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

struct MapViewDashboard: View {
    
    @State private var defibrillators: [DefibrillatorMap] = []
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) var presentationMode
    @State private var showDetails = false
    @State private var selectedMapType: String = "Standard"
    @State private var isLoading: Bool = false
    
    var frameHeight: CGFloat {
        let modelName = UIDevice.modelName
        if modelName == "iPhone8,4" {
            return height35rd
        } else {
            return height3rd
        }
    }
    
    var body: some View {
        ZStack {
            MapViewGPS(defibrillators: $defibrillators, mapType: $mapType, showDetails: $showDetails)
                .edgesIgnoringSafeArea(.all)
                .sheet(isPresented: $showDetails) {
                    AED_Overview()
                        .onAppear(perform: LoadMyData)
                }
            VStack {
                HStack {
                    Spacer()
                    Button(action:{
                        navigationManager.navigateTo(.maps2)
                    }) {
                        Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }.offset(x: 0, y: 15)
            if isLoading {
                VStack {
                    ProgressView()
                        .foregroundColor(.Cardi_Text_Inf)
                    Text("Loading...")
                        .foregroundColor(.Cardi_Text_Inf)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 8)
                }
                .frame(width: widthInner, height: frameHeight)
                .glassMorphedNoCorners()
            }
        }
        .onAppear(perform: loadData)
        .frame(width: widthInner, height: frameHeight)
        .navigationBarHidden(true)
    }
    
    func mapButton(title: String, mapType: MKMapType) -> some View {
        Button(title) {
            self.mapType = mapType
            self.selectedMapType = title
        }
        .foregroundColor(selectedMapType == title ? .white : .black)
        .fontWeight(selectedMapType == title ? .bold : .regular)
        .padding()
        .background(selectedMapType == title ? Color.colorCardiOrange.opacity(0.8) : Color.gray.opacity(0.8))
        .cornerRadius(15)
        .padding(.vertical)
    }
    
    func loadData() {
        self.isLoading = true
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let myDefibrillators = "defibrillators?GpsIsAvailable=True&PageSize=2500"
        let url_defi = myURL! + myDefibrillators
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseDecodable(of: DefibrillatorResponse.self) { response in
            self.isLoading = false
            switch response.result {
            case .success(let defibrillatorResponse):
                self.defibrillators = defibrillatorResponse.data
            case .failure(let error):
                self.isLoading = false
            }
        }
    }
}

