//
//  AD_212_ImagesUpdateEndOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 15.08.23.
//

import SwiftUI

struct AD_212_ImagesUpdateEndOverview: View {
    
    
    @State private var isPresentingImagePicker = false
    @State private var requestedSourceType: UIImagePickerController.SourceType?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage? //= nil
    @State private var isPresentingSheet = false
    @State private var alertText: String = ""
    @State private var alertSuccess: Bool = false
    @State private var showAlert: Bool = false
    @StateObject var imageFetcher = ImageFetcher()
    @State private var showImagePicker = false
    @State private var showLibraryPicker = false
    @State private var isSaving = false
    @State private var showLargeImage = false
    @State private var isShowingAlert = false
    @State private var isDeleting = false
    @State private var isCameraPresented = false
    @State private var image: UIImage?
    @State private var isLoading: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.Cardi_Text)
                        .frame(width: 50, height: 50)
                    
                    if isDeleting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                    } else {
                        Button(action: {
                            if let selectedImageIndex = imageFetcher.downloadedImages.firstIndex(where: { $0.image == selectedImage }) {
                                let imageToBeDeleted = imageFetcher.downloadedImages[selectedImageIndex].image
                                let imageID = imageFetcher.downloadedImages[selectedImageIndex].id
                                imageFetcher.deleteImages(imageID: imageID) {
                                    if selectedImage == imageToBeDeleted {
                                        if let nextImage = imageFetcher.downloadedImages.first {
                                            selectedImage = nextImage.image
                                        } else {
                                            selectedImage = nil
                                        }
                                    }
                                }
                            }
                        }) {
                            Image(systemName: "trash.circle")
                                .font(.title)
                                .foregroundColor(imageFetcher.downloadedImages.isEmpty ? .gray : Color.colorCardiRed)
                        }
                    }
                }
                .disabled(imageFetcher.downloadedImages.isEmpty || isDeleting)
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.Cardi_Text)
                        .frame(width: 50, height: 50)
                        .frame(width: 50, height: 50)
                    
                    Button(action: {
                        if imageFetcher.downloadedImages.count < 3 {
                            selectedImage = nil
                            self.isCameraPresented = true
                        } else {
                            self.isShowingAlert = true
                        }
                    }) {
                        Image(systemName: "camera.shutter.button")
                            .font(.title)
                            .foregroundColor(imageFetcher.downloadedImages.count >= 3 ? .gray : Color.Calming_Green)
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Warning"),
                            message: Text("Only 3 images are allowed."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .sheet(isPresented: $isCameraPresented) {
                    ImagePickerNew(isShown: $isCameraPresented, image: $image) {
                        self.imageFetcher.fetchImages {
                            if let firstImage = self.imageFetcher.downloadedImages.first {
                                selectedImage = firstImage.image
                            }
                        }
                    }
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.Cardi_Text)
                        .frame(width: 50, height: 50)
                        .frame(width: 50, height: 50)
                    
                    Button(action: {
                        if imageFetcher.downloadedImages.count < 3 {
                            selectedImage = nil
                            self.showLibraryPicker = true
                        } else {
                            self.isShowingAlert = true
                        }
                    }) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.title)
                            .foregroundColor(imageFetcher.downloadedImages.count >= 3 ? .gray : Color.Calming_Green)
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Warning"),
                            message: Text("Only 3 images are allowed."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .sheet(isPresented: $showLibraryPicker) {
                    ImagePickerGallery(isShown: $showLibraryPicker, image: $selectedImage, isLoading: $isLoading) {
                        
                        self.imageFetcher.fetchImages {
                            if let firstImage = self.imageFetcher.downloadedImages.first {
                                selectedImage = firstImage.image
                            }
                        }
                    }
                    
                    if isLoading {
                        VStack(){
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .backgroundCardWaiting()
                            VStack(alignment: .center, spacing: 5) {
                                Text("Saving in progress...")
                                Text("Please wait.")
                            }
                            .font(.headline)
                            .foregroundColor(Color.Cardi_Text_Inf)
                            .multilineTextAlignment(.leading)
                            .frame(width:widthInnerText, height: 40)
                            .offset(x: 0, y: -350)
                            
                            ProgressView()
                            
                                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                                .scaleEffect(3)
                                .background(Color.white.opacity(0.8))
                                .offset(x: 0, y: -300)
                            
                        }
                    }
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.Cardi_Text)
                        .frame(width: 50, height: 50)
                    Button(action: { showLargeImage.toggle() }) {
                        Group {
                            
                            if selectedImage == nil {
                                Image(systemName: "rectangle.expand.vertical")
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                            } else {
                                Image(systemName: "rectangle.expand.vertical")
                                    .font(.title)
                                    .foregroundColor(Color.Cardi_Text_Inf)
                            }
                        }
                    }
                }
                .disabled(selectedImage == nil)
            }.offset(x: -10, y: 30)
                .shadow(color: Color.Cardi_Blocks, radius: 2, y: 1)
                .offset(x: 10, y: -55)
            
            if imageFetcher.downloadedImages.count > 0 {
                Image(uiImage: selectedImage ?? imageFetcher.downloadedImages[0].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 220)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(imageFetcher.downloadedImages, id: \.id) { downloadedImage in
                            Button(action: {
                                selectedImage = downloadedImage.image
                            }) {
                                Image(uiImage: downloadedImage.image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            } else {
                noImagePlaceholder()
            }
            
        }.padding()
            .frame(width: widthInnerText)
            .sheet(isPresented: $showLargeImage) {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Button(action: { showLargeImage.toggle() }) {
                            Image(systemName: "x.square.fill")
                                .font(.title)
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(Color.colorCardiRed)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        , alignment: .topTrailing
                    )
            } .onAppear(perform: {
                imageFetcher.fetchImages {
                    if let firstImage = imageFetcher.downloadedImages.first {
                        selectedImage = firstImage.image
                    }
                }
            })
    }

    private func dismissPicker() {
        showImagePicker = false
        showLibraryPicker = false
    }

    private func noImagePlaceholder() -> some View {
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
