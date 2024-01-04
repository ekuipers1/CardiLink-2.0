//
//  XXDefibrillatorOverviewImage.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 17.05.23.
//

import SwiftUI
import Alamofire

struct XXDefibrillatorOverviewImage: View {
    @State private var uiImage: UIImage? = nil
    @State private var isShowingFullScreen = false
    @State private var zoomScale: CGFloat = 1.0
    @State private var currentZoomScale: CGFloat = 1.0
    @State private var downloadedImages: [UIImage] = [] // Added downloadedImages array
    
    @State private var currentImageIndex = 0
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.Cardi_Text)
                .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
                .frame(width: 325, height: 300)
            
            if !downloadedImages.isEmpty {
                Button(action: {
                    withAnimation {
                        isShowingFullScreen.toggle()
                    }
                }) {
                    Image(systemName: "rectangle.expand.vertical")
                        .font(.title3)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }
                .background(
                    Circle()
                        .fill(Color.Cardi_Text)
                        .overlay(
                            Circle()
                                .stroke(Color.Cardi_Text, lineWidth: 15)
                        )
                )
                .offset(x: -10, y: -25)
                .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
                .offset(x: 105, y: -125)
                .onTapGesture {
                    isShowingFullScreen = true
                }
            } else {
                NavigationLink(destination: XXDefibrillatorAddImage()) {
                    Image(systemName: "camera")
                        .font(.title3)
                        .foregroundColor(Color.Cardi_Text_Inf)
                }
                .background(
                    Circle()
                        .fill(Color.Cardi_Text)
                        .overlay(
                            Circle()
                                .stroke(Color.Cardi_Text, lineWidth: 15)
                        )
                )
                .offset(x: -10, y: -25)
                .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
                .offset(x: 105, y: -125)
            }

            
//            if !downloadedImages.isEmpty { // Show the button only if downloadedImages is not empty
//                Button(action: {
//                    withAnimation {
//                        isShowingFullScreen.toggle()
//                    }
//                }) {
//                    Image(systemName: "rectangle.expand.vertical")
//                        .font(.title3)
//                        .foregroundColor(Color.Cardi_Text_Inf)
//                }
//                .background(
//                    Circle()
//                        .fill(Color.Cardi_Text)
//                        .overlay(
//                            Circle()
//                                .stroke(Color.Cardi_Text, lineWidth: 15)
//                        )
//                )
//                .offset(x: -10, y: -25)
//                .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
//                .offset(x: 105, y: -125)
//                .onTapGesture {
//                    isShowingFullScreen = true
//                }
//            }
            
            VStack {
                if let lastImage = downloadedImages.last { // Show only the last image
                    Image(uiImage: lastImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 220)
                } else {
                    
                    
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
                }
            }
        }
        .onAppear {
            fetchImages()
        }
//        .fullScreenCover(isPresented: $isShowingFullScreen) {
//            if !downloadedImages.isEmpty {
//                DefibrillatorDetailOverviewImage(images: downloadedImages, currentImageIndex: $currentImageIndex) // Pass $currentImageIndex as a binding
//            }
//        }
    }
    
//    var body: some View {
//        ZStack(alignment: .center) {
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color.Cardi_Text)
//                .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
//                .frame(width: 325, height: 300)
//
//            Button(action: {
//                withAnimation {
//                    isShowingFullScreen.toggle()
//                }
//            }) {
//                Image(systemName: "rectangle.expand.vertical")
//                    .font(.title3)
//                    .foregroundColor(Color.Cardi_Text_Inf)
//            }
//            .background(
//                Circle()
//                    .fill(Color.Cardi_Text)
//                    .overlay(
//                        Circle()
//                            .stroke(Color.Cardi_Text, lineWidth: 15)
//                    )
//            )
//            .offset(x: -10, y: -25)
//            .shadow(color: Color.Cardi_Blocks, radius: 2, y: 3)
//            .offset(x: 105, y: -125)
//            .onTapGesture {
//                isShowingFullScreen = true
//            }
//
//            VStack {
//                if let uiImage = uiImage {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 300, height: 220)
//                } else {
//                    Image(systemName: "photo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 300, height: 220)
//                }
//            }
//        }
//        .onAppear {
//            fetchImages()
//        }
//                .fullScreenCover(isPresented: $isShowingFullScreen) {
//                    DefibrillatorZoomedImageView(uiImage: uiImage).edgesIgnoringSafeArea(.all)
//                }
//    }
    
    
    func fetchImages() {
        let defaults = UserDefaults.standard
        guard let myURL = defaults.string(forKey: "myPortal"),
              let authKey = defaults.string(forKey: "DATASTRING"),
              let selectedDefi = defaults.string(forKey: "SelectedDefi") else {
            print("Missing required data")
            return
        }
        
        let endpart = "/images/"
        let urlImage = "\(myURL)defibrillators/\(selectedDefi)\(endpart)"
        
        AF.request(urlImage, method: .get, headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).responseData { response in
            switch response.result {
            case .success(let data):
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let responseDict = json as? [String: Any],
                      let dataArray = responseDict["data"] as? [[String: Any]] else {
                    print("Failed to process image data")
                    return
                }
                
                let imageCount = min(dataArray.count, 3) // Maximum of 3 images
                
                var downloadedImages: [UIImage] = []
                
                for i in 0..<imageCount {
                    guard let image = dataArray[i] as? [String: Any],
                          let bytesString = image["bytes"] as? String,
                          let imageData = Data(base64Encoded: bytesString),
                          let uiImage = UIImage(data: imageData) else {
                        print("Failed to process image data")
                        continue
                    }
                    
                    downloadedImages.append(uiImage)
                }
                
                DispatchQueue.main.async {
                    self.downloadedImages = downloadedImages // Assign the downloaded images to the @State property
                }
                
            case .failure(let error):
                print("Image request error: \(error)")
            }
        }
    }


//    struct ImageResponse: Decodable {
//        let bytes: String?
//        // Add other properties if needed
//    }


    
    
    
//    func fetchImage() {
//        let defaults = UserDefaults.standard
//        guard let myURL = defaults.string(forKey: "myPortal"),
//              let authKey = defaults.string(forKey: "DATASTRING"),
//              let selectedDefi = defaults.string(forKey: "SelectedDefi") else {
//            print("Missing required data")
//            return
//        }
//
//        let endpart = "/images/"
//        let urlImage = "\(myURL)defibrillators/\(selectedDefi)\(endpart)"
//
//        AF.request(urlImage, method: .get, headers: [
//            "authkey" : authKey,
//            "Accept": "application/json",
//            "Content-Type": "application/json",
//            "Connection" : "keep-alive"
//        ]).responseData { response in
//            switch response.result {
//            case .success(let data):
//                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
//                      let responseDict = json as? [String: Any],
//                      let dataArray = responseDict["data"] as? [[String: Any]],
//                      let firstImage = dataArray.first,
//                      let bytesString = firstImage["bytes"] as? String,
//                      let imageData = Data(base64Encoded: bytesString),
//                      let uiImage = UIImage(data: imageData) else {
//                    print("Failed to process image data")
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self.uiImage = uiImage
//                }
//            case .failure(let error):
//                print("Image request error: \(error)")
//            }
//        }
//    }
    
    
}

struct XXDefibrillatorOverviewImage_Previews: PreviewProvider {
    static var previews: some View {
        XXDefibrillatorOverviewImage()
    }
}
