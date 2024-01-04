//
//  XXDefibrillatorDetailOverviewImage.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 09.06.23.
//

import SwiftUI
import Alamofire

struct XXDefibrillatorDetailOverviewImage: View {
    
    @EnvironmentObject var imageFetcher: ImageFetcher
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.presentationMode) var presentationMode
    @Binding var images: [DownloadedImage] // Update the images binding to use the custom struct
    @Binding var currentImageIndex: Int
    @State private var isShowingFullScreen = false

    let defaults = UserDefaults.standard
    var body: some View {
        VStack {
            ZStack {
                if images.isEmpty {
                    // Display placeholder image
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 220)
                        .overlay(
                            GeometryReader { geometry in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                                }
                                .stroke(Color.red, lineWidth: 10)
                            }
                        )
                } else {
                    // Display the current image
                    Image(uiImage: images[currentImageIndex].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {
                    HStack {
                        Button(action: {
                            if images.count < 3 {
                                navigationManager.push(.overviewAddImage)
                                print("ADD image")
//                                DefibrillatorAddImage()
                                // Open image picker to add a new image, not covered here
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.green)
                                .font(.largeTitle)
                                .padding()
                        }

                        Spacer()

                        Button(action: {
                            if images.count > 0 {
                                let removedImageID = images[currentImageIndex].id // Get the ID of the removed image
                                images.remove(at: currentImageIndex)
                                defaults.set(removedImageID, forKey: "imageToRemove")
//                                deleteImages()
                                if currentImageIndex != 0 {
                                    currentImageIndex -= 1
                                }
                                print("Removed image ID: \(removedImageID)") // Print the removed image ID
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(Color.red)
                                .font(.largeTitle)
                                .padding()
                        }
                        
                        Spacer()

                        Button(action:{
//                            navigationManager.pop()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "x.square.fill")
                                .foregroundColor(Color.colorCardiRed)
                                .font(.largeTitle)
                                .padding()
                        }
                    }.padding(.top, 30.0)
                    Spacer()
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                Spacer()
                HStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        Button(action: {
                            currentImageIndex = index
                        }) {
                            Image(uiImage: images[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .padding(.horizontal, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(index == currentImageIndex ? Color.white.opacity(0.8) : Color.gray.opacity(0.5))
                                )
                        }
                    }
                }
                .padding(.horizontal, 16)
                
            }.frame(width: widthInnerText, height: 100)
                .padding(.bottom, 30.0)
            Spacer()
        }
        .onAppear {
//            imageFetcher.fetchImages()
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}






//struct DefibrillatorDetailOverviewImage: View {
//
//    @Binding var images: [UIImage]
//    @Binding var currentImageIndex: Int
//    @State private var isShowingFullScreen = false
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack {
//
//            ZStack {
//                if images.isEmpty {
//                    Image(systemName: "photo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 300, height: 220)
//                        .overlay(
//                            GeometryReader { geometry in
//                                Path { path in
//                                    path.move(to: CGPoint(x: 0, y: 0))
//                                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
//                                }
//                                .stroke(Color.red, lineWidth: 10)
//                            }
//                        )
//                } else {
//                    Image(uiImage: images[currentImageIndex])
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .edgesIgnoringSafeArea(.all)
//                }
//
//                VStack {
//
//
//                    HStack {
//                        Button(action: {
//                            if images.count < 3 {
//                                // Open image picker to add a new image, not covered here
//                            }
//                        }) {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundColor(Color.green)
//                                .font(.largeTitle)
//                                .padding()
//                        }
//
//                        Spacer()
//
//                        Button(action: {
//                            if images.count > 0 {
//                                images.remove(at: currentImageIndex)
//                                if currentImageIndex != 0 {
//                                    currentImageIndex -= 1
//                                }
//                            }
//                        }) {
//                            Image(systemName: "minus.circle.fill")
//                                .foregroundColor(Color.red)
//                                .font(.largeTitle)
//                                .padding()
//                        }
//
//                        Spacer()
//
//                        Button(action:{
//                            self.presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "x.square.fill")
//                                .foregroundColor(Color.colorCardiRed)
//                                .font(.largeTitle)
//                                .padding()
//                        }
//                    }.padding(.top, 30.0)
//                    Spacer()
//                }
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                Spacer()
//                HStack {
//
//                    ForEach(0..<images.count, id: \.self) { index in
//                        Button(action: {
//                            currentImageIndex = index
//                        }) {
//                            Image(uiImage: images[index])
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .padding(.horizontal, 4)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(index == currentImageIndex ? Color.white.opacity(0.8) : Color.gray.opacity(0.5))
//                                )
//                        }
//                    }
//
//                }
//                .padding(.horizontal, 16)
//
//            }.frame(width:widthInnerText, height: 100)
//                .padding(.bottom, 30.0)
//            Spacer()
//
//        }.navigationBarHidden(true)
////        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//
//}

struct XXDefibrillatorDetailOverviewImage_Previews: PreviewProvider {
    static var previews: some View {
        let downloadedImages: [DownloadedImage] = [
            DownloadedImage(id: "1", image: UIImage(named: "sample_image_1")!),
            DownloadedImage(id: "2", image: UIImage(named: "sample_image_2")!),
            DownloadedImage(id: "3", image: UIImage(named: "sample_image_3")!)
        ]
        
        return Group {
            NavigationView {
                XXDefibrillatorDetailOverviewImage(images: .constant(downloadedImages), currentImageIndex: .constant(0))
            }
            .previewDevice("iPhone SE (2nd generation)")
            
            NavigationView {
                XXDefibrillatorDetailOverviewImage(images: .constant(downloadedImages), currentImageIndex: .constant(0))
            }
            .previewDevice("iPhone 14 Pro")
        }
    }
}


//struct DefibrillatorDetailOverviewImage: View {
//
//    let images: [UIImage]
//    @Binding var currentImageIndex: Int
//    @State private var isShowingFullScreen = false
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Image(uiImage: images[currentImageIndex])
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack {
//
//
//                    HStack {
//                        Spacer()
//                        Button(action:{ self.presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Image(systemName: "x.square.fill")
//                                .foregroundColor(Color.colorCardiRed)
//                                .font(.largeTitle)
//                                .padding()
//                        }
//                    }.padding(.top, 30.0)
//                    Spacer()
//                }
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                Spacer()
//                HStack {
//
//                    ForEach(0..<images.count, id: \.self) { index in
//                        Button(action: {
//                            currentImageIndex = index
//                        }) {
//                            Image(uiImage: images[index])
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .padding(.horizontal, 4)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(index == currentImageIndex ? Color.white.opacity(0.8) : Color.gray.opacity(0.5))
//                                )
//                        }
//                    }
//
//                }
//                .padding(.horizontal, 16)
//
//            }.frame(width:widthInnerText, height: 100)
//                .padding(.bottom, 30.0)
//            Spacer()
//
//        }
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//
//}

//struct DefibrillatorDetailOverviewImage_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleImages: [UIImage] = [
//            UIImage(named: "sample_image_1")!,
//            UIImage(named: "sample_image_2")!,
//            UIImage(named: "sample_image_3")!
//        ]
//
//        return Group {
//            DefibrillatorDetailOverviewImage(images: sampleImages, currentImageIndex: .constant(0))
//                .previewDevice("iPhone SE (2nd generation)")
//
//            DefibrillatorDetailOverviewImage(images: sampleImages, currentImageIndex: .constant(0))
//                .previewDevice("iPhone 14 Pro")
//        }
//    }
//}









