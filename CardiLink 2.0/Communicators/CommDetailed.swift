//
//  CommDetailed.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI

struct CommDetailed: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var selection: Int? = nil
    @State private var show = false
    @State private var change = false
    @State private var showButtons = false
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        ZStack(alignment: .top){
            MainBackground()
            VStack(){
                ScrollView() {
                    ZStack(){
                        ScrollView(showsIndicators: true) {
                            let defaults = UserDefaults.standard
                            comMainInfo()
                                .padding(.top, 40.0)
                            comPairedSingleNK()
                            comInitalBootDate()
                            comdescriptionSingle()
                            compairedWithSingle()
                                .padding(.bottom, 60.0)
                            Spacer()
                        }
                    }
                }
                .padding(.top, 100.0)
            }
            CommunicatorMenu()
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
}







