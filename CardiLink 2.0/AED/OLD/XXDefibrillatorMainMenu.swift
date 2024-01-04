//
//  DefibrillatorMainMenu.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//


import SwiftUI
import Combine
import Alamofire
import SwiftyJSON


struct XXDefibrillatorMainMenu: View {
    @State var defiText: String = ""

    @AppStorage("defridetailID") var myString = ""
    @ObservedObject var fetcher = GetGreenDataNK()
    @EnvironmentObject var navigationManager: NavigationManager

    let defaults = UserDefaults.standard
    
    
    var filteredData: [DataGreenElementNK] {
        fetcher.fetchgreenData.filter {
            defiText.isEmpty ? true :
            ($0.serial?.contains(defiText) ?? false) ||
            ($0.ownerName?.contains(defiText) ?? false) ||
            ($0.description?.contains(defiText) ?? false)
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack(){
                ZStack(){
                    MainBackgroundGreenNEW()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading){
                    }.frame(width: widthInnerText, height: 60)
                        .offset(x: 0, y: 25)
                }
                .frame(width: width, height: 60)
                
                TextField("", text: $defiText, prompt: Text("Search...").foregroundColor(Color.black))
                            .padding()
                       .background(Color.Cardi_group)
                       .cornerRadius(8)
                       .padding(.horizontal)
                       .frame(width: width)
                       .padding(.top, 30)
                
                List() {
                    
                    ScrollView{
                        
                        Section {
                                ForEach(filteredData) { mydefi in
                                NavigationLink(destination: AED_Overview()) {
                                    ZStack(){
                                        
                                        HStack(){
                                            
                                            VStack (alignment: .leading) {
                                                ZStack(){
                                                    Rectangle()
                                                        .fill(Color.Calming_Green)
                                                    
                                                        .frame(width: width, height: 45.0)
                                                    
                                                    Text(mydefi.serial ?? "..")
                                                        .fontWeight(.bold)
                                                        .font(.title)
                                                        .foregroundColor(Color.white)
                                                        .frame(width: widthInner, height: 30.0, alignment:.trailing)
                                                        .offset(x: -5)
                                                }
                                                
                                                HStack(){
                                                    Image(systemName:"person.2.crop.square.stack")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                    
                                                    Text(mydefi.ownerName ?? "..")
                                                        .fontWeight(.regular)
                                                        .font(.headline)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                        .multilineTextAlignment(.leading)
                                                        .frame(width: widthInnerText, height: 30.0, alignment:.leading)
                                                        .offset(x: 5)
                                                    
                                                } .frame(width: widthInner, height: 30.0, alignment:.leading)
                                                    .offset(x: 10)
                                                
                                                
                                                HStack(){
                                                    Image(systemName:"doc.text")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .foregroundColor(Color.Cardi_Text_Inf)
                                                    
                                                    if mydefi.description == "<null>" {
                                                        
                                                        Text("N/A")
                                                            .fontWeight(.regular)
                                                            .font(.headline)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(width: widthInnerText, height: 30.0, alignment:.leading)
                                                            .offset(x: 5)
                                                        
                                                    } else {
                                                        
                                                        
                                                        Text(mydefi.description ?? "N/A")
                                                            .fontWeight(.thin)
                                                            .font(.subheadline)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .multilineTextAlignment(.leading)
                                                            .lineLimit(2)
                                                            .frame(width: widthInnerText, height: 60.0, alignment:.leading)
                                                            .offset(x: 5)
                                                    }
                                                }.frame(width: widthInner, height: 60.0, alignment:.leading)
                                                    .offset(x: 10)
                                                
                                                HStack {
                                                    Circle()
                                                        .fill(Color.Cardi_Text_Inf)
                                                        .frame(width: 5, height: 5)
                                                    Circle()
                                                        .fill(Color.Cardi_Text_Inf)
                                                        .frame(width: 5, height: 5)
                                                    Circle()
                                                        .fill(Color.Cardi_Text_Inf)
                                                        .frame(width: 5, height: 5)
                                                    
                                                }.frame(width: width, height: 10.0, alignment:.center)
                                                //                        .offset(y: -10)
                                                
                                            } .padding(25.0)
                                        }
                                        
                                    }
                                    
                                }.navigationBarHidden(true)
                                    .edgesIgnoringSafeArea(.all)
                                    .simultaneousGesture(TapGesture().onEnded{
                                        UserDefaults.standard.set(mydefi.id, forKey: "SelectedDefi")
                                        UserDefaults.standard.set(0, forKey: "dashboardState")
                                        
                                        UserDefaults.standard.set("Green", forKey: "DefiListStatus")
                                        
                                        UserDefaults.standard.set("YES", forKey: "Overview")
                                        
                                        LoadMyData()
                                    })
                            }
                            
                        } header: {
                            
                            VStack() {
                                HStack(){
                                    Spacer()
                                    Text(String(filteredData.count))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                    Text("Available")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }
                                .frame(width: widthInnerText, height: 20.0)

                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.Calming_Green)
                                    .frame(width: widthInner, height: 4.0)
                                
                            }
                            .padding(.top, 5.0)
                        }
                        
                    }
                } .frame(width: widthList)
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    )
                    .padding(.top, 0)
//                    .padding(.bottom, 40)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .refreshable {
                        
//                        GreenAvailableData()
                        
                    }
                
                BottomNavigationBar()
                
            }.navigationBarHidden(true)
               
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}


struct XXDefibrillatorMainMenu_Previews: PreviewProvider {
    static var previews: some View {
        XXDefibrillatorMainMenu()
            .previewDevice("iPhone SE (3rd generation)")
        XXDefibrillatorMainMenu()
            .previewDevice("iPhone 14 Pro")
    }
}



