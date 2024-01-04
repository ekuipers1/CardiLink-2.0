//
//  MapviewMoveUI.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 11.03.22.
//

import SwiftUI
import MapKit

struct MapviewMoveUI: UIViewRepresentable {
    
    @ObservedObject var fetcherForlonlat = GetMovements()
    let location: PlaceDefiMove
    let places: [PlaceDefiMove]
    let mapViewType: MKMapType
    
    let lineCoordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        var mymin0: Int = 0
        let statusNumMinNumber1: Int = 0
        var mylineLocation: [CLLocationCoordinate2D] = []
        let darthvader = fetcherForlonlat.fetchlatlon
        let howmany = darthvader.count
        if howmany == 0 {
        } else {
            let cc = location.coordinate
            let InnerBlockMax = howmany - 1
            for _ in statusNumMinNumber1...InnerBlockMax {
                let lineCord = Array(arrayLiteral: darthvader[mymin0])[0].coordinate
                let destination = CLLocationCoordinate2DMake(lineCord.latitude, lineCord.longitude)
                mylineLocation.append(destination)
                let polyline = MKPolyline(coordinates: mylineLocation, count: mylineLocation.count)
                mapView.showsUserLocation  = true
                mapView.mapType = mapViewType
                mapView.isRotateEnabled = true
                mapView.addAnnotations(places)
                mapView.delegate = context.coordinator
                mapView.addOverlay(polyline)
                mapView.setRegion(MKCoordinateRegion(center: lineCord, latitudinalMeters: 400, longitudinalMeters: 400), animated: true)
                mymin0 += 1
            }
        }
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapViewType
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = UIColor(Color.Cardi_MapBlue)
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            switch annotation {
            case let R2D2 as PlaceDefiMove:
                
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "aed") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "aed location")
                
                let defaults = UserDefaults.standard
                switch R2D2.status {
                case "MAX":
                    annotationView.markerTintColor = UIColor(Color.colorCardiRed)
                    annotationView.glyphImage = UIImage(systemName: "house.fill")
                case "0":
                    annotationView.markerTintColor = UIColor(Color.Cardi_Gray_Map)
                    annotationView.glyphImage = UIImage(systemName: "figure.walk")
                case "MIN":
                    annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    annotationView.markerTintColor = UIColor(Color.Map_Calming_Green)
                default:
                    annotationView.markerTintColor = UIColor(Color.Cardi_MapBlue)
                    
                }
                
                annotationView.canShowCallout = true
                annotationView.titleVisibility = .visible
                
                let label = UILabel()
                label.textColor = UIColor(Color.Map_Calming_Green)
                label.text = R2D2.eventTime
                annotationView.detailCalloutAccessoryView = label
                return annotationView
            default: return nil
            }
        }
        
        var selectedAnnotation: PlaceDefiMove?
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            self.selectedAnnotation = view.annotation as? PlaceDefiMove
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(selectedAnnotation?.ownerSerial, forKey: "SelectedDefi")
        }
        
        @objc func buttonTapped(sender : UIButton) {
            
            @State  var isShowingSheet = true
        }
        func didDismiss() {
            
        }
    }
    
}

