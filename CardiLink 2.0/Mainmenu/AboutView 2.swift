//
//  AboutView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import MapKit

struct AboutView: View {
    @State var selection: Int? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(){
            
            
            ZStack(){
                
                MainBackground()
                    .padding(.top, 220.0)
                    
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    
                    HStack(spacing: 10){
                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
                            
                            //                            UserDefaults.standard.set("Unknown AED", forKey: "defridetailOwner")
                            //                            UserDefaults.standard.set("Please try again", forKey: "defridetailID")
                            //                            UserDefaults.standard.set("Make sure you have Internet connection" ,forKey: "defridetailDescription")
                            //                            UserDefaults.standard.set("", forKey: "defridetailStatusValue")
                            //                            UserDefaults.standard.set("", forKey: "defridetailAdminStatusValue")
                            //                            UserDefaults.standard.set("", forKey: "defridetailpairingDate")
                            //                            UserDefaults.standard.set("", forKey: "defridetailpairingID")
                            //
                            //
                            //
                            
                        }){
                            
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
//                                .padding(.leading, 130)
                        }
//                        .padding(.leading, 110.0)
                        Text("About & User Info")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 50.0)
                    }
                    .padding(.top, 20.0)
                    .frame(width: 350, height: 70)
                }
            }
            .frame(width: 450, height: 120)
            
            ZStack(){
                
                ScrollView {
                    aboutSection()
                        .padding(.top, 10.0)
                    userData()
                        .padding(.top, 20.0)
                    settingsInfo()
                        .padding(.top, 20.0)
                    licenseData()
                        .padding(.top, 20.0)
//                    versionData()
//                        .padding(.top, 20.0)
                    ZStack(){
                    
                    Image("CardiLink-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 20.0)
                        .frame(width: 250, height: 200)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(){
                            Text("\(Bundle.main.appVersionShort!) \(Bundle.main.appVersionLong!)")
                                .fontWeight(.regular)
                                .font(.body)
                                .foregroundColor(Color.Calming_Green)
                                .padding(.leading, -120.0)
                                .padding(.top, 140.0)
//                                .multilineTextAlignment(.trailing)
                            
                        }//.frame(width: 230, height: 60)
                    }
                    }
                    Spacer()
                }
                
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}



// MARK: ABOUT
struct aboutSection: View {
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.468121, longitude: 11.000527),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    var body: some View {
        ZStack(){
            
            Image("GS28")
                
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 150)
                .cornerRadius(25)
                .shadow(radius: 5, y: 5)
            
            VStack(alignment: .leading){
                
                Text("CardiLink GmbH")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                Text("Gebhardtstraße 28")
                    .fontWeight(.light)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                Text("6. OG OST ")
                    .fontWeight(.light)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                Text("90762 Fürth, Germany")
                    .fontWeight(.light)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                
            }.frame(width: 300, height: 150)
            
            .padding(.horizontal)
            
            
        }.padding(25.0)
    }
}

// MARK: USERDATA
struct userData: View {
    
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    @State private var emailAddress = ""
    @State private var userid = ""
    @State private var username = ""
    @State private var landline = ""
    @State private var mobileline = ""
    @State private var telegram = ""
    @State private var homepage = ""
    @State private var description = ""
    
    @AppStorage("userOwner") var userOwner: String?
    @AppStorage("userID") var userID: String?
    @AppStorage("userEmail") var userMail: String?
    @AppStorage("userDescription") var userDescription: String?
    @AppStorage("userTelephone") var userTelephone: String?
    @AppStorage("usermobilePhone") var usermobilePhone: String?
    @AppStorage("usertelegram") var usermobileTelegram: String?
    @AppStorage("userhomepage") var userhomepage: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("User Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Login:")
                            HStack(){
                                Image(systemName: "person.crop.circle")//.foregroundColor(.colorCardiGray)
                                SwiftUI.Text(userID ?? "")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Name:")
                        HStack(){
                            Image(systemName: "person")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(userOwner ?? "")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("E-Mail Address:")
                        HStack(){
                            Image(systemName: "envelope")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(userMail ?? "")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Telephone:")
                        HStack(){
                            Image(systemName: "phone")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(userTelephone ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile phone:")
                        HStack(){
                            Image(systemName: "iphone")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(usermobilePhone ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Telegram:")
                        HStack(){
                            Image(systemName: "megaphone")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(usermobileTelegram ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Homepage:")
                        HStack(){
                            Image(systemName: "network")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(userhomepage ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Description:")
                        HStack(){
                            Image(systemName: "doc.plaintext")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(userDescription ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

// MARK: LICENSEDATA
struct licenseData: View {
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("License Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            HStack(){
                                Image(systemName: "lock.shield")//.foregroundColor(.colorCardiGray)
                                
                                Button("Privacy statement") {
                                    self.presentingSheet = true
                                    
                                }
                                .sheet(isPresented: $presentingSheet) {
                                    ModalView(model: model, title: "Privacy statement")
                                }
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Package Dependencies:")
                        Divider().opacity(0)
                        HStack(){
                            Image(systemName: "shippingbox")//.foregroundColor(.colorCardiGray)
                            Text("Alamofire")
                        }
                        
                        Divider().opacity(0)
                        
                        HStack(){
                            Image(systemName: "shippingbox")//.foregroundColor(.colorCardiGray)
                            Text("SwiftyJSON")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct settingsInfo: View {
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
//    @AppStorage("currentPage") var currentPage = 1
    
    @AppStorage("mapOnboarding") var isToggleOn = false
    let defaults = UserDefaults.standard
    @State private var isOn = true
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Settings") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            HStack(){

                                
                                    Image(systemName: "map")
//                                Toggle(isOn: $isOn) { Text("Map Onboarding")}
                                Toggle("New map introduction", isOn: $isToggleOn)
                                
                                
                                    .onChange(of: isToggleOn) { value in
                                        print(value)
                                        
                                        if value == false {
                                            defaults.set("NO", forKey: "mapOnboarding")
                                        } else {
                                            
                                            defaults.set("YES", forKey: "mapOnboarding")
                                            defaults.set(1, forKey: "currentPage")
//                                            @AppStorage("currentPage") var currentPage = 1
                                        }
                                        
                                    }//.foregroundColor(Color.black)
                                    .toggleStyle(SwitchToggleStyle(tint: Color.colorCardiOrange))
                                
                                
//                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
//                                    .padding(.bottom, 10)
                            }
                            Divider().opacity(0)
                        }
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
            
        }.frame(width: 350)
        
        .groupBoxStyle(TransparentGroupBox())
    }
    
}


// MARK: VERSION
struct versionData: View {
    
    @AppStorage("defridetailAdminStatusValue") var defridetailAdminStatusValue: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Version")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer()
                    Text("\(Bundle.main.appVersionShort!) \(Bundle.main.appVersionLong!)")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.Calming_Green)
                        .multilineTextAlignment(.trailing)
                    
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}





class Model: ObservableObject {
    @Published var data: String = ""
    init() {
        
        self.load(file: "Privacy_statement") }
    func load(file: String) {
        if let filepath = Bundle.main.path(forResource: file, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                DispatchQueue.main.async {
                    self.data = contents
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("File not found")
        }
    }
}


struct ModalView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var model: Model
    let title: String
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text(title).font(.largeTitle);
            
            ScrollView {
                VStack {
                    Text(model.data)
                        .frame(maxWidth: 350)
                }
            }
            
            Spacer()
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
                
            }
            .accentColor(.colorCardiRed)
            
        }.padding(.top)
        
    }
    
}


