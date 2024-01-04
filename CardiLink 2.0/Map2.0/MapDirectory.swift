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
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefi].self, from: mydata)
                        self.places = selftestdata
                    } catch {
                    }
                }
            } else {
                do {
                    let json = Bundle.main.url(forResource: "empty", withExtension: ".json")
                    let mydata = try! Data(contentsOf: json!)
                    if mydata.isEmpty {
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
                let mydata = try! Data(contentsOf: filename)
                if mydata.isEmpty {
                } else {
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefiMove].self, from: mydata)
                        let howManyDoWeHave = lastMovementEntry
                        if howManyDoWeHave == nil {
                            self.places = selftestdata
                        } else {
                        let rate = selftestdata.filter { $0.idCode == lastMovementEntry }
                        self.places = rate
                        }
                    } catch {
                    }
                }
            } else {
                do {
                    let json = Bundle.main.url(forResource: "emptymove", withExtension: ".json")
                    let mydata = try! Data(contentsOf: json!)
                    if mydata.isEmpty {
                    } else {
                    }
                    do {
                        let selftestdata = try JSONDecoder().decode([PlaceDefiMove].self, from: mydata)
                        let howManyDoWeHave = 0
                        if howManyDoWeHave == 0 {
                            self.places = selftestdata
                        } else {
                        }  
                    } catch {
                        fatalError("Unable to load or parse json file from bundle")
                    }
                    
                }
            }
        }
    }
}
