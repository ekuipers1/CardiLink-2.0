//
//  AEDSearch.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 13.09.23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AEDSearch: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText: String = ""
    @State private var dashboardCounts: [Int: Int] = [:]
    @State private var defibrillators: [SearchDefibrillator] = []
    @State private var isLoading: Bool = false
    @State private var error: String? = nil
    @State private var currentFilter: Int? = nil

    var body: some View {
        VStack {
            ZStack {
                MainBackgroundNew()
                    .edgesIgnoringSafeArea(.all)
            }
            .frame(height:10)
            
            HStack {
                TextField("Search", text: $searchText)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Button(action: {
                    performSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .font(.title)
                        .fontWeight(.regular)
                }
            }
            .frame(width: widthInner)
            .padding()
            
            HStack(spacing: 15) {
                coloredCube(color: .Calming_Green, count: viewModel.dashboardCounts[0] ?? 0, filter: 0)
                coloredCube(color: .Cardi_Yellow, count: (viewModel.dashboardCounts[1] ?? 0) + (viewModel.dashboardCounts[3] ?? 0), filter: 3)
                coloredCube(color: .colorCardiRed, count: (viewModel.dashboardCounts[2] ?? 0) + (viewModel.dashboardCounts[4] ?? 0), filter: 2)
                coloredCube(color: .Cardi_MapBlue, count: viewModel.dashboardCounts[6] ?? 0, filter: 6)
            }.frame(width: widthInner)
                .padding(.bottom)
            if isLoading {
                ProgressView()
            } else if let errorString = error {
                Text("Error: \(errorString)")
            } else {
                
                
                List(filteredDefibrillators) { defibrillator in
                    VStack(alignment: .leading) {
                        ZStack() {
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
                            UserDefaults.standard.set(true, forKey: "NavFromSearch")
                            UserDefaults.standard.set(searchText, forKey: "savedSearchText")
                            LoadMyData()
                            navigationManager.navigateTo(.defibrillatoroverview)
                        }
                }.scrollContentBackground(.hidden)
                    .padding(.bottom, 20.0)
            }
            Spacer()
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 30.0)
                .padding(.bottom, 10.0)
            
        }.onAppear {
            if let savedSearchText = UserDefaults.standard.string(forKey: "savedSearchText"), !savedSearchText.isEmpty {
                searchText = savedSearchText
                performSearch()
            }
        }

    }
    
    var filteredDefibrillators: [SearchDefibrillator] {
        var filters: [Int]
        switch currentFilter {
        case 1:
            filters = [1, 3] // For yellow
        case 2:
            filters = [2, 4] // For red
        default:
            filters = [currentFilter].compactMap { $0 } // For other colors
        }
        return viewModel.defibrillators.filter { filters.contains($0.dashboardState) }
    }

    func performSearch() {
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
        viewModel.fetchDataFilter(searchText: searchText, filter: "")
        UIApplication.shared.dismissKeyboard()
    }
    func coloredCube(color: Color, count: Int, filter: Int) -> some View {
        Button(action: {
            if currentFilter == filter {
                currentFilter = nil
            } else {
                currentFilter = filter
            }
        }) {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(color.opacity((count == 0 || (currentFilter != nil && currentFilter != filter)) ? 0.2 : 1.0))
                        .frame(width: 70, height: 70)
                    Text("\(count)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.Cardi_Text)
                        .opacity(1)
                        .frame(width: 60, alignment: .bottom)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                Rectangle()
                    .fill(color.opacity((count == 0 || (currentFilter != nil && currentFilter != filter)) ? 0.2 : 1.0))
                    .frame(width: 70, height: 5)
                    .padding(.top, 5.0)
            }
        }
    }
}

func getFillColor(for dashboardState: Int) -> Color {
    switch dashboardState {
    case 0:
        return .Calming_Green
    case 1, 3:
        return .Cardi_Yellow
    case 2, 4:
        return .colorCardiRed
    case 6:
        return .Cardi_MapBlue
    default:
        return .gray
    }
}

func imageName(for state: Int?) -> String {
    switch state {
    case 0, 6:
        return "checkmark.circle.fill"
    case 1, 2, 3, 4:
        return "exclamationmark.triangle.fill"
    case 5:
        return "circle.slash"
    default:
        return "questionmark.circle"
    }
}

