//
//  AD_031_VivestSerial_ScannerView.swift
//  CardiLink 2.0
//
/**
 * MIT License
 *
 * Copyright (c) 2023 by ECKO Design
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
//

import SwiftUI
import AVKit

struct AD_031_VivestSerial_ScannerView: View {
    
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var scannedCode: String = ""
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var codeScanned = false
    @State private var shouldNavigate = false
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "AED Activation".localized)
                
            }
            
            ZStack(){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .backgroundCard()
                
                VStack(spacing: 8) {
                    
                    Text("Scan Barcode")
                        .font(.headline)
                        .foregroundColor(Color.Cardi_Text_Inf)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 10.0)
                        .frame(width: widthInnerText, height: 40)
                        .offset(x: 0, y: 40)
                    
                    Text("Scanning is performed automatically")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .offset(x: 0, y: 40)
                        .padding(.bottom, 40)
                    Spacer(minLength: 0)
                    
                    GeometryReader {
                        let size = $0.size
                        let sqareWidth = min(size.width, 280)
                        
                        ZStack {
                            CameraView(frameSize: CGSize(width: sqareWidth, height: sqareWidth), session: $session, orientation: $orientation)
                                .cornerRadius(4)
                                .scaleEffect(0.97)
                            
                            ForEach(0...4, id: \.self) { index in
                                let rotation = Double(index) * 90
                                
                                RoundedRectangle(cornerRadius: 2, style: .circular)
                                    .trim(from: 0.61, to: 0.64)
                                    .stroke(Color.Cardi_MapBlue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(.init(degrees: rotation))
                            }
                        }
                        .frame(width: sqareWidth, height: sqareWidth)
                        .overlay(alignment: .top, content: {
                            Rectangle()
                                .fill(Color.Cardi_MapBlue)
                                .frame(height: 2.5)
                                .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                                .offset(y: isScanning ? sqareWidth : 0)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 45)
                    
                    Spacer(minLength: 15)
                    Button {
                        if !session.isRunning && cameraPermission == .approved {
                            reactivateCamera()
                            activateScannerAnimation()
                        }
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        navigationManager.push(.adVIViotstart)
                        
                    }) {
                        HStack {
                            Text("Next")
                                .fontWeight(.semibold)
                                .font(.title2)
                            Image(systemName: "arrowshape.forward.fill")
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    }
                    .frame(width:widthInnerText, height: 80)
                    .simultaneousGesture(TapGesture().onEnded{
                        session.stopRunning()
                        deActivateScannerAnimation()
                        qrDelegate.scannedCode = nil
                        
                    })
                    
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
        }.frame(width:width)
            .navigationBarHidden(true)
            .padding(15)
            .onAppear(perform: checkCameraPermission)
            .onDisappear {
                session.stopRunning()
            }
            .alert(errorMessage, isPresented: $showError) {
                if cameraPermission == .denied {
                    Button("Settings") {
                        let settingsString = UIApplication.openSettingsURLString
                        if let settingsURL = URL(string: settingsString) {
                            openURL(settingsURL)
                        }
                    }
                    Button("Cancel", role: .cancel) {
                    }
                }
            }
            .onChange(of: qrDelegate.scannedCode) { newValue in
                if let code = newValue {
                    scannedCode = code
                    session.stopRunning()
                    deActivateScannerAnimation()
                    qrDelegate.scannedCode = nil
                    presentError(scannedCode)
                    
                    if scannedCode == code {
                        self.shouldNavigate = true
                    }
                    
                }
            }
            .onChange(of: session.isRunning) { newValue in
                if newValue {
                    orientation = UIDevice.current.orientation
                }
            }
    }
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    reactivateCamera()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    /// Permission Denied
                    cameraPermission = .denied
                    presentError(NSLocalizedString("Please allow access to the camera", comment: ""))
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError(NSLocalizedString("Please allow access to the camera", comment: ""))
            default: break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr, .code128, .code39]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
}

