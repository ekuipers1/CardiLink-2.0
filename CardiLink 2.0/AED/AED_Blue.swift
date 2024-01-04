//
//  AED_Blue.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 09.10.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AED_Blue: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var searchText: String = ""
    @State private var dashboardCounts: [Int: Int] = [:]
    @State private var defibrillators: [SearchDefibrillator] = []
    @State private var isLoading: Bool = false
    @State private var error: String? = nil
    @State private var currentFilter: Int? = nil
    let myURL = UserDefaults.standard.string(forKey: "myPortal") ?? ""
    let authKey = UserDefaults.standard.string(forKey: "DATASTRING") ?? ""
    let resultCount = UserDefaults.standard.string(forKey: "countResults") ?? ""
    
    @StateObject var blueSearchViewModel = SearchViewModelColorBlue()
    @State private var isSheetPresented = false
    
    var body: some View {
        
        VStack {
            
            ZStack {
                MainBackgroundBlue()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                }.frame(width: widthInnerText, height: 0)
                    .offset(x: 0, y: 25)
            }
            .frame(width: width, height: 40)
            
            HStack {
                TextField("Search", text: $searchText)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Button(action: {
                    UserDefaults.standard.set(nil, forKey: "postalCodeKey")
                    UserDefaults.standard.set(nil, forKey: "cityNameKey")
                    UserDefaults.standard.set(nil, forKey: "countryNameKey")
                    UserDefaults.standard.set(nil, forKey: "ownerNameKey")
                    UserDefaults.standard.set(nil, forKey: "fromDateElecKey")
                    UserDefaults.standard.set(nil, forKey: "toDateElecKey")
                    UserDefaults.standard.set(nil, forKey: "fromDateBatKey")
                    UserDefaults.standard.set(nil, forKey: "toDateBatKey")
                    UserDefaults.standard.set(nil, forKey: "leftAEDTextValueKey")
                    UserDefaults.standard.set(nil, forKey: "rightAEDTextValueKey")
                    blueSearchViewModel.fetchDataFilter(searchText: searchText, filter: "")
                    UIApplication.shared.dismissKeyboard()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .font(.title)
                        .fontWeight(.regular)
                }
            }
            .frame(width: widthInner)
            
            .padding()
            
            if isLoading {
                ProgressView()
            } else if let errorString = error {
                Text("Error: \(errorString)")
            } else {
                
                Text("Your search returned: \(filteredDefibrillators.count)" + " results")
                    .foregroundColor(Color.Cardi_Text_Inf)
                    .font(.title2)
                    .fontWeight(.regular)
                    .frame(width: widthInner)
                
                List(filteredDefibrillators) { defibrillator in
                    VStack(alignment: .leading) {
                        ZStack {
                            Rectangle()
                                .fill(getFillColor(for: defibrillator.dashboardState))
                            HStack {
                                Text(defibrillator.dashboardStateReason ?? "N/A")
                                    .foregroundColor(Color.Cardi_Text)
                                    .font(.headline)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .frame(width: widthInnerTextList)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }.frame(width: widthInner, height: 60)
                        
                        HStack(){
                            if let description = defibrillator.description {
                                Text(description)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                Spacer()
                            } else {
                                Text("Description: N/A")
                                Spacer()
                            }
                        }
                        
                        HStack(){
                            Text(defibrillator.ownerName ?? "N/A")
                                .fontWeight(.regular)
                                .lineLimit(1)
                                .foregroundColor(Color.colorCardiGray)
                            Spacer()
                        }
                        
                        HStack(){
                            VStack(alignment: .leading){
                                Text(defibrillator.address?.street ?? "N/A")
                                    .foregroundColor(Color.colorCardiGray) + Text(" ") + Text(defibrillator.address?.houseNumber ?? "")
                                    .foregroundColor(Color.colorCardiGray)
                                Text(defibrillator.address?.postalCode ?? "N/A")
                                    .foregroundColor(Color.colorCardiGray) + Text(" ") + Text(defibrillator.address?.city ?? "")
                                    .foregroundColor(Color.colorCardiGray)
                                Text(defibrillator.address?.country ?? "N/A")
                                    .fontWeight(.regular)
                                    .lineLimit(1)
                                    .foregroundColor(Color.colorCardiGray)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Spacer()
                                Image(systemName: imageName(for: defibrillator.dashboardState))
                                    .foregroundColor(getFillColor(for: defibrillator.dashboardState))
                                    .font(.title)
                                Text(defibrillator.serial ?? "N/A")
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .font(.headline)
                            }
                        }
                        .padding(.bottom, 10.0)
                    } .padding(.top, 10.0)
                    
                        .onTapGesture {
                            UserDefaults.standard.set(defibrillator.defiId, forKey: "SelectedDefi")
                            UserDefaults.standard.set(defibrillator.defiId, forKey: "ADdefibrillatorId")
                            UserDefaults.standard.set(defibrillator.dashboardState, forKey: "dashboardState")
                            
                            UserDefaults.standard.set(true, forKey: "NavFromBlueListView")
                            
                            LoadMyData()
                            navigationManager.navigateTo(.defibrillatoroverview)
                        }
                    
                }
                .padding(.bottom, 20.0)
                .scrollContentBackground(.hidden)
                .refreshable {
                    blueSearchViewModel.fetchDataFilter(searchText: searchText, filter: "")
                }
                
            }
            Spacer()
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 30.0)
                .padding(.bottom, 10.0)
        }
        .onAppear(){
            blueSearchViewModel.fetchDataFilter(searchText: searchText, filter: "")
        }
    }
    
    var filteredDefibrillators: [SearchDefibrillator] {
        if let filter = currentFilter {
            return blueSearchViewModel.defibrillators.filter { $0.dashboardState == filter }
        }
        return blueSearchViewModel.defibrillators
    }
    
}
