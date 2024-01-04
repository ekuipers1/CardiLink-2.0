//
//  DefibrillatorOverviewAvailable.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 30.06.23.
//

import SwiftUI

struct DefibrillatorOverviewAvailable: View {
    
    @StateObject private var viewModel = DeviceAvailabilityViewModel()
    @State private var isShowingAvailability = false
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var showButtons = false
    @State private var dropdownComm = false
    @AppStorage("defidetailpairingSerial") var commdetailSerial: String?
    @AppStorage("commdetailpairingDate") var initialBootupDate: String?
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    @StateObject private var viewModelDevice = DeviceAvailabilitySelectedViewModel()
    
    var body: some View {
        ZStack(alignment: .leading){
            BackgroundRectangle()
            ZStack(){
                Button(action: { withAnimation {
                    dropdownComm.toggle()
                } }) {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .padding(showButtons ? 15.0 : 15.0)
                        .rotationEffect(Angle.degrees(dropdownComm ? 180 : 0))
                    
                }
                .background(Circle().fill(Color.Cardi_Text))
                .offset(x: 170, y: -25)
                .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
            }  .offset(x: 105)

            HStack(){
                HStack(spacing: -20){
                    Image(systemName: "clock.badge.questionmark")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .padding(10.0)
                }
                VStack(alignment: .leading){
                    Text("Public Availability")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .fontWeight(.semibold)
                }
            }
        }.padding(.top, 20.0)
        
        if dropdownComm {
            VStack(){
                NavigationLink(destination: DefibrillatorOverviewAddressAddHours(viewModel: DeviceAvailabilityViewModel())) {
                    ZStack(alignment: .leading){
                        BackgroundRectangle()
                        renderAvailabilityLink().frame(minWidth: 0, maxWidth: 320, minHeight: 0, maxHeight: 60).offset(x: 15)
                         .offset(x: 15)
                    }
                }.simultaneousGesture(TapGesture().onEnded{
                    viewModel.checkAvailability()
                })
            }
            .padding(.top, 10.0)
            .onAppear {
                viewModelDevice.checkAvailabilityEmpty()
                viewModel.checkAvailability()
            }
        }
    }
    
    private func renderAvailabilityLink() -> some View {
        if viewModel.is24_7Available == true {
            return AnyView(
                HStack {
                    Image(systemName: "clock.arrow.2.circlepath")
                        .font(.title2)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .padding(10.0)
                    Text("Available 24/7")
                    Spacer()
                }
            )
        } else if viewModel.is24_7Available == false {
            if viewModelDevice.is24_7Empty {
                return AnyView(
                    Button(action: {
                        navigationManager.push(.availabilityView)
                    }) {
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                                .font(.title2)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.primary)
                            Text("Show times")
                            Spacer()
                        }
                    }
                )
            } else {
                return AnyView(
                    Button(action: {
                        navigationManager.push(.availabilityViewHours)
                    }) {
                        HStack {
                            Image(systemName: "clock.arrow.2.circlepath")
                                .font(.title2)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .padding(10.0)
                            Text("Available 24/7")
                        }
                    }
                )
            }
        }
        return AnyView(EmptyView())
    }

}





