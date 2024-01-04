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
    
//    private let fakeRoute = Array([CLLocationCoordinate2D(latitude : 50.17872061411607, longitude : 9.80948129957236),
//    CLLocationCoordinate2D(latitude : 50.19316025906173, longitude : 10.34794495911499),
//    CLLocationCoordinate2D(latitude : 49.70448745399307, longitude : 11.15535612286288),
////                           CLLocationCoordinate2D(latitude : 49.9008414951068, longitude : 9.977232112084637),
////                           CLLocationCoordinate2D(latitude : 49.38690194421451, longitude : 9.568110542293917),
////                           CLLocationCoordinate2D(latitude : 49.85403345629261, longitude : 9.317508680400856),
////                           CLLocationCoordinate2D(latitude : 49.42244632502489, longitude : 11.34444915855314),
////                           CLLocationCoordinate2D(latitude : 49.41110236471164, longitude : 8.80685490903725),
////                           CLLocationCoordinate2D(latitude : 49.59334405034921, longitude : 9.627213660495338),
////                           CLLocationCoordinate2D(latitude : 48.87540669310495, longitude : 10.26237308724307),
////                           CLLocationCoordinate2D(latitude : 48.96643437396614, longitude : 11.47856771010748),
////                           CLLocationCoordinate2D(latitude : 50.07318458176667, longitude : 8.780723039083226),
////                           CLLocationCoordinate2D(latitude : 48.72865344815874, longitude : 9.731738465335923),
////                           CLLocationCoordinate2D(latitude : 50.30856555061521, longitude : 9.54130761400582),
////                           CLLocationCoordinate2D(latitude : 49.23053769441264, longitude : 11.10415165545627),
////                           CLLocationCoordinate2D(latitude : 49.5635992898606, longitude : 9.807717219239859),
////                           CLLocationCoordinate2D(latitude : 49.2024983063571, longitude : 10.20065527468345),
//                           CLLocationCoordinate2D(latitude : 49.15559640869309, longitude : 11.31715056753865)].reversed())
//
//
//    
    
    let location: PlaceDefiMove
    let places: [PlaceDefiMove]
    let mapViewType: MKMapType
    
    let lineCoordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        var mymin0: Int = 0
        let statusNumMinNumber1: Int = 0
        
        var mylineLocation: [CLLocationCoordinate2D] = []
        
        let restaurants = fetcherForlonlat.fetchlatlon
        
        print("restaurants", restaurants)
        print("MOVECOUNT", restaurants.count)
        
        let howmany = restaurants.count
        print("FIRST GROUP COUNT :\(String(describing: howmany))")
        print(howmany as Any)
//       var cc = location.coordinate
        
        if howmany == 0 {
            
            print("NOTHING")
            
        } else {
            
            let cc = location.coordinate
            
            
            print("PRINT:\(cc)")
            
            let InnerBlockMax = howmany - 1
            print("BLOCK MOVE:\(InnerBlockMax)")
            
            for _ in statusNumMinNumber1...InnerBlockMax {
            
                print("Before:\(mymin0)")

//            var mynumber = InnerBlockMax
            
//                print("PRINT2:\(cc)")
                
                
//                let cc = Array(arrayLiteral: restaurants[mymin0])[1].location.coordinate
//                print("PRINT2:\(cc)")
                let lineCord = Array(arrayLiteral: restaurants[mymin0])[0].coordinate
                
//                let aa1 = Array(arrayLiteral: restaurants[mymin0])[0].coordinate.longitude
//                let bb = Array(arrayLiteral: restaurants[2])[0].coordinate

//                let lineCoordinates = [
////                    aa, bb,
////                    lineCoordinates.append(aa)
//                    Array(arrayLiteral: restaurants[mymin0])[0].coordinate,
//                ];

                
//                let destination = CLLocationCoordinate2DMake(aa.latitude, aa.longitude)
                     // This prints each location separately

                
//                if latarray.count == lonarray.count {
//                    for var i = 0; i < latarray.count; i++ {
                        let destination = CLLocationCoordinate2DMake(lineCord.latitude, lineCord.longitude)
                mylineLocation.append(destination)
//                    }
//                }
                
//                print(mylineLocation)
                print("mylineLocation:\(mylineLocation)")
                
  
                print("lineCoordinates:\(lineCoordinates)")
                
                
        for value in Array(arrayLiteral: restaurants.first) {
            print("\(String(describing: value))")
        }

//        restaurants.
         print("OBI-ONE", restaurants.count)

        
//        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        
                let polyline = MKPolyline(coordinates: mylineLocation, count: mylineLocation.count)
        
        
        mapView.showsUserLocation  = true
        //    mapView.setRegion(location.region, animated: false)
        mapView.mapType = mapViewType
        mapView.isRotateEnabled = false
        mapView.addAnnotations(places)
        mapView.delegate = context.coordinator
               
        mapView.addOverlay(polyline)
        mapView.setRegion(MKCoordinateRegion(center: lineCord, latitudinalMeters: 400, longitudinalMeters: 400), animated: true)
                

        let _ = print("POLY", polyline.pointCount)
                
                mymin0 += 1
                print("IN COUNT:\(mymin0)")
            }
        }
        return mapView
    }
