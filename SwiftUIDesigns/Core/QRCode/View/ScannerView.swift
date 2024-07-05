//
//  ScannerView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 05/07/2024.
//

import SwiftUI
import AVFoundation

//Camera permission enum
enum Permission: String{
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}

struct ScannerView: View {
    
    //QR Code scanner props
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    //QR scanner AV output
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    //Error props
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    //Camera QR output delegate
    @StateObject private var qrDelegate = QRScannerDelegate()
    //Scanned code
    @State private var scannedCode: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 8){
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundStyle(.accent)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Place the QR code inside the area")
                .font(.title3)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.top, 20)
            
            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundStyle(.gray)
            
            Spacer(minLength: 0)
            
            //Scanner
            GeometryReader{
                let size = $0.size
                
                ZStack{
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    
                    ForEach(0...4, id: \.self){ index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                // Square shape
                .frame(width: size.width, height: size.width)
                // Scanner animation
                .overlay(alignment: .top){
                    Rectangle()
                        .fill(.accent)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? size.width : 0)
                }
                // To make it center
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            
            Spacer(minLength: 15)
            
            Button{
                if !session.isRunning && cameraPermission == .approved{
                    reactiveCamera()
                    activateScannerAnimation()
                }
            }label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
            
            Spacer(minLength: 45)
        }
        .padding(15)
        //Checking camera permission, when the view is visible
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied{
                Button("Setting"){
                    let settingsString = UIApplication.openSettingsURLString
                    
                    if let settingsURl = URL(string: settingsString){
                        openURL(settingsURl)
                    }
                }
                
                Button("Cancel", role: .cancel){}
            }
        }
        .onChange(of: qrDelegate.scannedCode) { _ , newValue in
            if let code = newValue{
                scannedCode = code
                //temp
                presentError(scannedCode)
                //When the first code scan is available, immediately stop the camera
                session.stopRunning()
                //Stopping scanner animation
                deActivateScannerAnimation()
                // Clear the data on delegate
                qrDelegate.scannedCode = nil
            }
        }
    }
    
    func reactiveCamera(){
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    // Activating scanner animation method
    func activateScannerAnimation(){
        //Adding delay for each reversal
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    // De-Activating scanner animation method
    func deActivateScannerAnimation(){
        //Adding delay for each reversal
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    //Checking camera perminssion
    func checkCameraPermission(){
        Task{
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty{
                    setupCamera()
                }else{
                    session.startRunning()
                }
            case .notDetermined:
                //Requesting camera access
                if await AVCaptureDevice.requestAccess(for: .video){
                    cameraPermission = .approved
                    setupCamera()
                }else{
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    //Setting up camera
    func setupCamera(){
        do{
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else{
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else{
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async{
                session.startRunning()
            }
            
            activateScannerAnimation()
        }catch{
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
}

#Preview {
    ScannerView()
}
