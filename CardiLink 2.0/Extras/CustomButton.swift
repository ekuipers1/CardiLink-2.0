//
//  CustomButton.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI

struct CustomButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.colorCardiOrange)
                .frame(width: 300, height: 50, alignment: .trailing)
                .padding()
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .overlay(
                    Text(self.text)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
        }
    }
}


