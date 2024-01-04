//
//  CommMainMenu_New.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.09.21.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct CommMainMenu_New: View {
    
    @State var selection: Int? = nil
    @ObservedObject var fetcherForComs = GetCommDataNK()
    @AppStorage("CommunicatorCount") var communicatorCount : Int!
    @EnvironmentObject var navigationManager: NavigationManager
    let defaults = UserDefaults.standard
    @State var commText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(){
                ZStack(){
                    MainBackgroundNew()
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading){
                        HStack(){
                            Button(action:{
                                navigationManager.navigateTo(.dashboard)
                            }){
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .frame(width: 40.0, height: 40.0)
                                    .foregroundColor(Color.black)
                                    .background(Color.white)
                                    .cornerRadius(50)
                            }
                            Spacer()
                        }
                    }.frame(width: widthInnerText, height: 60)
                        .offset(x: 0, y: 30)
                }
                .frame(width: width, height: 100)
                
                List() {
                    ScrollView{
                        
                        Section {
                            ForEach(fetcherForComs.fetchcommData) { C3PO in
                                NavigationLink(
                                    destination: CommDetailed()) {
                                        
                                        ZStack() {
                                            HStack(){
                                                VStack (alignment: .leading) {
                                                    ZStack(){
                                                        Rectangle()
                                                            .fill(Color.colorCardiOrange)
                                                            .frame(width: width, height: 45.0)
                                                        Text(C3PO.commSerial ?? "..")
                                                            .fontWeight(.bold)
                                                            .font(.title)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                            .frame(width: widthInner, height: 30.0, alignment:.leading)
                                                            .offset(x: -5)
                                                    }
                                                    HStack(){
                                                        Image(systemName:"person.2.crop.square.stack")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 30, height: 30)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
                                                        Text(C3PO.ownerName ?? "..")
                                                            .fontWeight(.medium)
                                                            .font(.headline)
                                                            .foregroundColor(Color.Cardi_Text_Inf)
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
                                                        if C3PO.description == "<null>" {
                                                            Text("N/A")
                                                                .fontWeight(.thin)
                                                                .font(.subheadline)
                                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                                .multilineTextAlignment(.leading)
                                                                .lineLimit(2)
                                                                .frame(width: widthInnerText, height: 60.0, alignment:.leading)
                                                                .offset(x: 5)
                                                        } else {
                                                            Text(C3PO.description ?? "N/A")
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
                                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .simultaneousGesture(TapGesture().onEnded{
                                        UserDefaults.standard.set(C3PO.id, forKey: "SelectedComm")
                                        CommGetsingleData()
                                        getNKMessagesDataComm()
                                    })
                            }
                            
                        }
                        
                    header: {
                        VStack() {
                            let CommTotal = communicatorCount
                            let CommTotalString = String(CommTotal ?? 0)
                            HStack(){
                                Spacer()
                                Text(CommTotalString)
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                                Text("Heart Connects")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                            }.frame(width: widthInnerText, height: 20.0)
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color.colorCardiOrange)
                                .frame(width: widthInner, height: 4.0)
                        }
                    }
                    }
                } .frame(width: widthList)
                    .padding(.top, 0)
                    .padding(.bottom, 60)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                
            }.navigationBarHidden(true)
                .mask(
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}
