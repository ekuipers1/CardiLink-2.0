//
//  MainBackground.swift
//  cardi-login
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI

struct MainBackground: View {
    
    var width = UIScreen.main.bounds.width
    let gradient = Gradient(colors: [Color.colorCardiOrange, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: 200)
                        .edgesIgnoringSafeArea(.top
                        )
                    TopLeftWhite()
                    MidCenterWhite()
                    ToprightWhite()
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundNew: View {
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    let gradient = Gradient(colors: [Color.colorCardiOrange, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: 130)
                        .edgesIgnoringSafeArea(.top
                        )
                }
                Spacer()
            }
        }
    }
}


struct MainBackgroundYellowNEW: View {
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    let gradient = Gradient(colors: [Color.Cardi_Yellow, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width:width, height: 110)
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundYellow: View {
    
    var height = UIScreen.main.bounds.height / 1.5
    var width = UIScreen.main.bounds.width
    var widthInner = UIScreen.main.bounds.width - (10 + 40)
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    let gradient = Gradient(colors: [Color.Cardi_Yellow, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width:width, height: 300)
                        .edgesIgnoringSafeArea(.all)
                    TopLeftWhite()
                    MidCenterWhite()
                    ToprightWhite()
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundRedNEW: View  {
    
    let gradient = Gradient(colors: [Color.colorCardiRed, .Cardi_Text])
    var width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                
                ZStack(alignment: .top){
                    
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width:width, height: 110)
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundRed: View  {
    
    let gradient = Gradient(colors: [Color.colorCardiRed, .Cardi_Text])
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: 500, height: 300)
                        .edgesIgnoringSafeArea(.all)
                    TopLeftWhite()
                    MidCenterWhite()
                    ToprightWhite()
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundGreenNew: View {
    
    let gradient = Gradient(colors: [Color.Calming_Green, .Cardi_Text])
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.Cardi_Text
                    .ignoresSafeArea()
                VStack() {
                    ZStack(alignment: .top){
                        Rectangle()
                            .fill(Color.Calming_Green)
                            .frame(width: geometry.size.width * 1, height: 150)
                            .edgesIgnoringSafeArea(.all)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MainBackgroundGreenNEW: View {
    
    let gradient = Gradient(colors: [Color.Calming_Green, .Cardi_Text])
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: 110)
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundGreen: View {
    
    let gradient = Gradient(colors: [Color.Calming_Green, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: 500, height: 300)
                        .edgesIgnoringSafeArea(.all)
                    TopLeftWhite()
                    MidCenterWhite()
                    ToprightWhite()
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundGrayNEW: View {
    
    let gradient = Gradient(colors: [Color.colorCardiGray, .Cardi_Text])
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: 110)
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundGray: View {
    
    let gradient = Gradient(colors: [Color.colorCardiGray, .Cardi_Text])
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: 500, height: 300)
                        .edgesIgnoringSafeArea(.all)
                    TopLeftWhite()
                    MidCenterWhite()
                    ToprightWhite()
                }
                Spacer()
            }
        }
    }
}

struct MainBackgroundBlue: View {
    
    let gradient = Gradient(colors: [Color.Cadri_BLE, .Cardi_Text])
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.Cardi_Text
                .ignoresSafeArea()
            VStack() {
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: 110)
                        .edgesIgnoringSafeArea(.all)
                }
                Spacer()
            }
        }
    }
}

struct TopLeft: View {
    
    @State private var changeTop = false
    
    var body: some View {
        ZStack(alignment: .top){
            if #available(iOS 16.0, *) {
                Circle()
                    .fill(Color.colorCardiGray)
                    .frame(height: 12)
                    .padding(.top, -2.0)
                    .padding(.leading, -150.0)
                
            } else {
                Circle()
                    .fill(Color.colorCardiGray)
                    .frame(height: 12)
                    .padding(.top, -1.0)
                    .padding(.leading, -285.0)
            }
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 190 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-75))
                .padding(.top, -63.0)
                .padding(.leading, -50.0)
                .onAppear {
                    self.changeTop = true
                }
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-220))
                .padding(.top, -72.0)
                .padding(.leading, -174.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-220))
                .padding(.top, -72.0)
                .padding(.leading, -174.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ?  90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-130))
                .padding(.top, -70.0)
                .padding(.leading, -110.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 190 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-100))
                .padding(.top, -108.0)
                .padding(.leading, -50.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 350 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-95))
                .padding(.top, -185.0)
                .padding(.leading, 65.0)
        }
    }
}

struct TopLeftWhite: View {
    
    @State private var changeTop = false
    
