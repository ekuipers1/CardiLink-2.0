//
//  NKBT_Menu.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 27.10.21.
//

import SwiftUI

struct NKBT_Menu: View {
    
//    @Binding var isShowingBLE: Bool
    @Binding var isNKBT_Menu: Bool
    
    @State private var isNKBT_Connect: Bool = false
    @State private var isNKBT_Serial: Bool = false
    
    
    var body: some View {
        ZStack {
            MainBackgroundBlue()
        
        
        VStack(){
            Spacer()
            Text("Bluetooth Onboarding")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.Cardi_Text_Inf)
                .padding(.vertical, 50.0)
//            Spacer()
            
            ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 5, y: 5)
                .frame(width: 340, height: 400)
            
            VStack(){
                Text("First time connecting?")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .frame(width: 280, height: 70)
                    .padding(.top, 25.0)

                Button("Prepare the Heart Connect II to connect") {
                    isNKBT_Connect.toggle()
                }.frame(width: 280, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(Color.Cadri_BLE)
                .cornerRadius(40)
                .minimumScaleFactor(0.01)
                
                .sheet(isPresented: $isNKBT_Connect) {
                    NKBT_Connect(isNKBT_Connect: self.$isNKBT_Connect)
                }.padding(.bottom, 15.0)
                
                Text("Heart Connect II is already prepared for connecting")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .frame(width: 280, height: 90)
                    .padding(.top, 25.0)
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                    Button("Enter AED serial number") {
                        UserDefaults.standard.set("", forKey: "ble_state")
                        isNKBT_Serial.toggle()
                           
                    } .frame(width: 280, height: 20)
                    .scaledToFit()
                    .minimumScaleFactor(0.01)

                .padding()
                .foregroundColor(.white)
                .background(Color.Cadri_BLE)
                .cornerRadius(40)
                
                .sheet(isPresented: $isNKBT_Serial) {
                    NKBT_Serial(isNKBT_Serial: self.$isNKBT_Serial)
                }.padding(.bottom, 15.0)
            }
            }
            Spacer()
        }
        
        }
    }
}


struct NKBT_Menu_Previews: PreviewProvider {
    static var previews: some View {
        NKBT_Menu(isNKBT_Menu: .constant(true))
    }
}
