//
//  PixelsImage.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 14/06/2024.
//

import SwiftUI
import PhotosUI

struct PixelsImage: View {
    
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var originalImage: UIImage?
    @State private var pixelatedImage: UIImage?
    @State private var cropInsets: CGFloat = 0.0
    @State private var pixelationScale: CGFloat = 0.0
    @State private var isPhotoPickerPresented = false
    @State private var imageSaved = false
    
    var body: some View {
        VStack(spacing: 60){
            Spacer()
            if let pixelatedImage = pixelatedImage{
                ImageView(image: pixelatedImage)
                    .photosPicker(isPresented: $isPhotoPickerPresented, selection: $selectedPhotoItem, matching: .images)
                    .onTapGesture {
                        isPhotoPickerPresented.toggle()
                    }
            }else if let originalImage = originalImage{
                ImageView(image: originalImage)
            }else{
                ZStack{
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3)
                        .frame(width: 300, height: 400)
                        .background(.thinMaterial, in: .rect(cornerRadius: 20))
                    
                    Image(systemName: "plus")
                        .font(.system(size: 120, weight: .ultraLight))
                }
                .foregroundStyle(.gray)
                .photosPicker(isPresented: $isPhotoPickerPresented, selection: $selectedPhotoItem, matching: .images)
                .onTapGesture {
                    isPhotoPickerPresented.toggle()
                }
            }
            
            Spacer()
            
            Slider(value: $pixelationScale, in: 0...200, step: 1){
                Text("Pixelation Scale")
            }
            
            Button{
                if let image = pixelatedImage{
                    saveImageToPhoto(image: image)
                    imageSaved = true
                }
            }label: {
                ZStack{
                    Color.clear
                        .frame(maxWidth: .infinity)
                        .frame(height: 55).background(.thinMaterial, in: .rect(cornerRadius: 10))
                    
                    if !imageSaved{
                        Text("Save image")
                            .bold().font(.title2)
                    }else{
                        Image(systemName: "checkmark.circle")
                            .font(.title)
                            .foregroundStyle(.green)
                    }
                }
            }
            .disabled(pixelatedImage == nil)
            .tint(.primary)
            
            Spacer()
                .onChange(of: pixelationScale) { old, new in
                    if let image = originalImage{
                        pixelatedImage = applyPixellateFilter(image: image, scale: new, cropInsets: 0)
                    }
                }
        }
        .padding(.horizontal, 20)
        .onChange(of: selectedPhotoItem) { oldValue, newValue in
            Task{
                if let data = try? await newValue?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data){
                    originalImage = uiImage
                    pixelatedImage = nil
                }
            }
            imageSaved = false
            pixelationScale = 0
        }
    }
    
    func applyPixellateFilter(image: UIImage, scale: CGFloat, cropInsets: CGFloat) -> UIImage? {
        guard let inputImage = CIImage(image: image) else { return nil }
        let croppedImage = inputImage.cropped (to: CGRect(
            x: cropInsets,
            y: cropInsets,
            width: inputImage.extent.width - 2 * cropInsets,
            height: inputImage.extent.height - 2 * cropInsets
        ))
        guard let filter = CIFilter (name: "CIPixellate") else { return nil }
        filter.setValue(croppedImage, forKey: kCIInputImageKey)
        filter.setValue(scale, forKey: kCIInputScaleKey)
        let context = CIContext()
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: croppedImage.extent) else {
            return nil
        }
        let pixelatedUIImage = UIImage(cgImage: cgImage)
        
        // Resize back to original size with transparent edges
        let renderer = UIGraphicsImageRenderer (size: image.size)
        let finalImage = renderer.image { _ in
            image.draw(at: .zero)
            pixelatedUIImage.draw(in: CGRect(
                x: cropInsets,
                y: cropInsets,
                width: image.size.width - 2 * cropInsets,
                height: image.size.height - 2 * cropInsets
            ))
        }
        return finalImage
    }
    
    private func saveImageToPhoto(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct ImageView: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable().scaledToFill()
            .frame(width: 300, height: 400)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    PixelsImage()
}
