//
//  MapAnnotationViewTEST.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.11.21.
//

import SwiftUI

struct MapAnnotationViewTEST: View {
    
    var location: MoveLatLonAvailable
    @State private var animation: Double = 0.0
    
    
    var body: some View {
        ZStack {
            
            HStack(){

                Image(systemName: "mappin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,
                           height: 30)
                    .foregroundColor(Color.colorCardiRed)

            }
            
        } //: ZSTACK
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                animation = 1
            }
        }
    }
}

