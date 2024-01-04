//
//  Shapes.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 01.12.20.
//

import SwiftUI


struct HeartBeat : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX-20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: (rect.midY+rect.maxY)/2))
        path.addLine(to: CGPoint(x: rect.midX+10, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX+20, y: (rect.midY/2)))
        path.addLine(to: CGPoint(x: rect.midX+40, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct Base_Landscape: Shape {
    var yOffset: CGFloat = 0.5

    var animatableData: CGFloat {
        get {
            return yOffset
        }
        set {
            yOffset = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Curve at the bottom
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY - (rect.maxY * yOffset)),
                      control2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY + (rect.maxY * yOffset)))

        path.closeSubpath()

        return path
    }
}

struct BackgroundRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color.Cardi_Text)
            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
            .frame(width: 325, height: 70)
    }
}

struct Glassify: ViewModifier {
    
    private let cornerRadius: CGFloat

    private let gradientColors = [
        Color.white,
        Color.white.opacity(0.1),
        Color.white.opacity(0.1),
        Color.white.opacity(0.4),
        Color.white.opacity(0.5),
    ]
    
    init(_ cornerRadius: CGFloat = 16) {
        self.cornerRadius = cornerRadius
    }

    func body(content: Content) -> some View {
           content
               .background {
                   RoundedRectangle(cornerRadius: cornerRadius)
                       .fill(Material.ultraThinMaterial)
                       .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
               }
               .overlay {
                   RoundedRectangle(cornerRadius: cornerRadius)
                       .stroke(LinearGradient(colors: gradientColors,
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing))
               }
       }
}

extension View {
    
    func glassMorphed(cornerRadius: CGFloat = 16) -> some View {
        modifier(Glassify(cornerRadius))
    }
}

extension View {
    
    func glassMorphedNoCorners(cornerRadius: CGFloat = 0) -> some View {
        modifier(Glassify(cornerRadius))
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let tr = min(min(self.tr, height/2), width/2)
        let tl = min(min(self.tl, height/2), width/2)
        let bl = min(min(self.bl, height/2), width/2)
        let br = min(min(self.br, height/2), width/2)

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - tr, y: 0))
        path.addArc(center: CGPoint(x: width - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - br))
        path.addArc(center: CGPoint(x: width - br, y: height - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bl, y: height))
        path.addArc(center: CGPoint(x: bl, y: height - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        return path
    }
}

struct Swirl: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control1: CGPoint(x: rect.minX, y: rect.midY),
            control2: CGPoint(x: rect.maxX, y: rect.midY)
        )
        return path
    }
}
