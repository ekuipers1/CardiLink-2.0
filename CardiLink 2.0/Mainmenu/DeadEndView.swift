//
//  DeadEndView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.10.23.
//

import SwiftUI

struct DeadEndView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer(minLength: geometry.size.height / 2 - 50)
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2 - 30, y: geometry.size.height / 2 - 30))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width / 2 + 30, y: geometry.size.height / 2 - 30))
                    }
                    .stroke(Color.black, lineWidth: 5)
                    
                    Spacer(minLength: geometry.size.height / 2)
                    Text("You have reached a ☠️ DEAD END")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                }
                .frame(height: geometry.size.height * 2)
            }
        }
    }
}

#Preview {
    DeadEndView()
}
