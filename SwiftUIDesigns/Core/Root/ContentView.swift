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
            List{
                navigationScreen("Photos App Transition") {
                    PhotosAppTransitionView()
                }
                
                navigationScreen("Image Gallery") {
                    ImageGalleryView()
                }
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
