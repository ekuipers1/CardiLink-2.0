//
//  NKBT_Connect.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.09.21.
//

import SwiftUI

struct NKBT_Connect: View {

    @Binding var isNKBT_Connect: Bool
    @State private var isNKBT_Serial: Bool = false
    
    var body: some View {
        ZStack {
            MainBackgroundBlue()
        
        
        VStack(){
            Text("Bluetooth Onboarding")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.Cardi_Text_Inf)
                .padding(.top, 40.0)
                .padding(.bottom, 20)
            Spacer()
            
            ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 5, y: 5)
                .frame(width: 340, height: 600)
                
                VStack(){
                Text("Prepare the Heart Connect II to connect")
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing], 25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .frame(width: 280, height: 60)
//                    .padding(.top, 25)
//                    .scaledToFit()
                    .minimumScaleFactor(0.01)

                Text("Make sure your bluetooth is on: Settings - Bluetooth")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .frame(width: 280, height: 70)
                    .padding(.top, 15)
                    .minimumScaleFactor(0.01)
                Text("Press and hold down the indication button by using a paper clip or a similar tool for longer than seven seconds until the yellow LED light starts blinking")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .frame(width: 280, height: 140)
                    .minimumScaleFactor(0.01)
                    ZStack(){
                    Image("ComV2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200,
                               height: 200)
                        .padding(.top, 0.0)
//                        .padding(.leading, -55)
                    
                        Circle()
//                                           .fill(Color.red)
                            .strokeBorder(Color.blue,lineWidth: 4)
                                           .frame(width: 40)
                                           .padding(.top, -130)
                                           .padding(.leading, -85)
                        
                        Circle()
//                                           .fill(Color.red)
                            .strokeBorder(Color.yellow,lineWidth: 4)
                                           .frame(width: 40)
                                           .padding(.top, -20)
                                           .padding(.leading, -85)
                    }
//                    .padding(.top, 60.0)
                    
                    Button("Continue") {
                        UserDefaults.standard.set("", forKey: "ble_state")
                        isNKBT_Serial.toggle()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.Cadri_BLE)
                    .cornerRadius(40)
                    
                    .sheet(isPresented: $isNKBT_Serial) {
                        NKBT_Serial(isNKBT_Serial: self.$isNKBT_Serial)
                    }.padding(.bottom, 55.0)
//                        .padding(-35)
                    
                }.frame(width: 280, height: 580)
                
            }
            .padding(.bottom, 80.0)

            }
        }
    }
}



struct NKBT_Connect_Previews:
        
    PreviewProvider {
    @State private var isNKBT_Connect: Bool = true
    static var previews: some View {
        NKBT_Connect(isNKBT_Connect: .constant(true))
    }
}
