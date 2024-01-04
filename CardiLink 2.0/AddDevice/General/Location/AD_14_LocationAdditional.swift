//
//  AD_14_LocationAdditional.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI
import Combine

struct AD_14_LocationAdditional: View {
    
    @State var comments: String = ""
    
    @State private var floorLevel = ""
    @State private var isOn = false
    
    @State private var isAnswerYes = false
    @State private var isYesBuildingSelected: Bool? = nil
    

//    @State private var isYesCabinetSelected: Bool? = nil
    @State private var isYesCabinetSelected = false

   
    
    @State private var isYesPinSelected: Bool? = nil
    @State private var showPinEntry = false
    @State private var cabinetPin = ""
    
    
    @State private var showNewButtons = false
    @State private var showTextField = false
    
    @State private var pin = ""
    
    
    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    
    //    var height = UIScreen.main.bounds.height / 1.5
    //    var width = UIScreen.main.bounds.width - (10 + 10)
    //    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    //    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    @State private var hasLock = false
    
    @State private var isButtonVisible: Bool = false
    
    @State private var text: String = ""
    @State private var isEditing: Bool = false
    
    @State private var allDone: Bool = false
    
    @State private var hasText: Bool = false
    
    
    @State private var aedisPubAvailable: Bool = false
  
    
    
