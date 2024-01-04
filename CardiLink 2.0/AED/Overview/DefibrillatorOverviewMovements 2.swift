//
//  DefibrillatorOverviewMovements.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 9/21/22.
//


import SwiftUI


//MARK: Movements
struct MovementsActive: View{
    @State private var showButtons = false
    @Environment(\.presentationMode) var presentationMode
    @State private var dropdownComm = false
    
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        VStack(){
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.Cardi_Text)
                //                    .opacity(0.4)
                //                    .padding(.leading, 120.0)
                    .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                    .frame(width: 330, height: 70)
                
                
                
                VStack(alignment: .leading, spacing: 120) {
                    HStack(){
                        Button(action: {
                            print("Movement click")
                            
                            
                            
                        }, label: {
                            
                            HStack(){
                                NavigationLink(destination: MapviewMove(location: MapDirectoryMove().places[0], places: MapDirectoryMove().places)) {
                                    
                                    HStack(spacing: -20){
                                        Image(systemName: "house.fill")
                                            .font(.title2)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.colorCardiRed)
                                            .padding(10.0)
                                        Spacer()
                                        Image(systemName: "figure.walk")
                                            .font(.title2)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.Cardi_Blocks)
                                        Spacer()
                                        VStack(alignment: .leading){
                                            Text("Movements")
                                                .font(.headline)
                                                .foregroundColor(Color.Cardi_Text_Inf)
                                                .fontWeight(.semibold)
                                        }
                                        Spacer()
                                        Image(systemName: "figure.walk")
                                            .font(.title2)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.Cardi_Blocks)
                                        Spacer()
                                        Image(systemName: "bolt.heart.fill")
                                            .font(.title2)
                                            .frame(width: 40.0, height: 40.0)
                                            .foregroundColor(Color.Calming_Green)
                                            .padding(.trailing, -10.0)
                                        //                        Spacer()
                                    }
                                }
                            }  .simultaneousGesture(TapGesture().onEnded{
                                //                            MovementDataFetch()
                                print("MovementDataFetch")
                                getmovementData()
                                
                            })
                        })
                    }
                    .frame(width: 320, height: 70)
                }.padding(.top, 0.0)
                
            }.offset(x: 0)
            //                .padding(.top, 10.0)
        }
    }
}
