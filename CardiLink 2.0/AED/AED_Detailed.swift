//
//  AED_Detailed.swift.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI

struct AED_Detailed: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var selection: Int? = nil
    @State private var show = false
    @State private var change = false
    @AppStorage("defridetailID") var defridetailID: String?
    @AppStorage("dashboardState") var dashboardState: String?
    @AppStorage("MovingLoadingDone") var doneWork: String!
    @State private var showButtons = false
    
    var body: some View {
        ZStack {
            if doneWork == "NO" {
                Text("is loading")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .padding(.top, 30.0)
                
            } else {
                ZStack(alignment: .top){
                    let defaults = UserDefaults.standard
                    let backroundColor = Int(dashboardState ?? "N/A") ?? 0
                    
                    switch backroundColor {
                    case 0:
                        MainBackgroundGreen()
                    case 1:
                        MainBackgroundYellow()
                    case 2:
                        MainBackgroundRed()
                    case 3:
                        MainBackgroundYellow()
                    case 4:
                        MainBackgroundRed()
                    case 5:
                        MainBackgroundGray()
                    default:
                        MainBackground()
                    }
                    VStack(){
                        ScrollView() {
                            ZStack(){
                                ScrollView(showsIndicators: true) {
                                    let movement = defaults.string(forKey: "Moving")
                                    defiMainInfo()
                                        .padding(.top, 40.0)
                                    if movement == "Yes" {
                                        defiMovementSingle()
                                    }
                                    defiStatusSingle()
                                        .padding(.top, 20.0)
                                    adminStatusSingle()
                                        .padding(.top, 20.0)
                                    descriptionSingle()
                                        .padding(.top, 20.0)
                                    selfTestSingle()
                                        .padding(.top, 20.0)
                                    pairedWithSingle()
                                        .padding(.top, 20.0)
                                        .padding(.bottom, 60.0)
                                    Spacer()
                                    
                                }
                                
                            }
                        }
                        .padding(.top, 100.0)
                    }
                    DefibrillatorMenu()
                        .navigationBarHidden(true)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

