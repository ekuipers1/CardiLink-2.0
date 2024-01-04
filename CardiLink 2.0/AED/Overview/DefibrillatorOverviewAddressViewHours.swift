//
//  DefibrillatorOverviewAddressViewHours.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 07.07.23.
//

import SwiftUI

struct DefibrillatorOverviewAddressViewHours: View {
    
    @StateObject private var viewModel = DeviceAvailabilitySelectedViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var missingDays = [Int]()
    let allDays = [1, 2, 3, 4, 5, 6, 7]
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        
        let defaults = UserDefaults.standard
        VStack(alignment: .trailing){
            ZStack(alignment: .top) {
                Button(action: {
                    navigationManager.navigateTo(.defibrillatoroverview)
                }) {
                    Image(systemName: "x.square.fill")
                        .hamburgerMenu()
                }
                .id(navigationManager.lastUpdated)
                .padding(.top, 20.0)
            }
            
            List {
                ForEach(viewModel.availabilityData, id: \.availabilityData.id) { dataVM in
                    let existingDays = viewModel.availabilityData.map { $0.availabilityData.availabilityDay }
                    let missingDays = allDays.filter { !existingDays.contains($0) }
                    HStack(alignment: .center) {
                        Text(dataVM.availabilityData.availabilityDayText)
                            .foregroundColor(Color.colorCardiGray)
                        Spacer()
                        Text("from \(dataVM.availabilityData.fromTimeHourMinute)")
                            .foregroundColor(Color.colorCardiGray)
                        Text("till \(dataVM.availabilityData.toTimeHourMinute)")
                            .foregroundColor(Color.colorCardiGray)
                    }
                    .frame(height: 40)
                }
                .onDelete(perform: deleteItem)
            }
            .frame(maxHeight: .infinity)
            .refreshable {
                viewModel.checkAvailabilityEmpty()
            }
            
            Spacer()
            VStack {
                Text("Slide Left to Delete")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
                Button(action: {
                    navigationManager.push(.availabilityViewHours)
                }) {
                    HStack {
                        Text("Add/Update - Switch to 24/7")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }
                .frame(width: widthInnerTextButton , height: 25)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
        } .navigationBarHidden(true)
            .onAppear {
                viewModel.checkAvailabilityEmpty()
                let existingDays = viewModel.availabilityData.map { $0.availabilityData.availabilityDay }
                self.missingDays = allDays.filter { !existingDays.contains($0) }
            }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let id = viewModel.availabilityData[index].availabilityData.id
            viewModel.deleteAvailability(id: id) { success in
                if success {
                } else {
                }
            }
        }
    }
}
