//
//  CommDetailed.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI

struct CommDetailed: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var selection: Int? = nil
    
    @State private var show = false
    @State private var change = false
    
    @State private var showButtons = false
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        ZStack(alignment: .top){
            MainBackground()
            VStack(){
                ScrollView() {
                    //MARK: MENU
                    ZStack(){
                        
                        ScrollView(showsIndicators: true) {
        
        
                            let defaults = UserDefaults.standard
                            let backend = defaults.string(forKey: "Backend")
                            
                            if backend == "NEW" {
                                
                                comMainInfo()
                                    .padding(.top, 40.0)
                                
                                comPairedSingleNK()
                                comInitalBootDate()
                                
                                comdescriptionSingle()
                                compairedWithSingle()
                                    .padding(.bottom, 60.0)
                                Spacer()
                            } else {
                                
                                
                                comMainInfo()
                                    .padding(.top, 40.0)
                                
                                comStatusSingle()
                                comadminStatusSingle()
                                comownerSingle()
                                comdescriptionSingle()
                                compairedWithSingle()
                                    .padding(.bottom, 60.0)
                                Spacer()
                            }
                        }
                        
                    }
                }
                .padding(.top, 100.0)
            }
            CommunicatorMenu()
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }

}
        
struct CommDetailed_Previews: PreviewProvider {
    static var previews: some View {
        CommDetailed()
    }
}

//MARK: comMainInfo
struct comMainInfo: View {
    
    @AppStorage("commdetailID") var commdetailID: String?
    @AppStorage("commdetailOwner") var commdetailOwner: String?
    @AppStorage("commdetailDescription") var commdetailDescription: String?
    @AppStorage("commdetailSerial") var commdetailSerial: String?
    @AppStorage("commdetailOwnername") var commdetailOwnername: String?
    
    
    var body: some View {
        ZStack(){
            
            let _ = print("POOP:",commdetailID!)
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 170)
            
            VStack(alignment: .leading){
                
                let defaults = UserDefaults.standard
                let backend = defaults.string(forKey: "Backend")
                if backend == "NEW" {
                    
                    if #available(iOS 15.0, *) {
                        Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                    } else {
                        Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("\(commdetailOwnername ?? "Please try again")")
                        .fontWeight(.medium)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    
                } else {
                    
                    Text("\(commdetailID ?? "Unknown Heart Connect")")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(commdetailOwner ?? "Please try again")")
                        .fontWeight(.medium)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
                
                
                
                
                Text("\(commdetailDescription ?? "")")
                    .fontWeight(.light)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
            }.frame(width: 300, height: 150)
                .padding(.horizontal)
        }.padding(.horizontal, 25.0)
    }
}
        
//MARK: comStatusSingle
struct comStatusSingle: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    @AppStorage("commstatusImage") var commstatusColor: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "N/A")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    Image(commstatusColor ?? "..")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}


//MARK: comPairedSingleNK
struct comPairedSingleNK: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "N/A")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    
                    let whatStatusImage = commdetailStatusValue
                    
                    switch whatStatusImage {
                    case "Operational":
                        Image("comms_green")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    case "Defective":
                        Image("comms_orange")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                        
                    case "Disabled":
                        Image("comms_red")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                        
                    default:
                        Image("Comms")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    }
                    
                    
                    
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}


//MARK: comPairedSingle
struct comPairedSingle: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    @AppStorage("commstatusImage") var commstatusColor: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "available")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    Image(commstatusColor ?? "..")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}
//MARK: comadminStatusSingle
struct comadminStatusSingle: View {
    
    @AppStorage("commdetailAdminStatusValue") var commdetailAdminStatusValue: String?
    
