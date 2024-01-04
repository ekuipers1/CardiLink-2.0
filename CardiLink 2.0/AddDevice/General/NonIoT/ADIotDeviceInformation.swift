//
//  ADIotDeviceInformation.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 02.02.23.
//

import SwiftUI

struct ADIotDeviceInformation: View {
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width - (10 + 10)
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 90)
    var widthInnerText2 = UIScreen.main.bounds.width - (10 + 120)

    @Environment(\.presentationMode) private var presentationMode
    
    
    @State private var modelText: String = ""
    @State private var ownerText: String = ""
    @State private var descriptionText: String = ""
    @State private var firmwareText: String = ""
    @State private var activeText: String = ""
    
    @State var fullAuto = false
    @State var semiAuto = false
    
    @State private var selectedDate = Date()
    @State private var selectedDateSim = Date()
    @State private var number: Int = 1
    @State private var firmware: String = ""
    
    //MARK: Data from Excel file AEDs v1.3
    enum ModelType : String, CaseIterable {
        case primedic = "PRIMEDIC"
        case amiitalia = "Ami Italia"
        case bexencardio = "Bexen Cardio"
        case cardiacscience = "Cardiac Science (now ZOLL)"
        case cardiaid = "Cardi Aid"
        case corpuls = "Corpuls"
        case cumedical = "CU Medical"
        case defibtech = "Defibtech"
        case heartsine = "HeartSine (now Stryker)"
        case mediana = "Mediana"
        case medicaleconet = "Medical Econet"
        case mindray = "Mindray"
        case nihonkohden = "Nihon Kohden"
        case philips = "Philips"
        case physiocontrol = "Physio Control (now Stryker)"
        case progetti = "Progetti"
        case schiller = "Schiller"
        case zoll = "Zoll"
        case other = "Other"
    }
    
    let subTypes : [ModelType: [String]] =
    [.primedic: ["HeartSave PAD", "HeartSave AED", "HeartSave AS", "HeartSave AED-M", "HeartSave 6", "HeartSave 6 S", "HeartSave One"],
     .amiitalia: ["Saver One D", "Saver One P", "Saver One semi-automatic"],
     .bexencardio: ["Reanibex 300 GSM", "Reanibex 500 EMS"],
     .cardiacscience: ["Powerheart G3 Elite", "Powerheart G3 Plus", "Powerheart G5"],
     .cardiaid: ["AED"],
     .corpuls: ["AED"],
     .cumedical: ["I-PAD SP1", "I-PAD SP1 AUTO", "I-PAD SP2 Bluetooth EKG", "I-PAD SP2 MO Manual Override", "I-PAD SP2", "I-PAD NF 1200", "I-PAD NF 1201"],
     .defibtech: ["Lifeline AED (SG)", "Lifeline AUTO (SG)", "Lifeline VIEW (Dual)", "Lifeline VIEW Auto", "Lifeline ECG", "Lifeline PRO"],
     .heartsine: ["Samaritan PAD 350P", "Samaritan PAD 360P", "Samaritan PAD 500P"],
     .mediana: ["A15", "A16"],
     .medicaleconet: ["ECO-AED Semi", "ECO-AED Auto", "ME PAD Semi", "ME PAD Auto"],
     .mindray: ["Beneheart C1", "Beneheart C1A"],
     .nihonkohden: ["HeartStart HS1", "HeartStart FRx", "HeartStart FR2", "HeartStart FR3", "HeartStart FR3 mit EKG"],
     .philips: ["HeartStart HS1", "HeartStart FRx", "HeartStart FR2", "HeartStart FR3", "HeartStart FR3 mit EKG"],
     .physiocontrol: ["CR2", "LIFEPAK CR Plus", "LIFEPAK CR 1000", "LIFEPAK CR 1000 with ECG", "LIFEPAK CR 500"],
     .progetti: ["RESCUE Sam"],
     .schiller: ["FRED", "FRED easy", "FRED easy Life", "FRED easy Professional", "FRED easy Professional S", "FRED easyport", "FRED easyport Manuel", "FRED easyport PLUS FIRST", "FRED easyport PLUS Auto", "FRED easyport PLUS Man", "FRED PA-1"],
     .zoll: ["AED 3 BLS", "AED 3", "AED Plus", "AED Pro"],
     .other: ["Other", "Unknown"]]
    
    
    @State private var selectedModel : ModelType = .primedic
    @State private var selectedSubtype : String?
    
    
    var subtypeList : [String] {
        subTypes[selectedModel] ?? []
    }
    
    @State private var settingsExpanded = true
    
    //    init(){
    //        UITableView.appearance().backgroundColor = .clear
    //    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")

            }
            
            ZStack(){
                //                RoundedRectangle(cornerRadius: 25, style: .continuous)
                //                    .backgroundCard()
                
                
                ScrollView(){
                    VStack(alignment: .leading){
                        Text("Please provide accurate information in the following fields.")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInnerText, height: 60)
                            .offset(x: 15, y: 30)
                        
                        //                .padding(.top, 60.0)
                        
                        //                    Spacer()
                        Form{
                            
                            Section {
                                Picker("", selection: $selectedModel)
                                {
                                    ForEach(ModelType.allCases, id: \.self) {
                                        Text($0.rawValue.capitalized)
                                        //                                    .frame(width: widthInnerText2)
                                        //                                    .padding(.leading, 20.0)
                                        //     .frame(width: widthInner)
                                    } .navigationBarHidden(true)
                                    
                                    
                                } //.frame(width: widthInnerText2)
                               
                            } header: {
                                
                                //let motion = "In motion".localized
                                
                                hearderforForm(name: "Manufacturer".localized, image: "wrench.and.screwdriver")
                                    .padding(.bottom, 15.0)
                                    .padding(.top, 5.0)
                            }
                            
                            Section {
                                Picker("", selection: $selectedSubtype)
                                {
                                    ForEach(subtypeList, id: \.self) {
                                        Text($0).tag($0 as String?)
                                    }
                                }
                            } header: {
                                hearderforForm(name: "Model".localized, image: "cube")
                                    .padding(.bottom, 15.0)
                            }
                        }.frame(width: widthInner, height:250)
                            .cornerRadius(25)
                            .padding(.top, 30.0)
                            .navigationBarHidden(true)
                            .scrollDisabled(true)
                        
                        HStack(){
                            if selectedSubtype == "Unknown" {
                                
                            } else {
                                
                                if selectedSubtype == "HeartSave AS" || selectedSubtype == "I-PAD NF 1201" || selectedSubtype == "I-PAD SP1 AUTO" || selectedSubtype == "Lifeline AUTO (SG)" || selectedSubtype == "Lifeline VIEW Auto" || selectedSubtype == "Samaritan PAD 360P" || selectedSubtype == "ECO-AED Auto"  || selectedSubtype == "ME PAD Auto" || selectedSubtype == "Beneheart C1A" || selectedSubtype == "FRED easyport PLUS Auto"{
                                    
                                    HStack(){
                                        Text("Operating mode:")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName:"checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(Color.Calming_Green)
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                        Text("Fully Automatic")
                                            .padding(.leading, 5.0)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }
                                } else {
                                    
                                    
                                    if selectedSubtype == "Powerheart G3 Elite" || selectedSubtype == "Powerheart G3 Plus" || selectedSubtype == "Powerheart G5" || selectedSubtype == "A16" || selectedSubtype == "CR2" || selectedSubtype == "LIFEPAK CR Plus" || selectedSubtype == "FRED easy Life" || selectedSubtype == "FRED PA-1" || selectedSubtype == "AED 3" || selectedSubtype == "AED 3 Plus" || selectedSubtype == "Other" {
                                        
                                        VStack() {
                                            Text("Please select operating mode:")
                                                .font(.headline)
                                                .frame(width:widthInnerText, height: 40)
                                                .offset(x: -10, y: -10)
                                            
                                            Button(action: {
                                                
                                                self.fullAuto.toggle()
                                                
                                            }) {
                                                Image(systemName: self.fullAuto == true ? "checkmark.circle.fill" : "circle")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(self.fullAuto == true ? .Calming_Green : .gray)
                                                    .font(.system(size: 20, weight: .bold, design: .default))
                                                Text("Fully Automatic")
                                                    .padding(.leading, 15.0)
                                                    .foregroundColor(self.fullAuto == true ? .Calming_Green : .Cardi_Text_Inf)
                                            }.frame(maxWidth: widthInnerText, alignment: .leading)
                                                .padding(.bottom)
                                                .padding(.leading, 15.0)
                                            
                                            Button(action: {
                                                
                                                self.semiAuto.toggle()
                                            }) {
                                                Image(systemName: self.semiAuto == true ? "checkmark.circle.fill" : "circle")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(self.semiAuto == true ? .Calming_Green : .gray)
                                                    .font(.system(size: 20, weight: .bold, design: .default))
                                                Text("Semi Automatic")
                                                    .padding(.leading, 15.0)
                                                    .foregroundColor(self.semiAuto == true ? .Calming_Green : .Cardi_Text_Inf)
                                            }.frame(maxWidth: widthInnerText, alignment: .leading)
                                                .padding(.bottom)
                                                .padding(.leading, 15.0)
                                            
                                        }
                                        
                                    } else {
                                        
                                        HStack(){
                                            Text("Operating mode:")
                                                .font(.headline)
                                            Spacer()
                                            Image(systemName:"checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.Calming_Green)
                                                .font(.system(size: 20, weight: .bold, design: .default))
                                            Text("Semi Automatic")
                                                .padding(.leading, 5.0)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                        }
                                    }
                                }
                                
                            }
                            
                        } .padding(.top, 20.0)
                        
                        HStack(){
                            Text("Production Year")
                                .font(.headline)
                            Spacer()
                            Picker("", selection: $number) {
                                ForEach(2000...2023, id: \.self) { number in
                                    Text(String("\(number)"))
                                    
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(Color.Cardi_Text_Inf)
                            .foregroundColor(Color.Calming_Green)
                        }.padding(.vertical, 15.0)
                        
                        DatePicker("Expiration date of electrode:", selection: $selectedDate, displayedComponents: .date)
                            .padding(.vertical, 15.0)
                            .font(.headline)
                        
                        DatePicker("Expiration date of battery:", selection: $selectedDateSim, displayedComponents: .date)
                            .padding(.vertical, 15.0)
                            .font(.headline)
                        
//                        HStack(){
//                            Text("Device Firmware:")
//                                .font(.headline)
//                            Spacer()
//                            TextField("", text: $firmware)
//                                .textFieldStyle(.roundedBorder)
//                                .multilineTextAlignment(.trailing)
//
//                        }.padding(.vertical, 15.0)
                        
                        
                        Button(action: {
                            
                            //SectionTwoFirstLine.toggle()
                            withAnimation {
                                
                            }
                            
                            print("Edit tapped!")
                            
                            
                        }, label: {
                            NavigationLink(destination: AD_11_LocationMainScreen()) {
                                
                                HStack {
                                    Image(systemName: "checkmark.seal")
                                        .font(.title2)
                                    Text("Done")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                                .id(1)
                                
                            }.frame(width:widthInnerText)
                                .offset(x: 15, y: 30)
                        })
                        
                        
                    }
                    .padding(.bottom, 50.0)//.padding(.top, 10.0)
                    .frame(width: widthInner)
                    
                } .offset(x: 15, y: 0)
                
            }
//            //MARK: Start BOTTOM
//            ProgressIndicator(SectionOneFirstLine: $SectionOneFirstLine, SectionOneSecondLine: $SectionOneSecondLine, SectionOneThirdLine: $SectionOneThirdLine, SectionTwoFirstLine: $SectionTwoFirstLine, SectionTwoSecondLine: $SectionTwoSecondLine, SectionOneEnd: $SectionOneEnd, SectionTwoStart: $SectionTwoStart, SectionTwoEnd: $SectionTwoEnd, SectionThreeStart: $SectionThreeStart, SectionThreeEnd: $SectionThreeEnd)
//
//
        }.frame(width:width)
            .onAppear {
                
                let defaults = UserDefaults.standard
                
                let backend = defaults.string(forKey: "BackendSelection")
                
//                let backroundColor = Int(dashboardState ?? "N/A") ?? 0
                
                switch backend {
                case "NK":
                    selectedModel = .nihonkohden
                case "CA":
                    selectedModel = .cardiaid
                default:
                    selectedModel = .primedic
                }
            }
                
                
                
                
                
                
                
                
                
                
//                selectedModel = .cardiaid }
        
            .navigationBarHidden(true)
    }
}

struct ADIotDeviceInformation_Previews: PreviewProvider {
    static var previews: some View {
        ADIotDeviceInformation()
            .previewDevice("iPhone SE (2nd generation)")
        ADIotDeviceInformation()
            .previewDevice("iPhone 14 Pro")
    }
}


struct hearderforForm: View {
    var name: String
    var image: String
    var body: some View {
        
        
        HStack() {
            Image(systemName: image).padding(.trailing)
            Text(name)
            
        }
        
        .font(.headline)
        .foregroundColor(Color.Cardi_Text_Inf)
        .textCase(nil)
        .listStyle(InsetGroupedListStyle())
        
        
    }
}
