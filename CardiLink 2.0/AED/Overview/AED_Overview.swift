//
//  AED_Overview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 28.07.22.
//

import SwiftUI
import MapKit

struct AED_Overview: View {
    
    @State private var change = false
    @State private var showMenu = false
    @State private var showButtons = false
    @State var defiSelection: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    @AppStorage("dashboardState") var dashboardState: String?
    @AppStorage("OverviewSelection") var OverviewSelection: String?
    @AppStorage("SetSelection") var SetSelection: String?
    @AppStorage("DIYBattery") var DIYBattery: String?
    @AppStorage("DIYCrucial") var DIYCrucial: String?
    @AppStorage("DIYMovements") var DIYMovements: String?
    @AppStorage("DIYLastSelfTests") var DIYLastSelfTests: String?
    @AppStorage("DIYServiceTickets") var DIYServiceTickets: String?
    @AppStorage("DIYLastMessage") var DIYLastMessage: String?
    @AppStorage("DIYMapInfo") var DIYMapInfo: String?
    @AppStorage("DIYAvailaability") var DIYAvailaability: String?
    @AppStorage("NavFromAD") var NavFromAD: Bool?
    @AppStorage("NavFromSearch") var NavFromSearch: Bool?
    @AppStorage("NavFromGreenListView") var NavFromGreenListView: Bool?
    @AppStorage("NavFromYellowListView") var NavFromYellowListView: Bool?
    @AppStorage("NavFromRedListView") var NavFromRedListView: Bool?
    @AppStorage("NavFromBlueListView") var NavFromBlueListView: Bool?
    
    @StateObject private var viewModel = DeviceAvailabilityViewModel()
    @StateObject private var viewModelDevice = DeviceAvailabilitySelectedViewModel()
    @StateObject var imageFetcher = ImageFetcher()
    
    @AppStorage("defridetailAdminStatusReason") var defridetailAdminStatusReason: String?
    @AppStorage("defridetailAdminStatusColor") var defridetailAdminStatusColor: Int?
    
    @Environment(\.presentationMode) var presentationMode
    @State var layoutData = SelectedData(layoutSelection: "Default")
    @State private var isShowingDetailView = false
    
    @AppStorage("WaitForItOverview") var doneWork: String!
    @State var trimValue1 : CGFloat = 0
    @State var trimValue2 : CGFloat = 0
    @State var timeRemaining = 1*3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        if doneWork == "NO" {
            ZStack(){
                VStack(){
                    Image("CardiLink-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, -40.0)
                        .frame(width: 250, height: 100)
                    ZStack {
                        HeartBeat()
                            .stroke(lineWidth: 8)
                            .foregroundColor(Color.colorCardiGray.opacity(0.1))
                        HeartBeat()
                            .trim(from: trimValue1, to: trimValue2)
                            .stroke(lineWidth: 12)
                            .foregroundColor(.colorCardiRed)
                    }
                    .onReceive(timer){ _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }else{
                            self.timer.upstream.connect().cancel()
                            UserDefaults.standard.set("YES", forKey: "WaitForItOverview")
                        }
                    }
                    
                    .frame(height: 300)
                    .animation(.spring())
                    .onReceive(timer, perform: { _ in
                        if trimValue2 == 0 {
                            trimValue2 = 1
                        }
                        else if trimValue1 == 0 {
                            trimValue1 = 1
                        } else {
                            trimValue2 = 0
                            trimValue1 = 0
                        }
                    })
                    
                    Text("getting bits and bytes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .padding(.top, 30.0)
                        .frame(width: 300, height: 30)
                        .scaledToFit()
                        .minimumScaleFactor(0.6)
                }.padding(.top, -50.0)
                
            }.edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        } else {
            NavigationView {
                VStack(spacing: 30){
                    ZStack(alignment: .top) {
                        ZStack(alignment: .leading){
                            let whatStatusImage = defridetailAdminStatusColor
                            switch whatStatusImage {
                            case 0:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 1:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Cardi_Yellow)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 2:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.colorCardiRed)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 3:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Cardi_Yellow)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 4:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.colorCardiRed)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 5:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.colorCardiGray)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            case 6:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Cadri_BLE)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            default:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            }
                            VStack(){
                                HStack(){
                                    if whatStatusImage == 0 || whatStatusImage == 2  || whatStatusImage == 6{
                                        Text(defridetailAdminStatusReason ?? "N/A")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 260, height: 95)
                                            .offset(x: 15, y:10)
                                        
                                    } else {
                                        Text(defridetailAdminStatusReason ?? "N/A")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 260, height: 95)
                                            .offset(x: 15, y:10)
                                    }
                                    NavigationLink(destination: DefibrillatorOverviewSettings(layoutData: $layoutData), isActive: $isShowingDetailView) { EmptyView() }
                                    