    var body: some View {
        ZStack(alignment: .top){
            if #available(iOS 16.0, *) {
                
                Circle()
                    .fill(Color.white)
                    .frame(height: 12)
                    .padding(.top, -2.0)
                    .padding(.leading, -150.0)
                
            } else {
                
                Circle()
                    .fill(Color.white)
                    .frame(height: 12)
                    .padding(.top, -1.0)
                    .padding(.leading, -285.0)
            }
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 190 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-75))
                .padding(.top, -63.0)
                .padding(.leading, -50.0)
                .onAppear {
                    self.changeTop = true
                }
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-220))
                .padding(.top, -72.0)
                .padding(.leading, -174.0)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-220))
                .padding(.top, -72.0)
                .padding(.leading, -174.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ?  90 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-130))
                .padding(.top, -70.0)
                .padding(.leading, -110.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 190 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-100))
                .padding(.top, -108.0)
                .padding(.leading, -50.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeTop ? 2 : 2, height: changeTop ? 350 : 0)
                .animation(Animation.easeOut(duration: 3)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-95))
                .padding(.top, -185.0)
                .padding(.leading, 65.0)
        }
    }
}

struct MidCenterWhite: View {
    
    @State private var change = false
    
    var body: some View {
        ZStack(alignment: .top){
            Circle()
                .fill(Color.white)
                .frame(height: 15)
                .padding(.top, 50.0)
                .padding(.leading, 80.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 300 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(85))
                .padding(.top, -81.0)
                .padding(.trailing, 220.0)
                .onAppear {
                    self.change = true
                }
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 300 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(65))
                .padding(.top, -28.0)
                .padding(.trailing, 190.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-15))
                .padding(.top, 60.0)
                .padding(.leading, 110.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-45))
                .padding(.top, 40.0)
                .padding(.leading, 155.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-65))
                .padding(.top, 25.0)
                .padding(.leading, 175.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 180 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-99))
                .padding(.top, -45.0)
                .padding(.leading, 256.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 180 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-115))
                .padding(.top, -72.0)
                .padding(.leading, 245.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 150 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-145))
                .padding(.top, -80.0)
                .padding(.leading, 165.0)
        }
    }
}

struct MidCenter: View {
    
    @State private var change = false
    
    var body: some View {
        ZStack(alignment: .top){
            Circle()
            
            
                .fill(Color.colorCardiGray)
                .frame(height: 15)
                .padding(.top, 50.0)
                .padding(.leading, 80.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 300 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(85))
                .padding(.top, -81.0)
                .padding(.trailing, 220.0)
                .onAppear {
                    self.change = true
                }
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 300 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(65))
                .padding(.top, -28.0)
                .padding(.trailing, 190.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-15))
                .padding(.top, 60.0)
                .padding(.leading, 110.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-45))
                .padding(.top, 40.0)
                .padding(.leading, 155.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 110 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-65))
                .padding(.top, 25.0)
                .padding(.leading, 175.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 180 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-99))
                .padding(.top, -45.0)
                .padding(.leading, 256.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 180 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-115))
                .padding(.top, -72.0)
                .padding(.leading, 245.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: change ? 2 : 2, height: change ? 150 : 0)
                .animation(Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(-145))
                .padding(.top, -80.0)
                .padding(.leading, 165.0)
        }
    }
}

struct ToprightWhite: View {
    
    @State private var changeright = false
    
    var body: some View {
        ZStack(alignment: .top){
            Circle()
                .fill(Color.white)
                .frame(height: 12)
                .padding(.top, 55.0)
                .padding(.leading, 290.0)
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(145))
                .padding(.top, -50.0)
                .padding(.leading, 220.0)
                .onAppear {
                    self.changeright = true
                }
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(160))
                .padding(.top, -55.0)
                .padding(.leading, 250.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(200))
                .padding(.top, -55.0)
                .padding(.leading, 330.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(230))
                .padding(.top, -5.0)
                .padding(.leading, 350.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(260))
                .padding(.top, 14.0)
                .padding(.leading, 370.0)
            
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(280))
                .padding(.top, 28.0)
                .padding(.leading, 368.0)
        }
        
    }
}

struct Topright: View {
    
    @State private var changeright = false
    
    var body: some View {
        ZStack(alignment: .top){
            Circle()
                .fill(Color.colorCardiGray)
                .frame(height: 12)
                .padding(.top, 55.0)
                .padding(.leading, 290.0)
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(145))
                .padding(.top, -50.0)
                .padding(.leading, 220.0)
                .onAppear {
                    self.changeright = true
                }
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
                .rotationEffect(.degrees(160))
                .padding(.top, -55.0)
                .padding(.leading, 250.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 120 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(200))
                .padding(.top, -55.0)
                .padding(.leading, 330.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(230))
                .padding(.top, -5.0)
                .padding(.leading, 350.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(260))
                .padding(.top, 14.0)
                .padding(.leading, 370.0)
            
            Rectangle()
                .fill(Color.colorCardiGray)
                .opacity(0.5)
                .frame(width: changeright ? 2 : 2, height: changeright ? 80 : 0)
                .animation(Animation.easeOut(duration: 4)
                    .repeatForever(autoreverses: false))
            
                .rotationEffect(.degrees(280))
                .padding(.top, 28.0)
                .padding(.leading, 368.0)
        }
    }
}
