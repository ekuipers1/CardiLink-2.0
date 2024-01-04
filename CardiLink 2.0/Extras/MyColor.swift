//
//  MyColor.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 02.12.20.
//

import SwiftUI

extension Color {
    
    static let colorCardiOrange = Color("Cardi_Orange")
    static let colorCardiOrange50 = Color("Cardi_Orange50")
    static let colorCardiGray = Color("Cardi_Gray")
    static let colorCardiGray50 = Color("Cardi_Gray50")
    static let colorCardiRed = Color("Cardi_Red")
    static let colorCardiRed50 = Color("Cardi_Red50")
    static let Calming_Green = Color("Calming_Green")
    static let Map_Calming_Green = Color("Map_Calming_Green")
    static let Cardi_MapBlue = Color("Cardi_MapBlue")
    static let Cardi_Text = Color("Cardi_Text")
    static let Cardi_Text_Inf = Color("Cardi_Text_Inf")
    static let Cardi_Portal = Color("Cardi_Portal")
    static let map_text = Color("map_text")
    static let Cardi_Yellow = Color("Cardi_Yellow")
    static let Cardi_group = Color("Cardi_group")
    static let Cardi_Gray_Map = Color("Cardi_Gray_Map")
    static let Cadri_BLE = Color("Cadri_BLE")
    static let Cardi_Blocks = Color("Cardi_Blocks")
    static let Cadi_Select = Color("Cadi_Select")

}

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.Cardi_group))
            .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
    }
}
