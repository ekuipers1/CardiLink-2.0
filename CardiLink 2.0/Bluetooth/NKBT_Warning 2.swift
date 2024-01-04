//
//  NKBT_Warning.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 21.06.22.
//

import SwiftUI

struct NKBT_Warning: View {
    
    @Binding var isShowingBLE: Bool
    
    @State private var isNKBT_Menu: Bool = false
//    @State private var isNKBT_Connect: Bool = false
//    @State private var isNKBT_Serial: Bool = false
    
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
                
                HStack {

                    
                
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title)
                    .padding(.top, 25.0)
                    .foregroundColor(Color.Cardi_Yellow)
                Text("Important Notice")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.top, 25.0)
                    .scaledToFit()
                    .minimumScaleFactor(0.6)
                    .frame(width: 240, height: 40)
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title)
                        .padding(.top, 25.0)
                        .foregroundColor(Color.Cardi_Yellow)
                }.padding(.bottom, 25.0)
//                Button("Prepare the HCII to connect") {
////                    isNKBT_Connect.toggle()
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.colorCardiOrange)
//                .cornerRadius(40)
//
////                .sheet(isPresented: $isNKBT_Connect) {
////                    NKBT_Connect(isNKBT_Connect: self.$isNKBT_Connect)
//                }.padding(.bottom, 15.0)
                

                Text("Before you start the connecting wizard please make sure you always have only (1) Heart Connect II active, if you have more, the pairing process will not work.")
                    .multilineTextAlignment(.center)
//                    .padding(25.0)
                    .foregroundColor(Color.colorCardiGray)
                    .padding(.bottom, 25.0)
                    .frame(width: 280, height: 150)
                    .minimumScaleFactor(0.01)

                    .scaledToFit()
                
//                    .padding(.top, 25.0)
                
                
                    Button("Continue") {
//                        UserDefaults.standard.set("", forKey: "ble_state")
                        isNKBT_Menu.toggle()
                    }.frame(width: 120, height: 20)
                    

                    .padding([.top, .bottom], 15.0)
                .foregroundColor(.white)
                .background(Color.Cadri_BLE)
                .cornerRadius(40)

                .sheet(isPresented: $isNKBT_Menu) {
                    NKBT_Menu(isNKBT_Menu: self.$isNKBT_Menu)
                }.padding(.bottom, 15.0)
            }
            }
            Spacer()
        }
        
        }
    }
}

struct NKBT_Warning_Previews: PreviewProvider {
    static var previews: some View {
        NKBT_Warning(isShowingBLE: .constant(true))
    }
}
