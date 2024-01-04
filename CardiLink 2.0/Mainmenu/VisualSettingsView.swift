//
//  VisualSettingsView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 19.09.23.
//

import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case system = "Default (System setting)"
    case dark = "Dark"
    case light = "Light"
}

struct VisualSettingsView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("appearanceMode") private var storedAppearanceMode: String = AppearanceMode.system.rawValue
    @State private var currentMode: AppearanceMode = .system
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                MainBackgroundNew()
                    .edgesIgnoringSafeArea(.all)
                HStack() {
                    Button(action: {
                        navigationManager.pop()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Divider().opacity(0)
                    Text("Appearance")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                } .frame(width: widthInner)
                    .padding(.top,10)
            }.frame(height:60)
            VStack(spacing: 20) {
                ForEach(AppearanceMode.allCases, id: \.self) { mode in
                    Button(action: {
                        setCurrentAppearance(mode)
                    }) {
                        HStack {
                            Text(mode.rawValue)
                            Spacer()
                            if mode == currentMode {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(currentMode == mode ? Color.Calming_Green.opacity(0.6) : Color.clear)
                    .cornerRadius(25)
                }
            } .frame(width: widthInnerText)
                .padding(.top, 100.0)
                .padding()
                .onAppear {
                    if let mode = AppearanceMode(rawValue: storedAppearanceMode) {
                        currentMode = mode
                        applyTheme(mode)
                    }
                }
            Spacer()
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 40.0)
        }
    }
    func setCurrentAppearance(_ mode: AppearanceMode) {
        currentMode = mode
        storedAppearanceMode = mode.rawValue
        applyTheme(mode)
    }
    func applyTheme(_ mode: AppearanceMode) {
        switch mode {
        case .dark:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .dark
        case .light:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .light
        case .system:
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = .unspecified
        }
    }
}


