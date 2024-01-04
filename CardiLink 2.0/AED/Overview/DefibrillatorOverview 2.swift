//
//  DefibrillatorOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 28.07.22.
//

import SwiftUI

struct DefibrillatorOverview: View {
    
    @State private var change = false
    @State private var showMenu = false
    @State private var showButtons = false
    
    @State var defiSelection: String = ""
    
    
    //    @AppStorage("MovingLoadingDone") var doneWork: String!
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
    
    
    //    @AppStorage("defridetailAdminStatusValue") var defridetailAdminStatusValue: String?
    @AppStorage("defridetailAdminStatusReason") var defridetailAdminStatusReason: String?
    @AppStorage("defridetailAdminStatusColor") var defridetailAdminStatusColor: Int?
    
    @Environment(\.presentationMode) var presentationMode
    @State var layoutData = SelectedData(layoutSelection: "Default")
    @State private var isShowingDetailView = false
    
    @AppStorage("WaitForItOverview") var doneWork: String!
    @State var trimValue1 : CGFloat = 0
    @State var trimValue2 : CGFloat = 0
    
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
//                        .minimumScaleFactor(0.1)
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
                            default:
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                                    .frame(maxWidth: .infinity, maxHeight: 140)
                            }
                            
                            
                            VStack(){
                                HStack(){
                                    
                                    if whatStatusImage == 0 || whatStatusImage == 2  || whatStatusImage == 4{
                                        
                                        Text(defridetailAdminStatusReason ?? "N/A")
                                        //                            Text("AED electrode pads are expired: AED Electrode expiration date is within one month")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 260, height: 95)
                                            .offset(x: 15, y:10)
                                        
                                    } else {
                                        
                                        Text(defridetailAdminStatusReason ?? "N/A")
                                        //                            Text("AED electrode pads are expired: AED Electrode expiration date is within one month")
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
                                        
                                        
                                        print("Edit button was tapped")
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
                            Button(action:{ self.presentationMode.wrappedValue.dismiss()
                                UserDefaults.standard.set("No", forKey: "SetSelection")
                                UserDefaults.standard.set("NO", forKey: "WaitForItOverview")
                                
                                //firmaware *Defi-
                                UserDefaults.standard.set("N/A", forKey: "defridetailSerial")
                                UserDefaults.standard.set("N/A", forKey: "defridetailDescription")
                                UserDefaults.standard.set("N/A", forKey: "defridetailownerName")
                                UserDefaults.standard.set("N/A", forKey: "defridetailModel")
                                
                                //firmaware *Defi-Comm Connection
                                UserDefaults.standard.set("N/A", forKey: "defidetailpairingSerial")
                                
                                
                                //                            initialBootupDate
                                UserDefaults.standard.set("N/A", forKey: "initialBootupDate")
                                
                                //firmaware *Defi-Hardware
                                UserDefaults.standard.set("N/A", forKey: "firmwarePCB")
                                UserDefaults.standard.set("N/A", forKey: "hardwareActicatonDate")
                                
                                //Battery level/expiration *Defi-Hardware
                                UserDefaults.standard.set("N/A", forKey: "batteryLevel")
                                UserDefaults.standard.set("N/A", forKey: "activationsDateBattery")
                                
                                //electrodes *Defi-Hardware
                                UserDefaults.standard.set("N/A", forKey: "experationDateElectrodes")
                                
                                //location-
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
                                
                                
                                
                                UserDefaults.standard.set("N/A", forKey: "commHardwarebatteryPercentage")
                                UserDefaults.standard.set("N/A", forKey: "defridetailpairingID")
                                
                                UserDefaults.standard.set("No", forKey: "Moving")
                                
                                
                                let fileManager = FileManager.default
                                let filename3 = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
                                
                                do {
                                    try fileManager.removeItem(at: filename3)
                                } catch {
                                    
                                    return
                                }
                                
                                
                                let selftestAll = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
                                
                                do {
                                    try fileManager.removeItem(at: selftestAll)
                                } catch {
                                    
                                    return
                                }
                                
                                let filenameAll = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
                                
                                do {
                                    try fileManager.removeItem(at: filenameAll)
                                } catch {
                                    
                                    return
                                }
                                
                                let filenameMove = getDocumentsDiretory().appendingPathComponent("Movelatlon.json")
                                
                                do {
                                    try fileManager.removeItem(at: filenameMove)
                                } catch {
                                    
                                    return
                                }
                                
                                
                            }){
                                
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .background(Color.white)
                                    .cornerRadius(50)
                                    .opacity(showButtons ? 0 : 1)
                                    .offset(x: -25, y:0)
                                
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
                        
                        if SetSelection == "Yes" {
                            let defiSelection = layoutData.layoutSelection
                            
                            switch defiSelection {
                            case "Default":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                    .padding(.bottom, -10.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                
                                
                                SelfTestLatest()
                                //                                ServiceTickets()
                                    .padding(.bottom, 30.0)
                                Last3Messages()
                                    .padding(.bottom, 10.0)
                                DisplayAddress()
                                    .padding(.bottom, 50.0)
                                //                            .padding(.vertical, 20.0)
                            case "Critical":
                                DefibrillatorInfoDrop()
                                //                                    .padding(.leading, -20.0)
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                if movement == "Yes" {
                                    MovementsActive()
                                        .padding(.bottom, 20.0)
                                }
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                //                                    .padding(.bottom, 20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                                Last3Messages()
                                SelfTestLatest()
                                    .padding(.bottom, 50.0)
                                //                            .padding(.vertical, 20.0)
                            case "Map":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 40.0)
                                //                            .padding(.bottom, 220.0)
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
                                //                            ServiceTickets()
                                    .padding(.bottom, 50.0)
                            case "Minimum":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.bottom, 20.0)
                            case "DIY":
                                DefibrillatorInfoDrop()
                                    .padding(.horizontal, 20.0)
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                    .padding(.horizontal, 20.0)
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
                                
                                if DIYServiceTickets == "YES" {
                                    ServiceTickets()
                                        .padding(.bottom, 20.0)
                                }
                                
                                if DIYLastMessage == "YES" {
                                    Last3Messages()
                                        .padding(.bottom, 20.0)
                                }
                                
                                if DIYMapInfo == "YES" {
                                    if movement == "Yes" {
                                        DisplayAddress()
                                            .padding(.bottom, 40.0)
                                        
                                    } else {
                                        DisplayAddress()
                                            .padding(.top, 20.0)
                                            .padding(.bottom, 40.0)
                                    }
                                }
                                
                                
                            default:
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                CrucialInfo()
                                if movement == "Yes" {
                                    MovementsActive()
                                }
                                SelfTestLatest()
                                //                            ServiceTickets()
                                Last3Messages()
                                DisplayAddress()
                                    .padding(.vertical, 20.0)
                            }
                        } else {
                            
                            let defiSelection = OverviewSelection
                            
                            switch defiSelection {
                            case "Default":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                    .padding(.bottom, -10.0)
                                CrucialInfo()
                                if movement == "Yes" {
                                    MovementsActive()
                                }
                                SelfTestLatest()
                                //                                ServiceTickets()
                                Last3Messages()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 40.0)
                                //                            .padding(.vertical, 20.0)
                            case "Critical":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
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
                                //                            .padding(.vertical, 20.0)
                            case "Map":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 40.0)
                                //                            .padding(.bottom, 220.0)
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
                                //                                ServiceTickets()
                                    .padding(.bottom, 40.0)
                            case "Minimum":
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
                                BatteryStatus()
                                    .padding(.bottom, -20.0)
                                CrucialInfo()
                                    .padding(.vertical, 20.0)
                            case "DIY":
                                DefibrillatorInfoDrop()
                                    .padding(.horizontal, 20.0)
                                CommunicatorInfoDrop()
                                    .padding(.horizontal, 20.0)
                                    .padding(.bottom, 20.0)
                                
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
                                
                                //                                if DIYServiceTickets == "YES" {
                                //                                    ServiceTickets()
                                //                                        .padding(.bottom, 20.0)
                                //                                }
                                
                                if DIYLastMessage == "YES" {
                                    Last3Messages()
                                        .padding(.bottom, 20.0)
                                }
                                
                                if DIYMapInfo == "YES" {
                                    
                                    if movement == "Yes" {
                                        DisplayAddress()
                                        
                                            .padding(.bottom, 40.0)
                                        
                                    } else {
                                        DisplayAddress()
                                            .padding(.top, 20.0)
                                            .padding(.bottom, 40.0)
                                    }
                                }
                                
                            default:
                                DefibrillatorInfoDrop()
                                CommunicatorInfoDrop()
                                    .padding(.bottom, 20.0)
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
                                //                              ServiceTickets()
                                //                                    .padding(.bottom, 20.0)
                                Last3Messages()
                                    .padding(.bottom, 20.0)
                                DisplayAddress()
                                    .padding(.bottom, 40.0)
                                
                            }
                            
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }.navigationBarHidden(true)
            
        }
        
    }
}

