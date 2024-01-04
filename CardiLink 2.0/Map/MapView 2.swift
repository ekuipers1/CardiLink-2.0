//
//  MapView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import MapKit
import Alamofire
import SwiftyJSON

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel() // NEW
    @ObservedObject var fetcherForlonlat = GetLatLon()
    //    @ObservedObject private var locationManager = LocationManager()
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @State var mapselection: Int? = nil
    @State var cancelll: AnyCancellable?
    
    @State var tracking:MapUserTrackingMode = .none
    
    
    @State var newoneText: String = ""
    
    @State private var showEditView = false
    
    
    //    @StateObject var manager = LocationManager()
    
    //    @State private var region: MKCoordinateRegion = {
    //        var mapCoordinates = CLLocationCoordinate2D(latitude: 49.5, longitude: 11.122820)
    ////        var mapCoordinates = CLLocationCoordinate2D()
    //        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
    //        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    //
    //        return mapRegion
    //    }()
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            
            VStack(){
                
                ZStack(){
                    
                    // MARK: - No2 ADVANCED MAP
                    Map(coordinateRegion: $viewModel.region,  showsUserLocation: true, annotationItems: fetcherForlonlat.fetchlatlon, annotationContent: { item in
                        MapAnnotation(coordinate: item.location) {
                            
                            VStack {
                                
                                //                                Text("12345")
                                let newoneText = item.status
                                //                                var lattext = item.latitude
                                
                                switch newoneText {
                                    //MARK: available
                                case "0": //available
                                    MapAnnotationView(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                getNKMessagesData()
                                                
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
//                                                print(item.ownerid)
                                                
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    
                                                    if myBackend == "NEW" {
                                                        Text("Available")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
//                                            }
  
                                        }}
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                    
                                    
                                    
                                    // RED
                                    //MARK: timeout
                                case "4": //"timeout":
                                    MapAnnotationViewRed(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text("Timeout")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
                                            }
                                            
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                    
                                    //MARK: not_monitored
                                case "5": //not_monitored "unknown":
                                    MapAnnotationViewGray(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text("Not monitored")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }

                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
                                            }
                                            
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                    
                                    //MARK: error
                                case "2": //"error":
                                    MapAnnotationViewRed(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text("Error")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
                                            }
  
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                    
                                    // Yellow
                                    //MARK: overdue
                                case "1": //overdue":
                                    MapAnnotationViewYellow(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
//                                                overdue
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text("Overdue")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
                                            }
                                            
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
//                                case "preError":
//                                    MapAnnotationViewYellow(location: item)
//                                        .contextMenu {
//                                            Button(action: {
//                                                self.showEditView = true
//                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
//
//                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
//
//                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
//
//
//                                                DefiGetsingleData()
//                                                //MARK: NEW
//                                                getNKMessagesData()
//                                                self.mapselection = 1
//
//                                                print(item.latitude)
//                                                print(item.id)
//                                                print(item.longitude)
//                                            }, label: {
//                                                HStack {
//                                                    let defaults = UserDefaults.standard
//                                                    let myBackend = defaults.string(forKey: "Backend")
//                                                    //MARK: NK START
//                                                    if myBackend == "NEW" {
//                                                        Text(item.ownerSerial)
//                                                        Image(systemName: "chevron.right")
//                                                    } else{
//                                                        Text(item.id)
//                                                        Image(systemName: "chevron.right")
//
//                                                    }
//                                                }
//
//                                            })
//
//                                            Button(action: {}) {
//                                                Text(item.status)
//                                                Image(systemName: "bolt.heart.fill")
//                                            }
//                                            Button(action: {}) {
//                                                Image(systemName: "person.fill.viewfinder")
//                                                    .foregroundColor(Color.colorCardiRed)
//                                                Text(item.ownerid)
//
//                                            }
//
//                                        }
//                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
//                                        EmptyView()
//                                    }
                                case "3": //warning":
                                    MapAnnotationViewYellow(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text("Warning")
                                                        Image(systemName: "bolt.heart.fill")
                                                    } else{
                                                        Text(item.status)
                                                        Image(systemName: "bolt.heart.fill")
                                                    }
                                                }
                                            }
                                            Button(action: {}) {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerName)

                                                    } else{
                                                        Image(systemName: "person.fill.viewfinder")
                                                            .foregroundColor(Color.colorCardiRed)
                                                        Text(item.ownerid)
                                                        
                                                    }
                                                }
 
                                            }
                                            
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                default:
                                    MapAnnotationView(location: item)
                                        .contextMenu {
                                            Button(action: {
                                                self.showEditView = true
                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
                                                
                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
                                                
                                                UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
                                                
                                                
                                                DefiGetsingleData()
                                                //MARK: NEW
                                                getNKMessagesData()
                                                self.mapselection = 1
                                                
                                                print(item.latitude)
                                                print(item.id)
                                                print(item.longitude)
                                            }, label: {
                                                HStack {
                                                    let defaults = UserDefaults.standard
                                                    let myBackend = defaults.string(forKey: "Backend")
                                                    //MARK: NK START
                                                    if myBackend == "NEW" {
                                                        Text(item.ownerSerial)
                                                        Image(systemName: "chevron.right")
                                                    } else{
                                                        Text(item.id)
                                                        Image(systemName: "chevron.right")
                                                        
                                                    }
                                                }
                                                
                                            })
                                            
                                            Button(action: {}) {
                                                Text(item.status)
                                                Image(systemName: "bolt.heart.fill")
                                            }
                                            Button(action: {}) {
                                                Image(systemName: "person.fill.viewfinder")
                                                    .foregroundColor(Color.colorCardiRed)
                                                Text(item.ownerid)
                                                
                                            }
                                            
                                        }
                                    NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
                                        EmptyView()
                                    }
                                    
                                }
                                
                            }
                        } //$manager.locationManager.stopUpdatingLocation()
                    } )
                        .accentColor(Color.colorCardiOrange)
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarHidden(true)
                        .onAppear {
                            viewModel.checkIfLocationServicesIsEnabled()
                        }
                        .overlay(
                            
                            
                            HStack(alignment: .center, spacing: 12) {
                                Button(action:{ self.presentationMode.wrappedValue.dismiss()
                                    
                                }){
                                    
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .frame(width: 40.0, height: 40.0)
                                        .foregroundColor(Color.black)
                                        .background(Color.white)
                                        .cornerRadius(50)
                                }
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Map")
                                        .fontWeight(.bold)
                                        .font(.title)
                                }.padding(.trailing, 40.0).frame(width: 250, height: 50)
                            } //: HSTACK
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(
                                    Color.colorCardiOrange
                                        .cornerRadius(25)
                                        .opacity(0.8)
                                )
                                .padding()
                            , alignment: .top
                        )
                }
                
            }
        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}

