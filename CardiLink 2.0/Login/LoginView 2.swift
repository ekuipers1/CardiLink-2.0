//
//  LoginView.swift
//  cardi-login
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack  {
            MainBackground()
            FormBackground().overlay(LoginForm())
            
        }.onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
//            $locationManager.$region
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