//MARK: SWITCH

struct DefibrillatorOverview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
//            DefibrillatorOverview()
//                .previewDevice("iPhone SE (1st generation)")
//            DefibrillatorOverview()
//                        .previewDevice("iPhone 12 mini")
            DefibrillatorOverview()
                .previewDevice("iPhone 13 Pro Max")
                .preferredColorScheme(.light)
        }
        
    }
}

//MARK: DEFIDROP
struct DefibrillatorInfoDrop: View{
    
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    @State private var showButtons = false
    //    @Environment(\.presentationMode) var presentationMode
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
                            // Fallback on earlier versions
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

//MARK: DEFIFULL
struct DefibrillatorInfoFull: View{
    
    //    @AppStorage("defridetailID") var defridetailID: String?
    //    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    //    @AppStorage("defridetailSerial") var defridetailSerial: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    
    @AppStorage("defridetailModel") var defridetailModel: String?
    @AppStorage("firmwarePCB") var firmwarePCB: String?
    @AppStorage("hardwareActicatonDate") var hardwareActicatonDate: String?
    
    @State private var showButtons = false
    //    @Environment(\.presentationMode) var presentationMode
    @State private var showMenu = false
    
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        NavigationLink(destination: DefibrillatorDetailed()) {
            ZStack(alignment: .leading){
                
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.Cardi_Text)
                    //                    .opacity(0.4)
                    //                    .padding(.leading, 120.0)
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
                                //                        Text("AED-1234567890")
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
                                
                                //                        Text("Fri, December 17, 2021 01:20 PM")
                                
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
                    .padding(.top, 10.0)
                    //            }
                }  .offset(x: 0, y:15)
            }
        }.simultaneousGesture(TapGesture().onEnded{
            
        })
    }
}


//MARK: COMMDROP
struct CommunicatorInfoDrop: View{
    @State private var showButtons = false
    //    @Environment(\.presentationMode) var presentationMode
    @State private var dropdownComm = false
    @AppStorage("defidetailpairingSerial") var commdetailSerial: String?
    //    @AppStorage("initialBootupDate") var initialBootupDate: String?
    @AppStorage("commdetailpairingDate") var initialBootupDate: String?
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                //                    .opacity(0.4)
                //                    .padding(.leading, 120.0)
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
                                Text("Connected since:")
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
                        //                        UserDefaults.standard.set(commText, forKey: "SelectedComm")
                        CommGetsingleData()
                        //                        UIApplication.shared.endEditing()
                    })
                }
                .padding(.top, 10.0)
            }
        }.offset(x: 0)
    }
}















