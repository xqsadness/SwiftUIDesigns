//
//  CameraView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 05/07/2024.
//

import SwiftUI
import AVKit

/// Camera View Using AVCaptureVideo PreviewLayer
struct CameraView: UIViewRepresentable {
    var frameSize: CGSize
    /// Camera Session
    @Binding var session: AVCaptureSession
    func makeUIView(context: Context) -> UIView {
        /// Defining Camera Frame Size
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
