//
//  NKADBLECheckStatus.swift
//  AD CardiLink 2.0
//
//  Created by Erik Kuipers on 12.12.22.
//

import SwiftUI

struct NKADBLECheckStatus: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .top) {
                Header(title: "AED Activation")
            }
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                VStack(alignment: .leading){
                    ScrollView(){
                        Text("Check pairing status of your HeartConnect")
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10.0)
                            .frame(width:widthInnerText, height: 60)
                        
                        var attributedString: AttributedString = {
                            do {
                                var text = try AttributedString(markdown: "Please press the paper clip twice on the HeartConnect indication button **(1)**.")
                                
                                if let range = text.range(of: "(1)") {
                                    text[range].backgroundColor = .blue
                                    text[range].foregroundColor = .white
                                }
                                
                                if let range = text.range(of: "(2)") {
                                    text[range].backgroundColor = .colorCardiRed
                                    text[range].foregroundColor = .white
                                }
                                
                                return text
                                
                            } catch {
                                return ""
                            }
                        }()
                        
                        Text (attributedString)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInnerText, height: 60)
                            .padding(.bottom, 20)
                            .offset(x: 0, y: 0)
                        
                        ZStack(){
                            Image("ComV2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200,
                                       height: 200)
                                .padding(.top, 0.0)
                            
                            HStack(){
                                Circle()
                                    .strokeBorder(Color.blue,lineWidth: 4)
                                    .frame(width: 40)
                                    .padding(.top, -115)
                                Image(systemName: "1.circle.fill")
                                    .font(.title2)
                                    .padding(.top, -95)
                                    .padding(.leading, -25)
                                    .foregroundColor(.blue)
                            } .padding(.leading, -85)
                            
                            HStack(){
                                Circle()
                                    .strokeBorder(Color.Calming_Green,lineWidth: 4)
                                    .frame(width: 40)
                                    .padding(.top, -0)
                                
                                Image(systemName: "2.circle.fill")
                                    .font(.title2)
                                    .padding(.top, -35)
                                    .padding(.leading, -25)
                                    .foregroundColor(.Calming_Green)
                            }.padding(.leading, -85)
                        }

                        var attributedString2: AttributedString = {
                            do {
                                var text = try AttributedString(markdown: "Is the HeartConnect LED **(2)** blinking green?")
                                
                                if let range = text.range(of: "(2)") {
                                    text[range].backgroundColor = .Calming_Green
                                    text[range].foregroundColor = .white
                                }
                                
                                return text
                                
                            } catch {
                                return ""
                            }
                        }()
                        
                        Spacer()
                        Text (attributedString2)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInnerText, height: 60)
                            .padding(.bottom, 20)
                            .offset(x: 0, y: 0)
                        
                        HStack(){
                            
                            Button(action: {
                                withAnimation {
                                    
                                }
                                
                            }, label: {
                                NavigationLink(destination: NKADBLEGreen()) {
                                    
                                    HStack {
                                        Text("GREEN")
                                            .fontWeight(.semibold)
                                            .font(.headline)
                                    }
                                    
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                    
                                    .cornerRadius(20)
                                    .padding(.top, 40)
                                    
                                }
                            })
                            
                            Button(action: {
                                withAnimation {
                                    
                                }
                                
                            }, label: {
                                NavigationLink(destination: NKADBLERed()) {
                                    
                                    HStack {
                                        
                                        Text("RED")
                                            .fontWeight(.semibold)
                                            .font(.headline)
                                    }
                                    
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(20)
                                    .padding(.top, 40)
                                    
                                }
                            })
                            
                        }.frame(width: widthInnerText)
                        
                    }
                    Spacer()
                }.padding(.top, 30.0) .frame(width: widthInner, height: height + 60)
                
            }.offset(x: 15, y: 0)
            Spacer()
            
        }.frame(width:width)
            .navigationBarHidden(true)
    }
}

