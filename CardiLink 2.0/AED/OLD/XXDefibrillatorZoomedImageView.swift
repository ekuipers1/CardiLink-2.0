//
//  XXDefibrillatorZoomedImageView.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.05.23.
//

import SwiftUI

struct XXDefibrillatorZoomedImageView: View {
    let uiImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var zoomScale: CGFloat = 1.0
    @State private var currentZoomScale: CGFloat = 1.0
    @GestureState private var dragOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(zoomScale * currentZoomScale)
                    .offset(x: accumulatedOffset.width + dragOffset.width, y: accumulatedOffset.height + dragOffset.height)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                zoomScale = value.magnitude
                            }
                            .onEnded { value in
                                currentZoomScale *= value.magnitude
                            }
                    )
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                accumulatedOffset.width += value.translation.width
                                accumulatedOffset.height += value.translation.height
                            }
                    )
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
        }
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}




struct DefibrillatorZoomedImageView_Previews: PreviewProvider {
    static var previews: some View {
        XXDefibrillatorZoomedImageView(uiImage: UIImage(named: "placeholderImage"))
    }
}
