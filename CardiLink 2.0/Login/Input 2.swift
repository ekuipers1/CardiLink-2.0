//
//  Input.swift
//  cardi-login
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI

enum InputTypes {
    case text
    case secure
}

struct Input: View {
    var placeholder: LocalizedStringKey
    var value:Binding<String>
    var type:InputTypes
    @State private var secured: Bool = true
    
    var body: some View {
        VStack {
            Group {
                if (self.type == InputTypes.text) {
                    
                    ZStack(){
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.Cardi_Text)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        TextField(self.placeholder, text: self.value)
                            
                            .padding(.leading, 30)
                            .foregroundColor(Color.Cardi_Text_Inf)
                        
                    }
                    
                } else {
                    HStack(){
                    ZStack(){
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.Cardi_Text)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
//                            .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

//                            .padding(.leading, 12)
                        HStack(){
                        if secured {
                            SecureField(self.placeholder, text: self.value)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                
                                .padding(.leading, 30)
                                   } else {
                                       TextField(self.placeholder, text: self.value)
                                           .foregroundColor(Color.Cardi_Text_Inf)
                                           
                                           .padding(.leading, 30)
                                   }
//                    }
                        Button(action: {
                                       self.secured.toggle()
                                   }) {
                                       if secured {
                                           Image("eye_closed")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 50, height: 30)
                                               .padding(.trailing, 30)
                                       } else {
                                           Image("eye_open")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 50, height: 30)
                                               .padding(.trailing, 30)
                                       }
                                   }
                        }
                        
                    }
                }
                }
            }
        }
    }
}

//struct EyeImage: View {
//
//    private var imageName: String
//
//    init(name: String) {
//        self.imageName = name
//    }
//
//    var body: some View {
//        Image(imageName)
//            .resizable()
//            .foregroundColor(.black)
//            .frame(width: 44, height: 44, alignment: .trailing)
//    }
//}
//}
