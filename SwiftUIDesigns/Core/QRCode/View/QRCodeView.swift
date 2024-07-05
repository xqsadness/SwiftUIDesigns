//
//  QRCodeView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 05/07/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct HomeQRCodeView: View {
    
    @State private var text = ""
    @State private var isShowingQRCode = false
    @State private var isShowScanner = false
    
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Button{
                    isShowScanner = true
                }label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                Text("QR Code generator")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.top)
                
                TextField("Enter text for QR Code", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)){
                        isShowingQRCode.toggle()
                    }
                }label: {
                    Text("Generate QR Code")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(.green)
                        .cornerRadius(10)
                        .padding(.top)
                }
                
                if isShowingQRCode{
                    QRCodeView(text: text)
                        .transition(AnyTransition.asymmetric(insertion: .scale(scale: 0.01).combined(with: .opacity), removal: .move(edge: .bottom).combined(with: .opacity)))
                }
                
                Spacer()
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isShowScanner){
            ScannerView()
        }
    }
}

struct QRCodeView: View {
    
    var text: String
    
    var body: some View {
        VStack{
            Text("QR Code").bold()
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top)
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
                .frame(width: 250, height: 250)
                .overlay {
                    Image(uiImage: generateQRCode(from: text))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0 ,y: 10)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage{
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    HomeQRCodeView()
}
