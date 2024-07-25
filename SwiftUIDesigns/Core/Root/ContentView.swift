//
//  ContentView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome")
                    .frame(maxWidth: .infinity)
                
                List{
                    navigationScreen("Photos App Transition") {
                        PhotosAppTransitionView()
                    }
                    
                    navigationScreen("Image Gallery") {
                        ImageGalleryView()
                    }
                    
                    navigationScreen("Pixels Art Image") {
                        PixelsImage()
                    }
                    
                    navigationScreen("QR Code") {
                        HomeQRCodeView()
                    }
                    
                    navigationScreen("Login Transition") {
                        LoginTransitionView()
                    }
                    
                    navigationScreen("SignInUp Animation") {
                        SignInUpHomeView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    @ViewBuilder
    func navigationScreen<Content: View>(_ label: String, @ViewBuilder content: @escaping () -> Content) -> some View {
        NavigationLink {
            content()
                .navigationBarBackButtonHidden(true)
        } label: {
            Text("\(label)")
        }
    }
}

#Preview {
    ContentView()
}
