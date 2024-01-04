//
//  NavigationManager.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.05.23.
//

import Foundation

class NavigationManager: ObservableObject {

    @Published private(set) var viewStack: [ViewName] = [.login]
    @Published var portalInfoArray: [PortalInfo] = []
    @Published private(set) var lastUpdated = UUID()
    
    var currentView: ViewName {
        viewStack.last ?? .login
    }
    
    enum ViewName {
        case tester
        case login
        case portalSelect
        case userinfoview
        case userinfodetailview
        case changepwd
        case settingsview
        case aedsearch
        case visualview
        case dashboard
        case greenAED
        case yellowAED
        case redAED
        case grayAED
        case blueAED
        case heartconnect
        case about
        case maps
        case maps2
        case adIntro
        case adSerialSelect
        case scanner
        case serialType
        case adSerialSelectVivest
        case scannerVivest
        case serialTypeVivest
        case adSerialSelectPrimedic
        case scannerPrimedic
        case serialTypePrimedic
        case adiotstart
        case adNKiotstart
        case adVIViotstart
        case nkbleonboarding
        case adcardiaonboarding
        case adcardiapairingopencover
        case adcardiapairingclosecover
        case adcardiaparingcheck
        case adcardiamotiondetection
        case adcardiapairingredgreen
        case adlocationmainscreen
        case adlocationposition
        case adlocationaddress
        case adlocationmap
        case adlocationadditional
        case adlocationavail
        case adavailtimes
        case adimageselection
        case adlocationsharedata
        case adlocationtimesover
        case adlocationimages
        case adcardiaonboardingpreserial
        case adcardiapairingstages
        case adendoverview
        case adLocationEnd
        case NKserialType
        case nkbleconnected
        case adnkparingopencover
        case adnkparingstages
        case adnkparingclosecover
        case defibrillatoroverview
        case availabilityView
        case availabilityViewHours
        case newView
        case deadend
    }
    
    func push(_ view: ViewName) {
        viewStack.append(view)
    }
    
    func pop() {
        _ = viewStack.popLast()
    }
    
    func navigateTo(_ view: ViewName) {
        viewStack.removeAll()
        viewStack.append(view)
        lastUpdated = UUID()
    }
}