//    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapViewType
        
        //      mapView.showsUserLocation = true
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    

    
    
    
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         
            if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            
//                renderer.alpha = 0.5
            renderer.strokeColor = UIColor(Color.Cardi_MapBlue) //[[UIColor.systemBlue] colorWithAlphaComponent:0.2]
    //        renderer.fillColor = UIColor(Color.colorCardiRed)
            renderer.lineWidth = 4
            return renderer
          }
          return MKOverlayRenderer()
        }
        
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            switch annotation {
            case _ as MKClusterAnnotation:
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
                annotationView.markerTintColor = UIColor(Color.colorCardiOrange)
//                for clusterAnnotation in cluster.memberAnnotations {
////                    if let place = clusterAnnotation as? PlaceDefi {
////                        //            if place.sponsored {
//////                        cluster.title = place.ownerName
////                        break
////                    }
//                }
                
                annotationView.titleVisibility = .visible
                return annotationView
            case let placeAnnotation as PlaceDefiMove:
                
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "aed") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "aed location")
                
                
                
                
                let defaults = UserDefaults.standard
                let myBackend = defaults.string(forKey: "Backend")
                
                if myBackend == "NEW" {
                    switch placeAnnotation.status {
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
                } else{
                    switch placeAnnotation.status {
                    case "available":
                        annotationView.markerTintColor = UIColor(Color.Map_Calming_Green)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "overdue":
                        annotationView.markerTintColor = UIColor(Color.Cardi_Yellow)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "warning":
                        annotationView.markerTintColor = UIColor(Color.Cardi_Yellow)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "preError":
                        annotationView.markerTintColor = UIColor(Color.Cardi_Yellow)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "error":
                        annotationView.markerTintColor = UIColor(Color.colorCardiRed)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "timeout":
                        annotationView.markerTintColor = UIColor(Color.colorCardiRed)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    case "unknown":
                        annotationView.markerTintColor = UIColor(Color.Cardi_Gray_Map)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                    default:
                        annotationView.markerTintColor = UIColor(Color.Cardi_MapBlue)
                        annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                        
                    }
                }

                annotationView.canShowCallout = true
//                annotationView.glyphImage = UIImage(systemName: "bolt.heart.fill")
                annotationView.clusteringIdentifier = "cluster"
                //          annotationView.markerTintColor = UIColor(Color.green)
                annotationView.titleVisibility = .visible
                
                let label = UILabel()
                label.textColor = UIColor(Color.Map_Calming_Green)
   
                
                if myBackend == "NEW" {
                
                    label.text = placeAnnotation.eventTime
                    annotationView.detailCalloutAccessoryView = label
//                    annotationView.glyphImage = UIImage(systemName: "figure.wave")
//                    annotationView.detailCalloutAccessoryView = UIImage(systemName: "figure.wave").map(UIImageView.init)
//                label.text = placeAnnotation.ownerName.maxLength(length: 25) + " ..."
                
                } else {
                label.text = placeAnnotation.ownerid.maxLength(length: 25) + " ..."
                    annotationView.detailCalloutAccessoryView = label
                }
                
                return annotationView
            default: return nil
            }

            
        }
        
        
        var selectedAnnotation: PlaceDefiMove?
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            self.selectedAnnotation = view.annotation as? PlaceDefiMove
                        
            let defaults = UserDefaults.standard
            let myBackend = defaults.string(forKey: "Backend")
            
            if myBackend == "NEW" {
            
            UserDefaults.standard.set(selectedAnnotation?.ownerSerial, forKey: "SelectedDefi")

            } else {
            
            UserDefaults.standard.set(selectedAnnotation?.idCode, forKey: "SelectedDefi")
            }

        }
        
        @objc func buttonTapped(sender : UIButton) {
            
            @State  var isShowingSheet = true
            
            print("Pressed")
            
            //Write button action here
        }
        func didDismiss() {
            // Handle the dismissing action.
        }
    }
    
    func mybutton(_ mapView: MKMapView) {
        
    }
    
    func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
    }
    
    
}

