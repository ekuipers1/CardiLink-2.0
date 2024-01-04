//
//  AD_19_ImagesSelection.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 23.08.23.
//

import SwiftUI

struct AD_19_ImagesSelection: View {
    
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
    
    //=====
    @State private var isCameraPresented = false
    @State private var image: UIImage?
    @State private var isLoading: Bool = false
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    
    
    var body: some View {
        //        RoundedRectangle(cornerRadius: 15, style: .continuous)
        //            .fill(Color.Cardi_Text)
        //            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
        //            .frame(width: 325, height: 350)
        //            .overlay(
        
        NavigationView {
//            ZStack(){
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
//                    .backgroundCard()
//
//
//                VStack {
//
//                    ZStack(alignment: .top) {
//                        Header(title: "AED Activation".localized)
//
//                            .padding(.bottom, 10.0)
//
//
//                    }.frame(height: 50)
//
//
//
//                    VStack {
            
            VStack(alignment: .leading){
                ZStack(alignment: .top) {
                    Header(title: "AED Activation".localized)

                }

      
                ZStack(){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    
                    VStack(){
            
            
                        Spacer()
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 50, height: 50) // Adjust this size as needed.
                                
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
                                                    // if the selected image was the one that was deleted, check if there are any other images
                                                    if let nextImage = imageFetcher.downloadedImages.first {
                                                        // if there are, set the selected image to the next one
                                                        selectedImage = nextImage.image
                                                    } else {
                                                        // if there aren't, set the selected image to nil
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
                                    .frame(width: 50, height: 50) // Adjust this size as needed.
                                    .frame(width: 50, height: 50) // Adjust this size as needed.
                                
                                Button(action: {
                                    if imageFetcher.downloadedImages.count < 3 {
                                        selectedImage = nil  // Keep the selectedImage as nil when Add Image is pressed
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
                                    // Called when image picking is done
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
                                    .frame(width: 50, height: 50) // Adjust this size as needed.
                                    .frame(width: 50, height: 50) // Adjust this size as needed.
                                
                                Button(action: {
                                    if imageFetcher.downloadedImages.count < 3 {
                                        selectedImage = nil  // Keep the selectedImage as nil when Add Image is pressed
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
                            
                            //MARK: OPEN GALLERY
                            .sheet(isPresented: $showLibraryPicker) {
                                
                                
                                
                                ImagePickerGallery(isShown: $showLibraryPicker, image: $selectedImage, isLoading: $isLoading) {
                                    
                                    
                                    
                                    // Called when image picking is done
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
                                        //                                        .opacity(0.8)
                                        
                                        
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
                                        
                                            .progressViewStyle(CircularProgressViewStyle(tint: .primary)) // Use your preferred style or color
                                            .scaleEffect(3) // Adjust this for the desired size of your progress view
                                            .background(Color.white.opacity(0.8)) // Optional: gives a background to make progress view stand out more
                                            .offset(x: 0, y: -300)
                                        
                                        
                                        
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .fill(Color.Cardi_Text)
                                    .frame(width: 50, height: 50) // You can adjust this size as needed.
                                
                                Button(action: { showLargeImage.toggle() }) {
                                    Group {
                                        
                                        //                                    if imageFetcher.downloadedImages.count > 0 {
                                        
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
                        
                        Spacer()
                        
                        Button(action: {
                            navigationManager.push(.adlocationsharedata)
                        }) {
                            HStack {
                                Text("Next")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                Image(systemName: "arrowshape.forward.fill")
                                    .font(.title2)
                            }
                        }
                        .buttonStyle(ForwardButtonStyle(isLoading: isLoading))
//                        .offset(x: 0, y: -15)
                        
                    }.padding()
                        .frame(width: widthInnerText)
                    
                    //            )
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
                }.offset(x: 25, y: 0)
                
                    .padding(.bottom, 10.0)
            }
        }.navigationBarHidden(true)
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

struct AD_19_ImagesSelection_Previews: PreviewProvider {
    static var previews: some View {
        AD_19_ImagesSelection()
            .previewDevice("iPhone SE (3rd generation)")
        AD_19_ImagesSelection()
            .previewDevice("iPhone 14 Pro")
    }
}
