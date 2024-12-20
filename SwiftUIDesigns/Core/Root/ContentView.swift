//
//  ContentView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showFullBannerMoview = false
    
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
                    
                    navigationScreen("Custom Tabbar 1") {
                        CustomTabbar1()
                    }
                    
                    Text("Banner Moview")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(.rect)
                        .onTapGesture {
                            showFullBannerMoview.toggle()
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .fullScreenCover(isPresented: $showFullBannerMoview) {
                MovieBannerView()
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
