//
//  AD_19_ImagesSelectionOLD.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 20.04.23.
//

import SwiftUI
//import PhotosUI

struct AD_19_ImagesSelectionOLD: View {

    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showLibraryPicker = false
    
    
    @State private var alertText: String = ""
    @State private var alertSuccess: Bool = false
    @State private var dataToCopy: String = ""
    @State private var showAlert: Bool = false
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    
//    @Environment(\.presentationMode) private var presentationMode
    
    func postImageNew() {
        guard let image = selectedImage else {
            // Handle error: no image selected
            return
        }
        
        let defaults = UserDefaults.standard
        let myURL = defaults.string(forKey: "myPortal")
        let AuthKey = defaults.string(forKey: "DATASTRING")
        let authKey = AuthKey!
        let currentDefie = defaults.string(forKey: "ADdefibrillatorId")
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
                // Handle error
                alertText = "Error: \(error.localizedDescription)"
                showAlert = true
                return
            }

            guard let data = data else {
                // Handle missing data
                alertText = "Error: Missing data"
                showAlert = true
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                // Handle successful response
                alertText = "Response: \(responseString)"
                print(responseString)
//                showAlert = true
            } else {
                // Handle invalid data
                alertText = "Error: Invalid data"
                showAlert = true
            }
        }.resume()

    }

    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack(alignment: .top) {
                    VStack() {
                        HStack() {
                            Button(action: {
                                TimerManager.shared.stopAllTimers()
                                navigationManager.pop()
                            }) {

                                Image(systemName: "arrow.left")
                                    .leftArrow()
                            }
                            Spacer()
                            Text("AED Activation")
                            Spacer()

                        }
                        .padding(.top, 0.0)
                    }
                    .frame(height: 50)
                    .navigationBarHidden(true)
                }

                if showImagePicker == true || showLibraryPicker == true {
                    Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                        .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black)
                            .ignoresSafeArea()
//                        .padding(.top, 60)
                } else {
                    
                    Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                        .clipped()
                }
                
                HStack(){
                    Button(action: {
                        print("Camera Button Click")
                        
//                        let myDefibrillators = "defibrillators
                        
//                        let selectedDefi = defaults.string(forKey: "ADdefibrillatorId")
//                        UserDefaults.standard.set(selectedDefi, forKey: "defridetailID")
//
                        showImagePicker = true

                    }, label: {

                        HStack {
                            Image(systemName: "camera")
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 10)

                    })
                    
                    
                    Button(action: {
                        print("Library Button Click")
                        
//                        let selectedDefi = defaults.string(forKey: "ADdefibrillatorId")
//                        UserDefaults.standard.set(selectedDefi, forKey: "defridetailID")
                        
                        showLibraryPicker = true

                    }, label: {

                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.title)
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 10)

                    })
                    
                    
                }
                .frame(width:widthInnerText, height: 20)
                .offset(x: 0, y: 0)
                
                
                Spacer()
                
//
                Button(action: {
                    print("Next Button Click")
                    postImageNew()
                    navigationManager.push(.adlocationsharedata)
                }, label: {
                    HStack {
                        Text("Next")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                    .padding(.bottom, 20)
                })
                                        
                    .frame(width:widthInnerText, height: 20)
                    .offset(x: 0, y: -10)


            }
            .onAppear {
                UIImagePickerController.isSourceTypeAvailable(.camera) // Check if camera is available
            }
            .background(
                Group {
                    if showImagePicker || showLibraryPicker {
                        Color.black.opacity(0.5).ignoresSafeArea()
                    }
                }
            )
            .overlay(
                Group {
                    if showImagePicker || showLibraryPicker {
                        ImagePickerView(sourceType: showImagePicker ? .camera : .photoLibrary, image: $selectedImage) { image in
                            self.selectedImage = image
                            dismissPicker()
                        }
                        .transition(.move(edge: showImagePicker ? .bottom : .top))
                    }
                }
            )
            
            .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertSuccess ? "Success" : "Error"),
                            message: Text(alertText),
                            dismissButton: .default(Text("OK")) {
                                if alertSuccess {
                                    UIPasteboard.general.string = dataToCopy
                                }
                            }
                        )
                    }
            
            
            
        }.navigationBarHidden(true)
    }
    
    private func dismissPicker() {
        showImagePicker = false
        showLibraryPicker = false
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    let sourceType: UIImagePickerController.SourceType
    @Binding var image: UIImage?
    let onImagePicked: (UIImage?) -> Void
    
    init(sourceType: UIImagePickerController.SourceType, image: Binding<UIImage?>, onImagePicked: @escaping (UIImage?) -> Void) {
        self.sourceType = sourceType
        _image = image
        self.onImagePicked = onImagePicked
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let onImagePicked: (UIImage?) -> Void
        
        init(onImagePicked: @escaping (UIImage?) -> Void) {
            self.onImagePicked = onImagePicked
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                onImagePicked(nil)
                return
            }
            onImagePicked(pickedImage)
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            onImagePicked(nil)
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
        



struct AD_19_ImagesSelectionOLD_Previews: PreviewProvider {
    static var previews: some View {
        AD_19_ImagesSelectionOLD()
            .previewDevice("iPhone SE (2nd generation)")
        AD_19_ImagesSelectionOLD()
            .previewDevice("iPhone 14 Pro")
    }
}



