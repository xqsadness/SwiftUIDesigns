//
//  SelectedStack.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct SelectedStack: View {
    
    var vm: DataModel
    var images: [Photo]
    var namespace: Namespace.ID
    @State private var selectedImage: Photo?
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(images){ image in
                        Image(image.imageName)
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: image.id, in: namespace)
                            .frame(width: 170, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .matchedGeometryEffect(id: image.clipID, in: namespace)
                            .contentShape(Rectangle(),eoFill: true)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)) {
                                    selectedImage = image
                                }
                            }
                    }
                }
            }
            .safeAreaPadding(.top, 60)
            .safeAreaPadding(.horizontal, 15)
            .overlay(alignment: .topLeading){
                DismissButton
            }
            
            if let selectedImage{
                ZStack{
                    GeometryReader{ geo in
                        Image(selectedImage.imageName)
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: selectedImage.id, in: namespace)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.1)) {
                                    self.selectedImage = nil
                                }
                            }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    var DismissButton: some View{
        Button{
            withAnimation(.spring(duration: 0.3, bounce: 0.3)){
                vm.isSheetPresented = false
            }
        }label: {
            Image(systemName: "arrow.backward")
                .padding()
                .background(.ultraThinMaterial, in: Circle())
        }
        .tint(.primary)
        .padding()
        .offset(y: -20)
    }
}

//#Preview {
//    SelectedStack()
//}
