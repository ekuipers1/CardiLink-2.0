//
//  AED_Gray.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 25.09.23.
//

import SwiftUI

struct AED_Gray: View {
    
    @State var selection: Int? = nil
    @State var defiTextRed: String = ""
    @AppStorage("defridetailID") var myString = ""
    @ObservedObject var fetcherGray = GetGrayNonMonitoredData()
    @EnvironmentObject var navigationManager: NavigationManager
    let defaults = UserDefaults.standard
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(){
                ZStack(){
                    MainBackgroundGrayNEW()
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading){
                        
                    }.frame(width: widthInnerText, height: 60)
                        .offset(x: 0, y: 25)
                }
                .frame(width: width, height: 80)
                
                List() {
                    ScrollView{
                        Section {
                            ForEach(fetcherGray.fetchgrayData) { mydefi in
                                NavigationLink(destination: AED_Overview()) {
                                    ZStack(){
                                        
                                        HStack(){
                                            
                                            VStack (alignment: .leading) {
                                                ZStack(){
                                                    Rectangle()
                                                        .fill(Color.colorCardiGray)
                                                    
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
                                            } .padding(25.0)
                                        }
                                        
                                    }
                                    
                                }.navigationBarHidden(true)
                                    .edgesIgnoringSafeArea(.all)
                                    .simultaneousGesture(TapGesture().onEnded{
                                        UserDefaults.standard.set(mydefi.id, forKey: "SelectedDefi")
                                        UserDefaults.standard.set(5, forKey: "dashboardState")
                                        UserDefaults.standard.set(mydefi.id, forKey: "ADdefibrillatorId")
                                        LoadMyData()
                                    })
                            }
                            
                        } header: {
                            VStack() {
                                HStack(){
                                    Spacer()
                                    let counterGray = defaults.integer(forKey: "GrayCount")
                                    Text(String(counterGray))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                    Text("Non-Monitored AEDs")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(Color.Cardi_Text_Inf)
                                }.frame(width: widthInner, height: 20.0)
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.colorCardiGray)
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
                    .padding(.bottom, 60)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .refreshable {
                        GrayNotMonitoredData()
                    }
                
                Spacer()
                BottomNavigationBar()
                    .frame(height: 40)
            }.navigationBarHidden(true)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}
