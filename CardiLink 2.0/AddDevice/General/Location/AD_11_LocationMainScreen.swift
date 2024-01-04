//
//  AD_11_LocationMainScreen.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.22.
//

import SwiftUI


struct AD_11_LocationMainScreen: View {

    @EnvironmentObject var navigationManager: NavigationManager
    
//    var height = UIScreen.main.bounds.height / 1.5
//    var width = UIScreen.main.bounds.width - (10 + 40)
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(){
                    //                Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Location Information")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInner, height: 40)
                            .offset(x: 0, y: 40)
                        //                    Spacer()
                        Text("Are you currently at the location where the AED will be installed?")
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .frame(width:widthInnerText, height: 250)
                            .offset(x: 20, y: 40)
                        Spacer()
                        
                    }
                    
                    
                    HStack(){
                        
                        Button(action: {
                            navigationManager.push(.adlocationposition)
//                            navigationManager.currentView = .adlocationposition
                        }, label: {
                            HStack {
                                Text("Yes")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                        //    .padding(.bottom, 10)
                        })
                        .environmentObject(navigationManager)

                        
                        Button(action: {
                            navigationManager.push(.adlocationaddress)
//                            navigationManager.currentView = .adlocationaddress
                        }, label: {
                            HStack {
                                Text("No")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                        })
                        .environmentObject(navigationManager)

                        
                    }
                    .padding(.bottom, 20.0)
                    
                    .frame(width:widthInnerText)
                    
                }
            }
            .offset(x: 15, y: 0)
            
            Spacer()
            
        }.frame(width:width)
        
            .navigationBarHidden(true)
        
    }
}


struct AD_11_LocationMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        AD_11_LocationMainScreen()
            .previewDevice("iPhone SE (2nd generation)")
        AD_11_LocationMainScreen()
            .previewDevice("iPhone 14 Pro")
    }
}


//MARK: PageNumberOne
//struct LocationPageNumberOne: View {
//
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    var height = UIScreen.main.bounds.height / 1.5
//    var width = UIScreen.main.bounds.width - (10 + 10)
//    var widthInner = UIScreen.main.bounds.width - (10 + 40)
//    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
//
////    @Binding var SectionTwoFirstLine: Bool
//    //    @Binding var SectionOneSecondLine: Bool
//
//    @State var acknowladge = false
//
//    let proxy: ScrollViewProxy
//
//    var body: some View {
//
//        //            ScrollView(.horizontal){
//        //                ScrollViewReader { proxy in
//
//        ZStack(){
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .backgroundCard()
//
//            VStack(){
//                //                Spacer()
//
//                VStack(alignment: .leading){
//                    Text("Location Information")
//                        .font(.headline)
//                        .foregroundColor(Color.Cardi_Text_Inf)
//                        .multilineTextAlignment(.leading)
//                        .padding(.bottom, 10.0)
//                        .frame(width:widthInner, height: 40)
//                        .offset(x: 0, y: 40)
////                    Spacer()
//                    Text("Are you currently at the location where the AED will be installed")
//                        .foregroundColor(Color.Cardi_Text_Inf)
//                        .frame(width:widthInnerText, height: 250)
//                        .offset(x: 20, y: 40)
//                    Spacer()
//
//                }
//
//
//                HStack(){
//
//                    Button(action: {
//                        print("Floating Button Click")
//                        self.presentationMode.wrappedValue.dismiss()
//                    }, label: {
//
//                        NavigationLink(destination: AD_121_LocationPosition()) {
//
//                            HStack {
//
//                                Text("Yes")
//                                    .fontWeight(.semibold)
//                                    .font(.headline)
//                            }
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
//                            .cornerRadius(20)
//                            .padding(.bottom, 10)
//
//                        }
//                    })
//
//                    Button(action: {
//                        print("Floating Button Click")
//                        self.presentationMode.wrappedValue.dismiss()
//                    }, label: {
////                        NavigationLink(destination: AD_122_LocationAddress()) {
////                        NavigationLink(destination:  AddressManual()) {
//                        NavigationLink(destination:  AD_122_LocationAddress()) {
//                        HStack {
//                                //                            Image(systemName: "checkmark.seal")
//                                //                                .font(.headline)
//                                Text("No")
//                                    .fontWeight(.semibold)
//                                    .font(.headline)
//                            }
//
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
//                            .cornerRadius(20)
//                            .padding(.bottom, 10)
//                            .id(1)
//
//                        } //.animation(.easeInOut)
//                    })
//                }.frame(width:widthInnerText, height: 120)
//                    .offset(x: 0, y: 30)
//                Spacer()
//            }
//
//        }
//        //.offset(x: 10, y: 0)
//        .padding(.bottom, 20)
//    }
//}

