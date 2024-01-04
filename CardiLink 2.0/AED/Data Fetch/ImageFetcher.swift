//
//  ImageFetcher.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 14.06.23.
//

import Alamofire
import SwiftUI

class ImageFetcher: ObservableObject {
    @Published var downloadedImages: [DownloadedImage] = []
    
    func fetchImages(completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        guard let myURL = defaults.string(forKey: "myPortal"),
              let authKey = defaults.string(forKey: "DATASTRING"),
              let selectedDefi = defaults.string(forKey: "SelectedDefi") else {
            return
        }
        
        let endPart = "/images/"
        let urlImage = "\(myURL)defibrillators/\(selectedDefi)\(endPart)"
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
                
                let imageCount = min(dataArray.count, 3)
                var downloadedImages: [DownloadedImage] = []
                for i in 0..<imageCount {
                    guard let image = dataArray[i] as? [String: Any],
                          let id = image["id"] as? String,
                          let bytesString = image["bytes"] as? String,
                          let imageData = Data(base64Encoded: bytesString),
                          let uiImage = UIImage(data: imageData) else {
                        print("Failed to process image data")
                        continue
                    }
                    let downloadedImage = DownloadedImage(id: id, image: uiImage)
                    downloadedImages.append(downloadedImage)
                }
                DispatchQueue.main.async {
                    self.downloadedImages = downloadedImages
                    completion()
                }
            case .failure(let error):
                print("Image request error: \(error)")
            }
        }
    }
    
    @State private var isDeleting = false
    func deleteImages(imageID: String, completion: @escaping () -> Void) {
        
        self.isDeleting = true
        let defaults = UserDefaults.standard
        guard let myURL = defaults.string(forKey: "myPortal"),
              let authKey = defaults.string(forKey: "DATASTRING"),
              let selectedDefi = defaults.string(forKey: "SelectedDefi") else {
            return
        }
        
        let endPart = "/images/"
        let urlImage = "\(myURL)defibrillators/\(selectedDefi)\(endPart)\(imageID)"
        AF.request(urlImage, method: .delete, headers: [
            "authkey" : authKey,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Connection" : "keep-alive"
        ]).response { response in
            if response.error == nil {
                self.fetchImages { }
                completion()
            } else {
                print("Error: \(response.error?.localizedDescription ?? "")")
            }
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            parent.image = uiImage
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
