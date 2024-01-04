//
//  XXIImageTester2.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 21.08.23.
//

import SwiftUI
import Combine

struct XXIImageTester2: View {
    
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
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color.Cardi_Text)
            .shadow(color: Color.Cardi_Blocks, radius: 3, y: 0)
            .frame(width: 325, height: 350)
            .overlay(
                VStack {
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

                        
                        
//                        .sheet(isPresented: $isCameraPresented) {
//                            ImagePickerNew(isShown: $isCameraPresented, image: $image)
//                        }

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
                            
                            if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .primary)) // Use your preferred style or color
                                        .scaleEffect(2) // Adjust this for the desired size of your progress view
                                        .background(Color.white.opacity(0.8)) // Optional: gives a background to make progress view stand out more
                                }
                        }

                        
                        //MARK: OPEN GALLERY
                        .sheet(isPresented: $showLibraryPicker) {
                            ImagePickerGallery(isShown: $showLibraryPicker, image: $selectedImage,isLoading: $isLoading) {
                                // Called when image picking is done
                                self.imageFetcher.fetchImages {
                                    if let firstImage = self.imageFetcher.downloadedImages.first {
                                        selectedImage = firstImage.image
                                    }
                                }
                            }
                        }

                        
                        
//
//                        .sheet(isPresented: $showLibraryPicker) {
//                            ImagePickerGallery(isShown: $showLibraryPicker, image: $selectedImage)
//                                }

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
                    
                }.padding()
                    .frame(width: widthInnerText)
            )
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

struct XXIImageTester2_Previews: PreviewProvider {
    static var previews: some View {
        XXIImageTester2()
            .previewDevice("iPhone SE (3rd generation)")
        XXIImageTester2()
            .previewDevice("iPhone 14 Pro")
    }
}

struct ImagePickerNew_Test: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    @State private var alertText: String = ""
    @State private var showAlert: Bool = false
    var completion: (() -> Void)?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerNew_Test
        
        init(_ parent: ImagePickerNew_Test) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
                
                // Save the image to the API
                postImageNew(image: uiImage) {
                    // Dismiss the picker only after the image is posted.
                    self.parent.isShown = false
                    
                    // Call the completion handler
                    self.parent.completion?()
                }
            }
        }

        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
        
        func postImageNew(image: UIImage, completion: @escaping () -> Void) {
            guard image != nil else {
                // Handle error: no image provided
                return
            }
            
            let defaults = UserDefaults.standard
            let myURL = defaults.string(forKey: "myPortal")
            let AuthKey = defaults.string(forKey: "DATASTRING")
            let authKey = AuthKey!
            
//            let currentDefie = defaults.string(forKey: "SelectedDefi")
            //
            let currentDefie = defaults.string(forKey: "defridetailID")
            let myDefibrillators = "defibrillators/" //4500
            let baseUrl = myURL! + myDefibrillators
            let endit = "/images"
            
            //@AppStorage("defridetailSerial") var defridetailSerial: String?
            //@AppStorage("defridetailID") var defridetailID: String?
            
            let finalURL = baseUrl + (currentDefie ?? "0000000000") + endit
            
            
            let url_defi = URL(string:finalURL)!
            
            let imageData = image.jpegData(compressionQuality: 0.6)!
            let boundary = UUID().uuidString
            
            var request = URLRequest(url: url_defi)
            request.httpMethod = "POST"
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.addValue(authKey, forHTTPHeaderField: "authkey")
            request.addValue("keep-alive", forHTTPHeaderField: "Connection")
            
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    // Handle error
//                    alertText = "Error: \(error.localizedDescription)"
//                    showAlert = true
                    completion()
                    return
                }
                
                guard let data = data else {

                    completion()
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {

                    print(responseString)

                } else {
                    // Handle invalid data

                }
                completion()
            }.resume()
            
            //        completion()
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerNew_Test>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerNew_Test>) {
    }
}

struct ImagePickerGallery_Test: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    var completion: (() -> Void)?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerGallery_Test
        
        init(_ parent: ImagePickerGallery_Test) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
                postImageNew(image: uiImage) {
                    
                    let imageFetcher = ImageFetcher()
                    
                    imageFetcher.fetchImages {
                        if let firstImage = imageFetcher.downloadedImages.first {
                            self.parent.image = firstImage.image
                        }
                        
                        // Dismiss the picker only after fetching the images.
                        self.parent.isShown = false
                        
                        // Call the completion handler
                        self.parent.completion?()
                    }
                }
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
        
        func postImageNew(image: UIImage, completion: @escaping () -> Void) {
            guard image != nil else {
                // Handle error: no image provided
                return
            }
            
            let defaults = UserDefaults.standard
            let myURL = defaults.string(forKey: "myPortal")
            let AuthKey = defaults.string(forKey: "DATASTRING")
            let authKey = AuthKey!
            let currentDefie = defaults.string(forKey: "defridetailID")
            let myDefibrillators = "defibrillators/" //4500
            let baseUrl = myURL! + myDefibrillators
            let endit = "/images"

            let finalURL = baseUrl + (currentDefie ?? "0000000000") + endit

            let url_defi = URL(string:finalURL)!
            
            let imageData = image.jpegData(compressionQuality: 0.6)!
            let boundary = UUID().uuidString
            
            var request = URLRequest(url: url_defi)
            request.httpMethod = "POST"
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.addValue(authKey, forHTTPHeaderField: "authkey")
            request.addValue("keep-alive", forHTTPHeaderField: "Connection")
            
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error while uploading: \(error.localizedDescription)")
                        completion()
                        return
                    }
                    
                    guard let data = data else {
                        print("No response data received.")
                        completion()
                        return
                    }
                    
                    if let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)

                        let imageFetcher = ImageFetcher()
                        imageFetcher.fetchImages {
                            completion()
                        }

                    } else {
                        print("Error parsing response.")
                        completion()
                    }
                }.resume()
            

        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerGallery_Test>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerGallery_Test>) {
    }
}
