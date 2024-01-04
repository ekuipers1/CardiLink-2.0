//
//  MapViewGPS.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.05.23.
//

import SwiftUI
import MapKit
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

struct ParentView: View {
    @State private var defibrillators: [DefibrillatorMap] = []
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) var presentationMode
    @State private var showDetails = false
    @State private var selectedMapType: String = "Standard"
    
    @State private var isLoading: Bool = false
    
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
                    
                    Button(action:{
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                ZStack(){
                    HStack {
                        Spacer()
                        mapButton(title: "Standard", mapType: .standard)
                        Spacer()
                        mapButton(title: "Hybrid", mapType: .hybrid)
                        Spacer()
                        mapButton(title: "Satellite", mapType: .satellite)
                        Spacer()
                    }.frame(width: widthInner, height: 40)
                }.frame(width: widthInner, height: 60)
            }
            
            if isLoading {
                VStack {
                    ProgressView()
                        .foregroundColor(.Cardi_Text_Inf)
                    Text("Loading...")
                        .foregroundColor(.Cardi_Text_Inf)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 8)
                }
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.1)
                .glassMorphed()
            }
        }
        .onAppear(perform: loadData)
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
        print("NEXT DATASTRING: ", AuthKey!)
        let authKey = AuthKey!
        let myDefibrillators = "defibrillators?GpsIsAvailable=True&PageSize=2500"
        let url_defi = myURL! + myDefibrillators
        AF.request(url_defi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseJSON { response in
            self.isLoading = false
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let data = json["data"].array else {
                    return
                }
                defibrillators = data.compactMap {
                    DefibrillatorMap(defiId: $0["defiId"].string ?? "",
                                     serial: $0["serial"].string ?? "",
                                     ownerId: $0["ownerId"].string ?? "",
                                     ownerName: $0["ownerName"].string ?? "",
                                     description: $0["description"].string ?? "",
                                     lat: $0["lat"].double ?? 0,
                                     lon: $0["lon"].double ?? 0,
                                     dashboardState: $0["dashboardState"].int ?? 0,
                                     adminStatus: $0["adminStatus"].int ?? 0)
                }
            case .failure(let error):
                print(error)
                self.isLoading = false
            }
        }
    }
}

struct MapViewGPS: UIViewRepresentable {
    @Binding var defibrillators: [DefibrillatorMap]
    @Binding var mapType: MKMapType
    @Binding var showDetails: Bool
    let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = context.coordinator
        mapView.register(DefibrillatorView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                let coordinate = location.coordinate
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 18000, longitudinalMeters: 18000)
                mapView.setRegion(region, animated: true)
            }
        }
        
        mapView.showsUserLocation = true
        mapView.tintColor = .blue
        return mapView
        
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType
        updateAnnotations(from: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.defibrillators.map(DefibrillatorAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapViewGPS
        init(_ control: MapViewGPS) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let cluster = annotation as? MKClusterAnnotation {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: cluster) as? MKMarkerAnnotationView
                view?.markerTintColor = UIColor(Color.colorCardiOrange)
                return view
            } else {
                return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
            }
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let defibrillatorAnnotation = view.annotation as? DefibrillatorAnnotation {
                UserDefaults.standard.set(defibrillatorAnnotation.defibrillator.defiId, forKey: "SelectedDefi")
                control.showDetails = true
                mapView.deselectAnnotation(view.annotation, animated: true)
            }
        }
    }
}

final class DefibrillatorAnnotation: NSObject, MKAnnotation {
    let defibrillator: DefibrillatorMap
    
    var coordinate: CLLocationCoordinate2D {
        defibrillator.coordinate
    }
    
    var title: String? {
        defibrillator.serial
    }
    
    init(defibrillator: DefibrillatorMap) {
        self.defibrillator = defibrillator
        super.init()
    }
}

final class DefibrillatorView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let defibrillatorAnnotation = newValue as? DefibrillatorAnnotation else { return }
            markerTintColor = colorForState(defibrillatorAnnotation.defibrillator.dashboardState)
            glyphImage = UIImage(systemName: "bolt.heart.fill")
            clusteringIdentifier = "defibrillator"
        }
    }
    
    private func colorForState(_ state: Int) -> UIColor {
        switch state {
        case 0:
            return UIColor(Color.Map_Calming_Green)
        case 1:
            return UIColor(Color.Cardi_Yellow)
        case 2:
            return UIColor(Color.colorCardiRed)
        case 3:
            return UIColor(Color.Cardi_Yellow)
        case 4:
            return UIColor(Color.colorCardiRed)
        case 5:
            return UIColor(Color.Cardi_Gray_Map)
        default:
            return UIColor(Color.Cardi_MapBlue)
        }
    }
}