                                    Button {
                                        if showMenu == true {
                                            showMenu.toggle()
                                        }
                                        isShowingDetailView = true
                                        UserDefaults.standard.set("Yes", forKey: "SetSelection")
                                        UserDefaults.standard.set("NO", forKey: "DIYBattery")
                                        UserDefaults.standard.set("NO", forKey: "DIYCrucial")
                                        UserDefaults.standard.set("NO", forKey: "DIYMovements")
                                        UserDefaults.standard.set("NO", forKey: "DIYLastSelfTests")
                                        UserDefaults.standard.set("NO", forKey: "DIYServiceTickets")
                                        UserDefaults.standard.set("NO", forKey: "DIYLastMessage")
                                        UserDefaults.standard.set("NO", forKey: "DIYMapInfo")
                                    } label: {
                                        Image(systemName: "gear")
                                            .font(.title)
                                            .foregroundColor(Color.white)
                                            .frame(width: 50, height: 50)
                                            .offset(x: 15, y:-10)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 120)
                        }
                        
                        HStack(spacing: 100){
                            Spacer()
                            
                            VStack {
                                switch currentNavigationCase() {
                                case .aedSearch:
                                    BackButtonView {
                                        navigationManager.navigateTo(.aedsearch)
                                        UserDefaults.standard.set(false, forKey: "NavFromSearch")
                                    }
                                case .dashboard:
                                    BackButtonView {
                                        UserDefaults.standard.set(false, forKey: "NavFromAD")
                                        navigationManager.navigateTo(.dashboard)
                                    }
                                    
                                case .greenAED:
                                    BackButtonView {
                                        UserDefaults.standard.set(false, forKey: "NavFromGreenListView")
                                        navigationManager.navigateTo(.greenAED)
                                    }
                                    
                                case .yellowAED:
                                    BackButtonView {
                                        UserDefaults.standard.set(false, forKey: "NavFromYellowListView")
                                        navigationManager.navigateTo(.yellowAED)
                                    }
                                    
                                case .redAED:
                                    BackButtonView {
                                        UserDefaults.standard.set(false, forKey: "NavFromRedListView")
                                        navigationManager.navigateTo(.redAED)
                                    }
                                    
                                case .blueAED:
                                    BackButtonView {
                                        UserDefaults.standard.set(false, forKey: "NavFromBlueListView")
                                        navigationManager.navigateTo(.blueAED)
                                    }
                                    
                                case .defaultCase:
                                    BackButtonView {
                                        UserDefaults.standard.set("No", forKey: "SetSelection")
                                        UserDefaults.standard.set("NO", forKey: "WaitForItOverview")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailSerial")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailDescription")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailownerName")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailModel")
                                        UserDefaults.standard.set("N/A", forKey: "defidetailpairingSerial")
                                        UserDefaults.standard.set("N/A", forKey: "initialBootupDate")
                                        UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                                        UserDefaults.standard.set("N/A", forKey: "hardwareActicatonDate")
                                        UserDefaults.standard.set("0", forKey: "batteryLevel")
                                        UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                                        UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                                        UserDefaults.standard.set("N/A", forKey: "geoLocationLat")
                                        UserDefaults.standard.set("N/A", forKey: "geoLocationLon")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressStreet")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressNumber")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressFloor")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressPostal")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressCity")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressCountry")
                                        UserDefaults.standard.set("N/A", forKey: "geoAddressComment")
                                        UserDefaults.standard.set("N/A", forKey: "geoFenceType")
                                        UserDefaults.standard.set("N/A", forKey: "geoFenceRadius")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailAdminStatusValue")
                                        UserDefaults.standard.set("N/A", forKey: "defridetailAdminStatusColor")
                                        UserDefaults.standard.set("0", forKey: "commHardwarebatteryPercentage")
                                        UserDefaults.standard.set("", forKey: "OVERVIEWCOMMID")
                                        UserDefaults.standard.set("", forKey: "commdetailID")
                                        UserDefaults.standard.set("", forKey: "defridetailpairingID")
                                        UserDefaults.standard.set("No", forKey: "Moving")
                                        UserDefaults.standard.set("NO", forKey: "WaitForItOverview")
                                        clearAllFileOverview()
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                            Spacer()
                            Spacer()
                        }
                        .offset(x: -40, y: 115)
                    }
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    ScrollView{
                        let _ = print(OverviewSelection as Any)
                        let defaults = UserDefaults.standard
                        let movement = defaults.string(forKey: "Moving")
                        let whatStatusImage = defridetailAdminStatusColor
                        if SetSelection == "Yes" {
                            let defiSelection = layoutData.layoutSelection
                            switch defiSelection {
                            case "Default":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -10.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                SelfTestLatest()
                                    .padding(.bottom, 30.0)
                                Last3Messages()
                                    .padding(.bottom, 10.0)
                                DisplayAddress()
                                    .padding(.bottom, 20.0)
                                DefibrillatorOverviewPhotos()
                                    .environmentObject(imageFetcher)
                                    .padding(.top, 10.0)
                                    .padding(.bottom, 50.0)
                            case "Critical":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                Last3Messages()
                                SelfTestLatest()
                                    .padding(.bottom, 50.0)
                            case "Map":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                DisplayAddress()
                                    .padding(.bottom, 20.0)
                                DefibrillatorOverviewPhotos()
                                    .padding(.top, 10.0)
                                    .environmentObject(imageFetcher)
                                    .padding(.bottom, 40.0)
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, 20.0)
                                SelfTestLatest()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 30.0)
                                Last3Messages()
                                    .padding(.bottom, 1.0)
                                    .padding(.bottom, 50.0)
                            case "Minimum":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                            case "DIY":
                                AEDInfoDrop()
                                    .padding(.horizontal, 20.0)
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYBattery == "YES" {
                                    BatteryStatus()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYCrucial == "YES" {
                                    CrucialInfo()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYMovements == "YES" {
                                    if movement == "Yes" {
                                        MovementsActive()
                                            .padding(.bottom, 20.0)
                                    }
                                }
                                if DIYLastSelfTests == "YES" {
                                    SelfTestLatest()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYLastMessage == "YES" {
                                    Last3Messages()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYMapInfo == "YES" {
                                    if movement == "Yes" {
                                        DisplayAddress()
                                            .padding(.bottom, 20.0)
                                        
                                    } else {
                                        DisplayAddress()
                                            .padding(.top, 20.0)
                                            .padding(.bottom, 20.0)
                                    }
                                }
                            default:
                                AEDInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                CrucialInfo()
                                if movement == "Yes" {
                                    MovementsActive()
                                }
                                SelfTestLatest()
                                Last3Messages()
                                DisplayAddress()
                                DefibrillatorOverviewPhotos()
                                    .environmentObject(imageFetcher)
                                    .padding(.vertical, 20.0)
                            }
                        } else {
                            let defiSelection = OverviewSelection
                            switch defiSelection {
                            case "Default":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -10.0)
                                CrucialInfo()
                                if movement == "Yes" {
                                    MovementsActive()
                                }
                                SelfTestLatest()
                                Last3Messages()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 20.0)
                                DefibrillatorOverviewPhotos()
                                    .padding(.top, 10.0)
                                    .environmentObject(imageFetcher)
                                    .padding(.bottom, 40.0)
                            case "Critical":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                Last3Messages()
                                SelfTestLatest()
                                    .padding(.bottom, 40.0)
                            case "Map":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                DisplayAddress()
                                    .padding(.bottom, 20.0)
                                DefibrillatorOverviewPhotos()
                                    .padding(.top, 10.0)
                                    .environmentObject(imageFetcher)
                                    .padding(.bottom, 40.0)
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, 20.0)
                                SelfTestLatest()
                                    .padding(.bottom, -40.0)
                                CrucialInfo()
                                Last3Messages()
                                    .padding(.bottom, 1.0)
                                    .padding(.bottom, 40.0)
                            case "Minimum":
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.vertical, 20.0)
                            case "DIY":
                                AEDInfoDrop()
                                    .padding(.horizontal, 20.0)
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                        .padding(.bottom, 20.0)
                                }
                                if DIYBattery == "YES" {
                                    BatteryStatus()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYCrucial == "YES" {
                                    CrucialInfo()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYMovements == "YES" {
                                    if movement == "Yes" {
                                        MovementsActive()
                                            .padding(.bottom, 20.0)
                                    }
                                }
                                if DIYLastSelfTests == "YES" {
                                    SelfTestLatest()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYLastMessage == "YES" {
                                    Last3Messages()
                                        .padding(.bottom, 20.0)
                                }
                                if DIYMapInfo == "YES" {
                                    if movement == "Yes" {
                                        DisplayAddress()
                                            .padding(.bottom, 20.0)
                                    } else {
                                        DisplayAddress()
                                            .padding(.top, 20.0)
                                            .padding(.bottom, 20.0)
                                    }
                                }
                            default:
                                AEDInfoDrop()
                                if whatStatusImage == 6{
                                } else {
                                    CommunicatorInfoDrop()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                SelfTestLatest()
                                    .padding(.bottom, 20.0)
                                Last3Messages()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 20.0)
                                DefibrillatorOverviewPhotos()
                                    .padding(.top, 10.0)
                                    .environmentObject(imageFetcher)
                                    .padding(.bottom, 40.0)
                            }
                        }
                    }
                }
                .onAppear {
                    CommGetsingleDataOverview()
                    DefiGetsingleData()
                    getCommhardwaredata()
                    viewModelDevice.checkAvailabilityEmpty()
                    viewModel.checkAvailability()
                    if let value = UserDefaults.standard.object(forKey: "NavFromAD") as? String {
                    } else {
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }.navigationBarHidden(true)
            Spacer()
            VStack {
                BottomNavigationBar()
                    .frame(height: 0)
            } .padding(.top, 40.0)
        }
    }
    
    func currentNavigationCase() -> NavigationCase {
        if UserDefaults.standard.bool(forKey: "NavFromSearch") {
            return .aedSearch
        } else if UserDefaults.standard.bool(forKey: "NavFromAD") {
            return .dashboard
        } else if UserDefaults.standard.bool(forKey: "NavFromGreenListView") {
            return .greenAED
        } else if UserDefaults.standard.bool(forKey: "NavFromYellowListView") {
            return .yellowAED
        } else if UserDefaults.standard.bool(forKey: "NavFromRedListView") {
            return .redAED
        } else if UserDefaults.standard.bool(forKey: "NavFromBlueListView") {
            return .blueAED
        }
        else {
            return .dashboard
        }
    }
    struct BackButtonView: View {
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .frame(width: 40.0, height: 40.0)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(50)
                        .offset(x: -25, y: 0)
                }
            }
        }
    }
}
struct AEDInfoDrop: View{
    
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    @State private var showButtons = false
    @State private var dropdown = false
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 325, height: 70)
                ZStack(){
                    Button(action: { withAnimation {
                        dropdown.toggle()
                    } }) {
                        Image(systemName: "chevron.down")
                            .font(.title)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .padding(showButtons ? 15.0 : 15.0)
                            .rotationEffect(Angle.degrees(dropdown ? 180 : 0))
                    }
                    .background(Circle().fill(Color.Cardi_Text))
                    .offset(x: 210, y: -25)
                    .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
                }  .offset(x: 65)
                HStack(){
                    HStack(spacing: -20){
                        Image(systemName: "bolt.heart.fill")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .padding(10.0)
                        Image(systemName: "link")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                    }
                    VStack(alignment: .leading){
                        Text("AED")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                        if #available(iOS 15.0, *) {
                            Text("\(defridetailSerial ?? "Unknown AED")")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .textSelection(.enabled)
                        } else {
                            Text("\(defridetailSerial ?? "Unknown AED")")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            }.padding(.top, 20.0)
            
            if dropdown {
                DefibrillatorInfoFull()
                    .padding(.bottom, 10.0)
            }
        }
    }
}
struct DefibrillatorInfoFull: View{
    
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    @AppStorage("defridetailModel") var defridetailModel: String?
    @AppStorage("firmwarePCB") var firmwarePCB: String?
    @AppStorage("hardwareActicatonDate") var hardwareActicatonDate: String?
    @State private var showButtons = false
    @State private var showMenu = false
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    var body: some View {
        NavigationLink(destination: AED_Detailed()) {
            ZStack(alignment: .leading){
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                        .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                        .frame(width: 325, height: 320)
                    HStack(){
                        VStack(){
                            HStack(spacing: 14){
                                Text("Model:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 8)
                                Spacer()
                                Text("\(defridetailModel ?? "Unknown Model")")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing, 25)
                            }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                            HStack(spacing: 5){
                                Text("Owner:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 8)
                                Spacer()
                                Text("\(defridetailownerName ?? "N/A")")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing, 25)
                            } .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80, alignment: .trailing)
                            HStack(spacing: 5){
                                Text("Description:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 8)
                                Spacer()
                                Text("\(defridetailDescription ?? "N/A")")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing, 25)
                            }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 80, alignment: .trailing)
                            HStack(spacing: 5){
                                Text("Firmware:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 8)
                                Spacer()
                                Text(firmwarePCB ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing, 25)
                            }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 20, alignment: .trailing)
                            HStack(spacing: 5){
                                Text("Active since:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 8)
                                Spacer()
                                Text(hardwareActicatonDate ?? "N/A")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing, 25)
                            }.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 60, alignment: .trailing)
                        }
                        .offset(x: 25)
                    }
                    .padding()
                }  .offset(x: 0, y:15)
            }
        }.simultaneousGesture(TapGesture().onEnded{
            
        })
    }
}
struct CommunicatorInfoDrop: View{
    
