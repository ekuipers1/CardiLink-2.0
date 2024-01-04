//
//  LocationManager.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 23.08.21.
//

import Foundation
import CoreLocation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var region = MKCoordinateRegion()
    private let geocoder = CLGeocoder()
    @Published var showAlert = false
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways: break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            DispatchQueue.main.async {
                self.showAlert = true
            }
        @unknown default:
            break
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied:
            DispatchQueue.main.async {
                self.showAlert = true
            }
            return "denied"
        @unknown default: return "unknown"
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        UserDefaults.standard.set(location.coordinate.latitude, forKey: "UserCenterLocationLat")
        UserDefaults.standard.set(location.coordinate.longitude, forKey: "UserCenterLocationLon")
        self.location = location
        self.geocode()
    }
    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location) { (places, error) in
            if let place = places?.first {
                self.placemark = place
            } else {
                self.placemark = nil
            }
            self.locationManager.stopUpdatingLocation()
        }
    }
}
extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}