final class AnyCancellable {
    
    
}

//MARK: OLD SOLUTION

//                                MapAnnotationView(location: item)

//                                    .contextMenu {
//                                        Button(action: {
//                                            self.showEditView = true
//                                                                                UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
//
//                                                                                UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
//
//                                                                                 UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
//
//
//                                                                                DefiGetsingleData()
//                                                                                self.mapselection = 1
//
//                                                                                print(item.latitude)
//                                                                                print(item.id)
//                                                                                print(item.longitude)
//                                        }, label: {
//                                            HStack {
//                                                Text("Edit")
//                                                Image(systemName: "pencil")
//                                            }
//                                        })
//
//                                }
//                                NavigationLink(destination: DefibrillatorDetailed(), isActive: $showEditView) {
//                                    EmptyView()
//                                }

//                            NavigationLink(destination: DefibrillatorDetailed(), tag: 1, selection: $mapselection) {
//                                Button(action: {
//
//                                    UserDefaults.standard.set(item.id, forKey: "SelectedDefi")
//
//                                    UserDefaults.standard.set(item.latitude, forKey: "NewMapLatitude")
//
//                                     UserDefaults.standard.set(item.longitude, forKey: "NewMapLongitude")
//
//
//                                    DefiGetsingleData()
//                                    self.mapselection = 1
//
//                                    print(item.latitude)
//                                    print(item.id)
//                                    print(item.longitude)
//                                }) {
//
//                                    let newoneText = item.status
//
//                                    switch newoneText {
//                                    case "available":
//                                        MapAnnotationView(location: item)
//
//// RED
//                                    case "timeout":
//                                        MapAnnotationViewRed(location: item)
//                                    case "unknown":
//                                        MapAnnotationViewRed(location: item)
//                                    case "error":
//                                        MapAnnotationViewRed(location: item)
//
//// Yellow
//                                    case "overdue":
//                                        MapAnnotationViewYellow(location: item)
//                                    case "preError":
//                                        MapAnnotationViewYellow(location: item)
//                                    case "warning":
//                                        MapAnnotationViewYellow(location: item)
//                                    default:
//                                        MapAnnotationView(location: item)
//
//                                    }
//                                }
//
//                            }



