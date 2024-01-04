//
//  FormBackground.swift
//  cardi-login
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI

struct FormBackground: View {
    var width:CGFloat = 350
    var height:CGFloat = 400
    var cornerRadius:CGFloat = 30
    var body: some View {

        
        ZStack(alignment: .top) {
 
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.white)
            .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

//        Image("CardiLink-logo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//
//            .padding(.top, 20.0)
//            .frame(width: 250, height: 100)
//            .gesture(TapGesture(count: 2)
//                        .onEnded{
//
//
//
//                            print("Double tapped!")
//                            BLT()
//                        }
//            )

        }
        .padding(.bottom,  180.0)
        
    }
}





struct FormBackground_Previews: PreviewProvider {
    static var previews: some View {
        FormBackground()
    }
}


