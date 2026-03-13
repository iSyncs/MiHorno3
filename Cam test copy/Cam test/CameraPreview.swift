//
//  CameraPreview.swift
//  Cam test
//
//  Created by user278466 on 3/11/26.
//


import SwiftUIimport AVFoundationstruct CameraPreview: UIViewRepresentable {        let session: AVCaptureSession        func makeUIView(context: Context) -> UIView {                let view = UIView(frame: .zero)                let previewLayer = AVCaptureVideoPreviewLayer(session: session)        previewLayer.videoGravity = .resizeAspectFill                view.layer.addSublayer(previewLayer)                DispatchQueue.main.async {            previewLayer.frame = view.bounds        }                return view    }        func updateUIView(_ uiView: UIView, context: Context) { }}