    @State var EditingInformation = UserDefaults.standard.bool(forKey: "EditingInformation")
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "Location Information")
                
            }
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                
                ScrollView(.vertical, showsIndicators: true){
                    
                    VStack(){
                        
                        VStack(){
                            //                        Spacer()
                            Text("Additional Location Information")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.center)
                                .frame(width:widthInnerText, height: 10)
                                .padding(.vertical, 20.0)
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Floor level")
                                }.offset(x: 15, y: 0)
                                
                                Spacer()
                                HStack {
                                    TextField("e.g. Ground floor", text: $floorLevel)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .padding()
                                        .border(borderColorFloor, width: 1)
                                        .onReceive(Just(floorLevel)) { newString in
                                            hasText = !newString.isEmpty
                                        }
                                }
                                
                            }
                            .padding(.bottom, 20.0)
                            .frame(width:widthInnerText)
                            .offset(x: 0, y: 10)
                            
                            
                            
                            
                            if EditingInformation == true {
                                
                                VStack(alignment: .leading){
                                    Text("AED is publicly accessible")
                                        .padding(.bottom, 10.0)
                                        .offset(x: 15, y: 0)
                                    VStack(alignment: .trailing){
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                self.aedisPubAvailable = true
                                            }) {
                                                Image(systemName: aedisPubAvailable ? "checkmark.circle.fill" : "circle")
                                                    .foregroundColor(aedisPubAvailable ? .Calming_Green : .gray)
                                                    .font(.system(size: 20))
                                                Text("Yes")
                                                    .font(.headline)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                                
                                            }
                                            Spacer()
                                            Button(action: {
                                                self.aedisPubAvailable = false
                                            }) {
                                                Image(systemName: aedisPubAvailable ? "circle" : "stop.circle.fill")
                                                    .foregroundColor(aedisPubAvailable ? .gray : .colorCardiRed)
                                                    .font(.system(size: 20))
                                                Text("No")
                                                    .font(.headline)
                                                    .foregroundColor(Color.Cardi_Text_Inf)
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding(.vertical)
                                    .frame(width:widthInnerText)
                                    
                                }
                                
                            }
                            
                            
                            VStack(alignment: .leading){
                                Text("My AED is outside the building")
                                    .padding(.bottom, 10.0)
                                    .offset(x: 15, y: 0)
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.isYesBuildingSelected = true
                                    }) {
                                        Image(systemName: isYesBuildingSelected ?? true ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(isYesBuildingSelected ?? true ? .Calming_Green : .gray)
                                            .font(.system(size: 20))
                                        Text("Yes")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                        
                                    }
                                    Spacer()
                                    Button(action: {
                                        self.isYesBuildingSelected = false
                                    }) {
                                        Image(systemName: isYesBuildingSelected ?? true ? "circle" : "stop.circle.fill")
                                            .foregroundColor(isYesBuildingSelected ?? true ? .gray : .colorCardiRed)
                                            .font(.system(size: 20))
                                        Text("No")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.vertical)
                            .frame(width:widthInnerText)
                            
                            
                            VStack(alignment: .leading){
                                Text("My AED is inside a cabinet")
                                    .padding(.bottom, 10.0)
                                    .offset(x: 15, y: 0)
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.isYesCabinetSelected = true
                                    }) {
                                        Image(systemName: isYesCabinetSelected ?? true ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(isYesCabinetSelected ?? true ? .Calming_Green : .gray)
                                            .font(.system(size: 20))
                                        Text("Yes")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                        
                                    }
                                    Spacer()
                                    Button(action: {
                                        self.isYesCabinetSelected = false
                                        self.isYesPinSelected = false
                                        
                                    }) {
                                        Image(systemName: isYesCabinetSelected ?? true ? "circle" : "stop.circle.fill")
                                            .foregroundColor(isYesCabinetSelected ?? true ? .gray : .colorCardiRed)
                                            .font(.system(size: 20))
                                        Text("No")
                                            .font(.headline)
                                            .foregroundColor(Color.Cardi_Text_Inf)
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.vertical)
                            .frame(width:widthInnerText)
                            
                            
                            if isYesCabinetSelected == true {
                                VStack(alignment: .leading){
                                    Text("Cabinet needs PIN to open?")
                                        .padding(.bottom, 10.0)
                                        .offset(x: -15, y: 0)
                                        .frame(width:widthInnerText - 5, height: 60)
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.isYesPinSelected = true
                                            
                                        }) {
                                            Image(systemName: isYesPinSelected ?? true ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(isYesPinSelected ?? true ? .Calming_Green : .gray)
                                                .font(.system(size: 20))
                                            Text("Yes")
                                                .font(.headline)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                        }
                                        Spacer()
                                        Button(action: {
                                            self.isYesPinSelected = false
                                            //                                            showPinEntry = false
                                        }) {
                                            Image(systemName: isYesPinSelected ?? true ? "circle" : "stop.circle.fill")
                                                .foregroundColor(isYesPinSelected ?? true ? .gray : .colorCardiRed)
                                                .font(.system(size: 20))
                                            Text("No")
                                                .font(.headline)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                        }
                                        Spacer()
                                    }
                                }.frame(width:widthInnerText)
                            } else if showTextField {
                                TextField("Please enter a value", text: .constant(""))
                                    .foregroundColor(Color.Cardi_Text)
                                
                            }
                            
                            if isYesPinSelected == true {
                                HStack {
                                    TextField("Please enter the pin", text: $cabinetPin)
                                        .padding()
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                                        .background(Color.Cardi_Text)
                                        .cornerRadius(8)
                                        .border(Color.gray, width: 2)
                                }
                                
                                .frame(width:widthInnerText)
                                .offset(x: 0, y: 20)
                            }
                            
                            
                            
                            
                            VStack(alignment: .leading){
                                //                                VStack(){
                                Text("Additional directions to easily find the AED")
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 10.0)
                                    .offset(x: 5, y: 0)
                                ZStack{
                                    
                                    TextEditor(text: $comments)
                                    Text(comments).opacity(0).padding(.all)
                                        .offset(x: 15, y: 0)
                                    
                                }
                                .shadow(radius: 1)
                                .border(borderColor2, width: 1)
                                .onReceive(Just(comments)) { newString in
                                    
                                    isEditing = !newString.isEmpty
                                    
                                }
                                
                                
                            } .padding(.top, 50.0)
                                .padding(.bottom, 20)
                                .frame(width:widthInnerText - 10)
                            
                        }
                        
                    }
                    .padding(.top, 10)
                    
                }//.offset(x: 0, y: 10)
                
                .frame(width:widthInnerText + 10, height: UIScreen.main.bounds.height / 1.6)
                
                //                .frame(width: UIScreen.main.bounds.width - (10 + 40), height: UIScreen.main.bounds.height / 1.6)
                
                .padding(.bottom, 100.0)
                //MARK: end scroll
                //                .padding(.top, 50.0) .frame(width: widthInner)
                //                .padding(.bottom, 50)
                
                Spacer()
                HStack(){
                    Button(action: {
                        print("Next Button Click")
                        
                        print(floorLevel)
                        print(comments)
                        print(cabinetPin)
                        UserDefaults.standard.set(floorLevel, forKey: "floorLevel")
                        UserDefaults.standard.set(comments, forKey: "comments")
                        UserDefaults.standard.set(cabinetPin, forKey: "AEDcabinetPin")
                        
                        UserDefaults.standard.set(isYesBuildingSelected, forKey: "AEDOutsideBuilding")
                        UserDefaults.standard.set(isYesCabinetSelected, forKey: "AEDIsInsideCabinet")
                        UserDefaults.standard.set(isYesPinSelected, forKey: "AEDisYesPinSelected")
                        
                        UserDefaults.standard.set(true, forKey: "loadStoredData")
                        
                        if EditingInformation == true {
                            
                            UserDefaults.standard.set(false, forKey: "loadStoredData")
                            
                            UserDefaults.standard.set("No", forKey: "EditingInformation")
                            
                            UserDefaults.standard.set(floorLevel, forKey: "floorLevel")
                            UserDefaults.standard.set(comments, forKey: "comments")
                            UserDefaults.standard.set(cabinetPin, forKey: "AEDcabinetPin")
                            
                            
                            UserDefaults.standard.set(aedisPubAvailable, forKey: "aedisPubAvailable")
                            UserDefaults.standard.set(isYesBuildingSelected, forKey: "AEDOutsideBuilding")
                            UserDefaults.standard.set(isYesCabinetSelected, forKey: "AEDIsInsideCabinet")
                            UserDefaults.standard.set(isYesPinSelected, forKey: "AEDisYesPinSelected")
                            
                            
                            //                            var EditingInformation = UserDefaults.standard.string(forKey: "EditingInformation")
                            navigationManager.push(.adlocationsharedata)
                            
                            
                        } else  {
                            navigationManager.push(.adlocationavail) // Replace with the correct ViewName case for AD_15_LocationAvailability
                            
                        }
                        
                        
                        
                        
                        
                    }) {
                        HStack {
                            Text("Next")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        
                    })
                    
                    
                }
                .frame(width:widthInnerText, height: 80)
                
                
                
            }.offset(x: 15, y: 0)
                .padding(.top, 0)
            
            //                Spacer()
            
            
        }.frame(width:width)
        //        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.endEditing()
            })
            .onAppear(){
                
                
                
                
                
                if EditingInformation == true
                {
                    
                    floorLevel =  UserDefaults.standard.string(forKey: "floorLevel") ?? "Floor Level"
                    comments = UserDefaults.standard.string(forKey: "comments") ?? ""
                    cabinetPin = UserDefaults.standard.string(forKey: "AEDcabinetPin") ?? "Please enter the pin"
                    
                    
                    aedisPubAvailable = UserDefaults.standard.bool(forKey: "aedisPubAvailable")
//                    UserDefaults.standard.set(aedisPubAvailable, forKey: "aedisPubAvailable")
                    isYesBuildingSelected = UserDefaults.standard.bool(forKey: "AEDOutsideBuilding")
                    isYesCabinetSelected = UserDefaults.standard.bool(forKey: "AEDIsInsideCabinet")
                    isYesPinSelected = UserDefaults.standard.bool(forKey: "AEDisYesPinSelected")
                    
                } else {
                    
                    self.isYesBuildingSelected = true
                }
            }
        
    }
    
    private var borderColorFloor: Color {
        
        
        return hasText ? Color.Calming_Green : Color.colorCardiRed
        
    }
    
    private var borderColor2: Color {
        
        return isEditing ? Color.Calming_Green : Color.colorCardiRed
    }
    
}

struct AD_14_LocationAdditional_Previews: PreviewProvider {
    static var previews: some View {
        AD_14_LocationAdditional()
            .previewDevice("iPhone SE (2nd generation)")
        //        //            .previewDevice("iPhone 14 Pro")
        AD_14_LocationAdditional()
            .previewDevice("iPhone 14 Pro")
    }
}


struct CustomToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            HStack {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(isOn ? .green : .gray)
                    .font(.system(size: 20))
                
                Text(isOn ? "Yes" : "No")
                    .foregroundColor(isOn ? .green : .gray)
                    .font(.system(size: 20))
            }
        }
    }
}

struct CheckmarkToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : .gray)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? .green : .gray)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                    //                        .animation(Animation.linear(duration: 0.1))
                    
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
}




