//
//  AboutView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 12.09.23.
//

import SwiftUI

struct AboutView: View {
    
    @State var selection: Int? = nil
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                MainBackgroundNew()
                    .edgesIgnoringSafeArea(.all)
                HStack() {
                    Button(action: {
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Divider().opacity(0)
                    Text("About")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(Color.Cardi_Text_Inf)
                } .frame(width: widthInner)
                    .padding(.top,10)
            }.frame(height:60)
            Spacer()
            ScrollView {
                aboutSection()
                    .padding(.top, 10.0)
                dependencies()
                    .padding(.top, 20.0)
                licenseData()
                    .padding(.top, 20.0)
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
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 40.0)
            BottomNavigationBar()
                .frame(height: 0)
                .padding(.top, 30.0)
        }
    }
}

struct dependencies: View {
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Package Dependencies") {
                VStack(alignment: .leading){
                    HStack(){
                        Image(systemName: "shippingbox")
                        Text("Alamofire")
                    }
                    
                    Divider().opacity(0)
                    
                    HStack(){
                        Image(systemName: "shippingbox")
                        Text("SwiftyJSON")
                    }
                    Divider().opacity(0)
                }
                
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct aboutSection: View {
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
                                Image(systemName: "lock.shield")
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
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
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
