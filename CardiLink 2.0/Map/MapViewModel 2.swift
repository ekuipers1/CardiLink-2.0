//
//  MapViewModel.swift
//  UserLocation
//
//  Created by Erik Kuipers on 09.10.21.
//

import MapKit

enum MapDetails {
    
    static let startingLocation = CLLocationCoordinate2D(latitude: 41.3809, longitude: 2.1228)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan )
    
    
    var locationManager: CLLocationManager?
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//    }


    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
//            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("yeah this will not do it")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("yeah this will not do it, parental stuff")
        case .denied:
            print("yeah this will not do it, you denied it, settings to change")
        case .authorizedAlways, .authorizedWhenInUse:
            print("All good")
//            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
