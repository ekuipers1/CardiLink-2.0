//
//  CommMainMenu.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 04.03.21.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct CommMainMenu: View {
    
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fetcherForComs = CommsFetcher()
//    @ObservedObject var fetcherForComs2 = NewFetcher()
    
    @State var commText: String = ""
//    @State var commDetail: Int? = nil
    
    var body: some View {
        
        VStack(){
            ZStack(){
                
                MainBackground()
                    .padding(.top, 240.0)
//                TopViewBackround()
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
                                                        UserDefaults.standard.set("", forKey: "SelectedComm")
                            
                        }){
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(50)
                        }
                        .padding(.leading, 100.0)
//                        .padding(.trailing, 20.0)
                        Text("Heart Connects")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                            .frame(width: 240, height: 30)
                            .padding(.trailing, 150)
//                            .scaledToFit()
                            .minimumScaleFactor(0.8)

//                            .fontWeight(.bold)
//                            .font(.title2)
//                            .foregroundColor(Color.black)
//                            .padding(.trailing, 50.0)
                    }
                    .padding(.top, 60.0)
//                    .padding(.top, 20.0)
//                    .frame(width: 350, height: 70)
                }
            }
            .frame(width: 450, height: 80)
//            .frame(width: 450, height: 120)
            
            
            
            HStack(){
                
                ZStack(){
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 5, y: 5)
                        .frame(width: 280, height: 50)
                    
                    // MARK: SEARCH
                    VStack(){
                        TextField("", text: $commText)
                            .modifier(PlaceholderStyle(showPlaceHolder: commText.isEmpty,
                                                       placeholder: "Communicator ID..."))
                            
                            .padding(.leading, 35.0)
                            .foregroundColor(Color.colorCardiGray)
                            .frame(width: 280, height: 50)
                            .padding(.trailing)
                    }                    
                }.padding(.leading, 20.0)
                
                if self.commText == "" {
                    
                } else {
                    
                    NavigationLink(destination: CommDetailed()) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                    }.simultaneousGesture(TapGesture().onEnded{
                        UserDefaults.standard.set(commText, forKey: "SelectedComm")
                        CommGetsingleData()
                        UIApplication.shared.endEditing()
                    })
                    
                    .padding(20)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.white)
                    .background(Color.Calming_Green)
                    .cornerRadius(50)
                    
                }
                
            }.padding(.trailing, 30.0)
            .padding(.top, 30)
            .padding(.bottom, 10)
                        
            ScrollView{
                
                LazyVStack(spacing: 15) {
                    ForEach(fetcherForComs.fetchedcoms) { mycomms in
                        NavigationLink(
                            destination: CommDetailed()) {
                            
                            ZStack() {
                                
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.white)
                                    .padding(.horizontal, 5.0)
                                    .shadow(color: .gray, radius: 5, y: 5)
                                    .frame(width: 350, height: 140.0)
                                
                                
                                HStack(){
                                    
                                    VStack (alignment: .leading) {
                                        
//                                        Text("..")
                                        Text(mycomms.id ?? "..")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                        
//                                        Text("..")
////                                        Text(mycomms.ownerID ?? "..")
                                        Text(mycomms.ownerId ?? "..")
                                            .fontWeight(.medium)
                                            .font(.headline)
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                        
                                        HStack(){
                                            
                                            Image("Comms")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                //
                                                .padding(.bottom, 10.0)
                                                .frame(width: 40,
                                                       height: 40)
                                                .padding(.leading, 0.0)
                                            
//                                            Text("..")
//                                            Text(mycomms.datumDescription ?? "..")
                                            Text(mycomms.acmedescription?.en ?? "..")
                                                .fontWeight(.light)
                                                .font(.subheadline)
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                                .frame(minWidth: 100, maxWidth: 250 , minHeight: 0, maxHeight: 50)
                                        }
                                        
                                    } .padding(35.0)
                                    
                                }
                            }
                            
                        }.navigationBarHidden(true)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                        .simultaneousGesture(TapGesture().onEnded{
                            UserDefaults.standard.set(mycomms.id, forKey: "SelectedComm")
                            CommGetsingleData()
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct CommMainMenu_Previews: PreviewProvider {
    static var previews: some View {
        CommMainMenu()
    }
}