    //    Initial Bootup Date
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Administration Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)
                    
                    
                    
                    let newoneText = commdetailAdminStatusValue
                    
                    switch newoneText {
                    case "Operational":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.Calming_Green)
                            .multilineTextAlignment(.trailing)
                    case "Defective":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.colorCardiRed)
                            .multilineTextAlignment(.trailing)
                    case "Monitored":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.Calming_Green)
                            .multilineTextAlignment(.trailing)
                    case "Disabled":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.colorCardiRed)
                            .multilineTextAlignment(.trailing)
                    default:
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    //                    Text("\(commdetailAdminStatusValue ?? "..")")
                    //                        .fontWeight(.regular)
                    //                        .font(.body)
                    //                        .foregroundColor(Color.Calming_Green)
                    //                        .multilineTextAlignment(.trailing)
                    
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

//MARK: comInitalBootDate
struct comInitalBootDate: View {
    
    @AppStorage("initialBootupDate") var initialBootupDate: String?
    
    //    Initial Bootup Date
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Initial Bootup Date:")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)

                    if initialBootupDate == "N/A" ||  initialBootupDate == "Jan 1, 1970" {
                        SwiftUI.Text("N/A")
                            .fontWeight(.regular)
                            .font(.body)
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 15.0)
                        
                    } else {
                    Text("\(initialBootupDate ?? "..")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.Calming_Green)
                        .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

//MARK: comownerSingle
struct comownerSingle: View {
    
    @AppStorage("commdetailOwner") var commdetailOwner: String?
    @AppStorage("commdetailOwnername") var commdetailOwnername: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Owner")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)
                    
                    let defaults = UserDefaults.standard
                    let backend = defaults.string(forKey: "Backend")
                    
                    if backend == "NEW" {
                        Text("\(commdetailOwnername ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                        
                    } else {
                        Text("\(commdetailOwner ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

//MARK: comdescriptionSingle
struct comdescriptionSingle: View {
    
    @AppStorage("commdetailDescription") var commdetailDescription: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Description") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                SwiftUI.Text("\(commdetailDescription ?? "..")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }
        .padding(.top)
        .frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
        
    }
}

//MARK: compairedWithSingle
struct compairedWithSingle: View {
    
    @AppStorage("commdetailpairingDate") var commdetailpairingDate: String?
    @AppStorage("commdetailpairingID") var commdetailpairingID: String?
    //    @AppStorage("commdetailSerial") var commdetailSerial: String?
    @AppStorage("commdetailpairingSerial") var commdetailpairingSerial: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Paired with") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                SwiftUI.Text("AED")
                                
                                let defaults = UserDefaults.standard
                                
                                let backend = defaults.string(forKey: "Backend")
                                
                                if backend == "NEW" {
                                    
                                    if commdetailpairingID == "" || commdetailpairingID == "null" || commdetailpairingID == nil {
                                        SwiftUI.Text("N/A")
                                            .fontWeight(.regular)
                                            .font(.body)
                                            .multilineTextAlignment(.trailing)
                                            .padding(.leading, 15.0)
                                        
                                    } else {
                                        
                                        NavigationLink(destination: DefibrillatorDetailed()) {
                                            SwiftUI.Text("\(commdetailpairingSerial ?? "..")")
                                                .fontWeight(.regular)
                                                .font(.body)
                                                .multilineTextAlignment(.trailing)
                                                .padding(.leading, 15.0)
                                        }
                                    }
                                    
                                } else {
                                    
                                    if commdetailpairingID == "N/A" {
                                        SwiftUI.Text("\(commdetailpairingID ?? "..")")
                                            .fontWeight(.regular)
                                            .font(.body)
                                            .multilineTextAlignment(.trailing)
                                            .padding(.leading, 15.0)
                                        
                                    } else {
                                        
                                        NavigationLink(destination: DefibrillatorDetailed()) {
                                            SwiftUI.Text("\(commdetailpairingID ?? "..")")
                                                .fontWeight(.regular)
                                                .font(.body)
                                                .multilineTextAlignment(.trailing)
                                                .padding(.leading, 15.0)
                                        }
                                    }
                                }
                                
                            }.simultaneousGesture(TapGesture().onEnded{
                                UserDefaults.standard.set(commdetailpairingID, forKey: "SelectedDefi")
                                
                                let defaults = UserDefaults.standard
                                let backend = defaults.string(forKey: "Backend")
                                
                                if backend == "NEW" {
                                    
                                    //MARK: NEW
                                    getNKMessagesData()
                                    DefiGetsingleData()
                                    
                                } else {
                                    DefiGetsingleData()
                                    
                                }
                                
                            })
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){

                            let defaults = UserDefaults.standard
                            let backend = defaults.string(forKey: "Backend")
                            
                            if backend == "NEW" {
//                                let _  = print(commdetailpairingDate)
                                Image(systemName: "calendar.badge.clock")
                                if commdetailpairingDate == "N/A" ||  commdetailpairingDate == "Jan 1, 1970 2:00 AM" {
                                    
                                    SwiftUI.Text("since")
                                    SwiftUI.Text("N/A")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                    
                                } else {
                                    
                                    
                                    
                                    
                                    SwiftUI.Text("since")
                                    SwiftUI.Text("\(commdetailpairingDate ?? "..")")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                }
                                
                                
                                
                            }else {
                                
                                
                                Image(systemName: "calendar.badge.clock")
                                if commdetailpairingDate == "N/A" {
                                    
                                    SwiftUI.Text("since")
                                    SwiftUI.Text("N/A")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                    
                                } else {
                                    
                                    let zerofinalDate = commdetailpairingDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM d, yyyy h:mm a")
                                    
                                    
                                    
                                    SwiftUI.Text("since")
                                    SwiftUI.Text("\(zerofinalDate ?? "..")")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                }
                            }
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.padding(.top, 20.0)
        .frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

        
struct CommunicatorMenu: View {
    @State private var showButtons = false
    @Environment(\.presentationMode) var presentationMode
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
    
        ZStack() {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    .opacity(showButtons ? 0.9 : 0)
                    .shadow(color: Color.Cardi_Text, radius: 5, y: 5)
                
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
            
        }
        
        HStack(spacing: 40){
                Button(action:{ self.presentationMode.wrappedValue.dismiss()
                        
                        UserDefaults.standard.set("Unknown Heart Connect", forKey: "commdetailOwner")
                        UserDefaults.standard.set("Please try again", forKey: "commdetailID")
                        UserDefaults.standard.set("Make sure you have Internet connection" ,forKey: "commdetailDescription")
                        UserDefaults.standard.set("", forKey: "commdetailStatusValue")
                        UserDefaults.standard.set("", forKey: "commdetailAdminStatusValue")
                        UserDefaults.standard.set("", forKey: "commdetailpairingDate")
                        UserDefaults.standard.set("", forKey: "commdetailpairingID")
                        UserDefaults.standard.set("", forKey: "SelectedComm")
                    }){
                        
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(50)
                            .opacity(showButtons ? 0 : 1)
                        
                    }
                    //                        .padding(.leading, 100.0)
                    Text("Heart Connects")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding(10)
                        .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                        .frame(width: 190, height: 30)
                        .padding(.trailing, -30)
                        .opacity(showButtons ? 0 : 1)
//                        .scaledToFit()
                        .minimumScaleFactor(0.8)

                    
            HStack(){
                ZStack(alignment: .topTrailing) {

                    Group {
                        //MARK: Hardware
                        Button(action:
                                { self.showButtons.toggle() }) {
                            NavigationLink(destination: CommHardware()) {
                                VStack(){
                                    Image(systemName: "server.rack")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("Hardware")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                getCommhardwaredata()
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: showButtons ? -130 : 0, y: 10)
                                .opacity(showButtons ? 1 : 0)
                        
                        
                        //MARK: SIM Card
                        Button(action:
                                { self.showButtons.toggle() }) {
                            
                            NavigationLink(destination: CommSimCard()) {
                                VStack(){
                                    Image(systemName: "simcard")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("SIM Card")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                                                    let defaults = UserDefaults.standard
                                                                    let backend = defaults.string(forKey: "Backend")
                                
                                                                    if backend == "NEW" {
                                                                        getSIMcardData()
                                                                    }else {
                                
                                                                        getCommSimdata()
                                                                    }
                            })
                            }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .font(.headline)
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? -240 : 0, y: showButtons ? 130 : 0)
//                    }
                    
                    
                    //MARK: Service tickets
                    Button(action:
                            { self.showButtons.toggle() }) {
                        
                        
                        let defaults = UserDefaults.standard
                        let backend = defaults.string(forKey: "Backend")
                        
                        if backend == "NEW" {

//                        NavigationLink(destination: ServiceTicketsComms()) {
//                            VStack(){
//                                Image(systemName: "ticket")
//                                    .foregroundColor(Color.colorCardiOrange)
//                                    .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
//                                Text("Service")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.colorCardiOrange)
//                                Text("tickets")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.colorCardiOrange)
//                                
//                            }.padding(showButtons ? 20.0 : 0)
//                            
//                        }
                        } else {
                            
                            NavigationLink(destination: ServiceTicketsComms()) {
                                VStack(){
                                    Image(systemName: "ticket")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                                    Text("Service")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    Text("tickets")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 20.0 : 0)
                            }
                            
                    }
                    }
                            .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                            .font(.headline)
                            .opacity(showButtons ? 1 : 0)
                            .offset(x: showButtons ? -140 : 0, y: showButtons ? 240 : 0)

                    
                    //MARK: Messages
                    Button(action:
                            { self.showButtons.toggle() }) {
                        
                        
                        let defaults = UserDefaults.standard
                        let backend = defaults.string(forKey: "Backend")
                        
                        if backend == "NEW" {
                            
                            NavigationLink(destination: MessagesMainMenuCommNK()) {
                                VStack(){
                                    Image(systemName: "message")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                                    Text("Messages")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            }
                        } else {
                            
                            NavigationLink(destination: MessagesMainMenu()) {
                                VStack(){
                                    Image(systemName: "envelope.open")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                                    Text("Messages")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            } .simultaneousGesture(TapGesture().onEnded{
                                let defaults = UserDefaults.standard
                                defaults.set("communicators/", forKey: "DefiComm")
                                defaults.set("NO", forKey: "activeMap")
                                defaults.set("YES", forKey: "messageload")
                            })

                        }
                        
                    }
                            .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                            .offset(x: -30, y: showButtons ? 100 : 0) // No
                            .opacity(showButtons ? 1 : 0)
                    
//                    //MARK: Home
//                    let places = MapDirectory().places
//                    Button(action:
//                            { self.showButtons.toggle() }) {
//                        NavigationLink(destination: Dashboard(places: places)) {
//                            VStack(){
//                                Image(systemName: "house.circle")
//                                    .foregroundColor(Color.colorCardiOrange)
//                                    .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
//                                Text("Home")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.colorCardiOrange)
//                            }.padding(showButtons ? 20.0 : 0)
//                        }
//                    }
//                            .background(Circle().fill(Color.white)
//                            .shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
//                            .offset(x: showButtons ? -280 : 0, y: 20)
//                            .opacity(showButtons ? 1 : 0)
                    
                        //MARK: MAIN
                        Button(action: { self.showButtons.toggle() }) {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .padding(showButtons ? 15.0 : 15.0)
                                .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                            
                        }
                        .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                        .offset(x: showButtons ? -50 : 0, y: showButtons ? 15 : 0)
                    }
                    .accentColor(.white)
                    .animation(.default)
                
            }
        }
    }
        .padding(.top, 40.0)
        .padding(.bottom, 30)
}
        
}
        
        
       




