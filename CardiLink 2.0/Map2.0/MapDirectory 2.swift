//
//  MapDirectory.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.02.22.
//

import Foundation
import SwiftUI

struct MapDirectory {
    
    var  places = [PlaceDefi]()
    
    
    init(){
        
        load()
    }
    
    mutating func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("latlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("MOVE FILE AVAILABLE")
                
//                UserDefaults.standard.set("Yes", forKey: "Moving")
//                let _ =  print("MUSTBE:\(String(describing: "YES1"))")
                
                
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("MOVE FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.places = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MOVE GEOFILE FILE ERROR")
                    }
                }
            } else {
                print("MOVE FILE NOT AVAILABLE")
                
                do {
                    
                    let json = Bundle.main.url(forResource: "empty", withExtension: ".json")
                    
                    let mydata = try! Data(contentsOf: json!)
                    
                    if mydata.isEmpty {
                        print("MOVE FILE AVAILABLE BUT EMPTY")
                    } else {
                        
                    }
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.places = selftestdata
                    } catch {
                        fatalError("Unable to load or parse json file from bundle")
                    }
                    
                }
            }
        }
    }
}


struct MapDirectoryMove {

    var  places = [PlaceDefiMove]()
    
    @AppStorage("lastMovementEntry") var lastMovementEntry: String?
    
    init(){
        
        load()
    }
    
    mutating func load() {
        
        do {
            
            let filename = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
            if FileManager.default.fileExists(atPath: filename.path) {
                print("MOVEMENT FILE AVAILABLE")
                
                let mydata = try! Data(contentsOf: filename)
                
                if mydata.isEmpty {
                    print("MOVEMENT FILE AVAILABLE BUT EMPTY")
                } else {
                    
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefiMove].self, from: mydata)
                        
                        let howManyDoWeHave = lastMovementEntry
//                        print("FIRST MOVE NOVALUE", howManyDoWeHave)
                        
                        if howManyDoWeHave == nil {
                            
                            self.places = selftestdata
                        } else {
                        
//                            print("FIRST MOVE VALUE", howManyDoWeHave)
                        let rate = selftestdata.filter { $0.idCode == lastMovementEntry }
                        self.places = rate
                            
                        }
//                        self.places = selftestdata
                    } catch {
                        //handle error
                        print(error)
                        print("💣 MOVEMENT GEOFILE FILE ERROR")
                    }
                }
            } else {
                print("MOVEMENT FILE NOT AVAILABLE")
                
                do {
                    
                    let json = Bundle.main.url(forResource: "emptymove", withExtension: ".json")
                    
                    let mydata = try! Data(contentsOf: json!)
                    
                    if mydata.isEmpty {
                        print("MOVEMENT FILE AVAILABLE BUT EMPTY")
                    } else {
                        
                    }
                    do {

                        let selftestdata = try JSONDecoder().decode([PlaceDefiMove].self, from: mydata)
//                        self.places = selftestdata
                        print(selftestdata)
                        
                        
                        
                        let howManyDoWeHave = 0
//                        print("FIRST MOVE NOVALUE", howManyDoWeHave)
                        
                        if howManyDoWeHave == 0 {
                            
                            self.places = selftestdata
                        } else {
                        
////                            print("FIRST MOVE VALUE", howManyDoWeHave)
//                        let rate = selftestdata.filter { $0.idCode == lastMovementEntry }
//                        self.places = rate
                            
                        
                        }
                        
                        
                        
//                        let rate = selftestdata.filter { $0.idCode == "3" }
//                        self.places = rate
                        
//                        print(rate)
                        
                        
                        //                        let rate = selftestdata.filter { $0.latitude > userCenterLatBottom  && $0.latitude < userCenterLatTop}
                        //                        let rate2 = rate.filter { $0.longitude > userCenterLonLeft  && $0.longitude < userCenterLonRight}
                        //                        print("FILTERGEO2", rate2)
                        
                        
                        
                        
                        
                        
                    } catch {
                        fatalError("Unable to load or parse json file from bundle")
                    }
                    
                }
            }
        }
    }
}