    @State private var showButtons = false
    @State private var dropdownComm = false
    @AppStorage("defidetailpairingSerial") var commdetailSerial: String?
    @AppStorage("commdetailpairingDate") var initialBootupDate: String?
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 325, height: 70)
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
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .padding(10.0)
                        Image(systemName: "link")
                            .font(.title2)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.Cardi_Text_Inf)
                    }
                    VStack(alignment: .leading){
                        Text("Heart Connect")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .fontWeight(.semibold)
                        if #available(iOS 15.0, *) {
                            Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .textSelection(.enabled)
                        } else {
                            Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                }
            }.padding(.top, 20.0)
            if dropdownComm {
                VStack(){
                    NavigationLink(destination: CommDetailed()) {
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.Cardi_Text)
                                .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                .frame(width: 325, height: 70)
                            HStack(spacing: 5){
                                Text("Since:")
                                    .font(.headline)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                    .fontWeight(.semibold)
                                if initialBootupDate == "N/A" ||  initialBootupDate == "Jan 1, 1970" {
                                    SwiftUI.Text("N/A")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                } else {
                                    Text("\(initialBootupDate ?? "..")")
                                        .font(.headline)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }.frame(minWidth: 0, maxWidth: 320, minHeight: 0, maxHeight: 60)
                                .offset(x: 15)
                        }
                    }.simultaneousGesture(TapGesture().onEnded{
                        CommGetsingleData()
                    })
                }
                .padding(.top, 10.0)
            }
        }.offset(x: 0)
    }
}
enum NavigationCase {
    case aedSearch
    case dashboard
    case greenAED
    case yellowAED
    case redAED
    case blueAED
    case defaultCase
}











