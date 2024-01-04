//
//  MapAnnotationView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//
import SwiftUI

struct MapAnnotationView: View {
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
//                    .foregroundColor(Color.Map_Calming_Green)
//                    .opacity(1 - animation)
                Image(systemName: "bolt.heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,
                           height: 30)
                    .foregroundColor(Color.Map_Calming_Green)
//                Image(systemName: "wave.3.right")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30,
//                           height: 30)
//                    .padding([.top, .leading], -20)
//                    .foregroundColor(Color.Map_Calming_Green)
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

