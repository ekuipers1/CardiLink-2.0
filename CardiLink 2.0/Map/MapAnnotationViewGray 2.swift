//
//  MapAnnotationViewGray.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 03.12.21.
//

import SwiftUI

struct MapAnnotationViewGray: View {
    // MARK: - PROPERTIES
    
    var location: LatLonAvailable
    @State private var animation: Double = 0.0
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            
            HStack(){
//                Image(systemName: "wave.3.left")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30,
//                           height: 30)
//                    .padding([.top, .trailing], -20)
//                    .foregroundColor(Color.colorCardiRed)
//                    .opacity(1 - animation)
                Image(systemName: "bolt.heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,
                           height: 30)
                    .foregroundColor(Color.Cardi_Gray_Map)
//                Image(systemName: "wave.3.right")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30,
//                           height: 30)
//                    .padding([.top, .leading], -20)
//                    .foregroundColor(Color.colorCardiRed)
//                    .opacity(1 - animation)
                
            }
            
        } //: ZSTACK
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                animation = 1
            }
        }
    }
}


