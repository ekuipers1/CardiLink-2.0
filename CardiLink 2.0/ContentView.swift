//
//  ContentView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.05.23.
//

import SwiftUI
import MapKit
import UIKit
import Firebase
import UserNotifications

import AppTrackingTransparency
import AdSupport

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var defibrillators: [DefibrillatorMap] = []
    @State private var mapType: MKMapType = .standard
    @State private var selectedDefibrillator: DefibrillatorMap?
    @State var portalInfoArray: [PortalInfo] = []
    @AppStorage("savedUserID") private var savedUserID: String = ""
    @AppStorage("savedPassword") private var savedPassword: String = ""
    @State private var trackingStatus: ATTrackingManager.AuthorizationStatus?

    init() {
        UserDefaults.standard.register(defaults: [
            "YellowCountWarning": 0,
            "YellowCountOverdue": 0,
            "RedTimeout": 0,
            "RedError": 0,
            "GrayCount": 0,
            "green": 0,
            "yellow": 0,
            "red": 0,
            "gray": 0,
            "blue": 0,
            "DATASTRING": 0,
            "myPortal": 0,
            "CommunicatorCount": 0,
            "withGps" : 0,
            "NavFromSearch" : false
            
        ])
    }
    
    var body: some View {
        Group {
            switch navigationManager.currentView {
                
            case .tester:
                XXIImageTester2()
                    .environmentObject(navigationManager)
            case .login:
                CASLogin()
                    .environmentObject(navigationManager)
            case .userinfoview:
                UserInfoView()
                    .environmentObject(navigationManager)
            case .userinfodetailview:
                UserInfoDetailView()
                    .environmentObject(navigationManager)
            case .visualview:
                VisualSettingsView()
                    .environmentObject(navigationManager)
            case .aedsearch:
                AEDSearch()
                    .environmentObject(navigationManager)
            case .changepwd:
                ChangePasswordView()
                    .environmentObject(navigationManager)
            case .settingsview:
                SettingsView()
                    .environmentObject(navigationManager)
            case .portalSelect:
                PortalSelector(portalInfoArray: portalInfoArray)
                    .environmentObject(navigationManager)
            case .dashboard:
                Dashboard()
                    .environmentObject(navigationManager)
            case .greenAED:
                AED_Green()
                    .environmentObject(navigationManager)
            case  .yellowAED:
                AED_Yellow()
                    .environmentObject(navigationManager)
            case .redAED:
                AED_Red()
                    .environmentObject(navigationManager)
            case .grayAED:
                AED_Gray()
                    .environmentObject(navigationManager)
            case .blueAED:
                AED_Blue()
                    .environmentObject(navigationManager)
            case .heartconnect:
                CommMainMenu_New()
                    .environmentObject(navigationManager)
            case .about:
                AboutView()
                    .environmentObject(navigationManager)
            case .maps:
                MapViewGPS(defibrillators: $defibrillators, mapType: $mapType, showDetails: .constant(false))
                    .environmentObject(navigationManager)
            case .maps2:
                ParentView()
                    .environmentObject(navigationManager)
            case .adIntro:
                AD_01_Intro()
                    .environmentObject(navigationManager)
            case .adSerialSelect:
                AD_02_CardiaSerialSelect()
                    .environmentObject(navigationManager)
            case .scanner:
                AD_031_CardiaSerial_ScannerView()
                    .environmentObject(navigationManager)
            case .serialType:
                AD_032_CardiaSerial_Type()
                    .environmentObject(navigationManager)
            case .adSerialSelectVivest:
                AD_02_VivestSerialSelect()
                    .environmentObject(navigationManager)
            case .scannerVivest:
                AD_031_VivestSerial_ScannerView()
                    .environmentObject(navigationManager)
            case .serialTypeVivest:
                AD_031_VivestSerial_Type()
                    .environmentObject(navigationManager)
            case .adSerialSelectPrimedic:
                AD_02_PrimedicSerialSelect()
                    .environmentObject(navigationManager)
            case .scannerPrimedic:
                AD_031_PrimedicSerial_ScannerView()
                    .environmentObject(navigationManager)
            case .serialTypePrimedic:
                AD_031_PrimedicSerial_Type()
                    .environmentObject(navigationManager)
            case .adiotstart:
                AD_04_IotStart()
                    .environmentObject(navigationManager)
            case .adNKiotstart:
                AD_04_NKHC()
                    .environmentObject(navigationManager)
            case .adVIViotstart:
                AD_04_VIVHC()
                    .environmentObject(navigationManager)
            case .nkbleonboarding:
                NKADBLEOnboarding()
                    .environmentObject(navigationManager)
            case .adcardiaonboarding:
                AD_05_CardiaOnboarding()
                    .environmentObject(navigationManager)
            case .adcardiaonboardingpreserial:
                AD_06_OnboardingPreSerial()
                    .environmentObject(navigationManager)
            case .adcardiapairingopencover:
                AD_07_CardiaPairingOpenCover()
                    .environmentObject(navigationManager)
            case .adcardiapairingstages:
                AD_08_CardiaPairingStages()
                    .environmentObject(navigationManager)
            case .adcardiapairingclosecover:
                AD_09_CardiaPairingCloseCover()
                    .environmentObject(navigationManager)
            case .adcardiaparingcheck:
                AD_10_CardiaPairingCheck()
                    .environmentObject(navigationManager)
            case .adcardiamotiondetection:
                ADCardiaMotionDetection()
                    .environmentObject(navigationManager)
            case .adcardiapairingredgreen:
                AD_11_CardiaPairingRedGreen()
                    .environmentObject(navigationManager)
            case .adlocationmainscreen:
                AD_11_LocationMainScreen()
                    .environmentObject(navigationManager)
            case .adlocationposition:
                AD_121_LocationPosition()
                    .environmentObject(navigationManager)
            case .adlocationaddress:
                AD_122_LocationAddress()
                    .environmentObject(navigationManager)
            case .adlocationmap:
                AD_13_LocationMap()
                    .environmentObject(navigationManager)
            case .adlocationadditional:
                AD_14_LocationAdditional()
                    .environmentObject(navigationManager)
            case .adlocationavail:
                AD_15_LocationAvailability()
                    .environmentObject(navigationManager)
            case .adavailtimes:
                AD_16_LocationAvailabilityTimes()
                    .environmentObject(navigationManager)
            case .adimageselection:
                AD_19_ImagesSelection()
                    .environmentObject(navigationManager)
            case .adlocationsharedata:
                AD_20_LocationShareData()
                    .environmentObject(navigationManager)
            case .adlocationtimesover:
                AD_17_LocationAvailabilityTimesOverview()
                    .environmentObject(navigationManager)
            case .adlocationimages:
                AD_18_LocationImages()
                    .environmentObject(navigationManager)
            case .adendoverview:
                AD_212_UpdateEndOverview()
                    .environmentObject(navigationManager)
            case .adLocationEnd:
                AD_22_LocationEnd()
                    .environmentObject(navigationManager)
            case .NKserialType:
                AD_02_NKSerialSelect_Type()
                    .environmentObject(navigationManager)
            case .nkbleconnected:
                NKBT_Connected()
                    .environmentObject(navigationManager)
            case .adnkparingopencover:
                ADNKPairingOpenCover()
                    .environmentObject(navigationManager)
            case .adnkparingclosecover:
                ADNKPairingCloseCover()
                    .environmentObject(navigationManager)
            case .adnkparingstages:
                ADNKPairingStages()
                    .environmentObject(navigationManager)
            case .defibrillatoroverview:
                AED_Overview()
                    .environmentObject(navigationManager)
            case .availabilityView:
                DefibrillatorOverviewAddressViewHours()
                    .environmentObject(navigationManager)
            case .availabilityViewHours:
                DefibrillatorOverviewAddressAddHours(viewModel: DeviceAvailabilityViewModel())
                    .environmentObject(navigationManager)
            case .newView:
                AD_032_CardiaSerial_Type()
                    .environmentObject(navigationManager)
            case .deadend:
                DeadEndView()
                    .environmentObject(navigationManager)
            }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        let defaults = UserDefaults.standard
        defaults.set("0", forKey: "green")
        defaults.set("0", forKey: "yellow")
        defaults.set("0", forKey: "red")
        defaults.set("0", forKey: "gray")
        defaults.set("0", forKey: "blue")
        defaults.set("0", forKey: "withGps")
        defaults.set("0", forKey: "GreenCount")
        defaults.set("0", forKey: "YellowOverdue")
        defaults.set("0", forKey: "YellowCount")
        defaults.set("0", forKey: "RedCount")
        defaults.set("0", forKey: "RedTimeout")
        defaults.set("0", forKey: "YellowCountOverdue")
        defaults.set("0", forKey: "CommunicatorCount")
        defaults.set("false", forKey: "editAdressInfo")
        defaults.set("false", forKey: "ADExcisting")
        defaults.set("No", forKey: "NONIOT")
        defaults.set("NO", forKey: "WaitForIt")
        defaults.set(false, forKey: "NavFromSearch")
    }
}

