//
//  SelectedStack.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct SelectedStack: View {
    
    @State var vm: DataModel
    @Binding var idAlbum: UUID
    var images: [Photo]
    var namespace: Namespace.ID
    
    @State private var selectedImage: Photo?
    @State private var show: Bool = false
    @State private var uiImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(images){ image in
                        Image(uiImage: image.imageName)
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
            .scrollIndicators(.hidden)
            .safeAreaPadding(.top, 60)
            .safeAreaPadding(.horizontal, 15)
            .overlay(alignment: .topLeading){
                DismissButton
            }
            
            if let selectedImage{
                ZStack{
                    GeometryReader{ geo in
                        Image(uiImage: selectedImage.imageName)
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: selectedImage.id, in: namespace)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .onTapGesture(count: 1){
                                withAnimation(.linear(duration: 0.1)) {
                                    self.selectedImage = nil
                                }
                            }
                    }
                }
                .ignoresSafeArea()
                .overlay {
                    LikePhoto(show: $show)
                }
                .overlay(alignment: .topTrailing){
                    Button{
                        show = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            show = false
                        }
                    }label: {
                        Image(systemName: "heart.fill")
                            .padding()
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .tint(.primary)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    var DismissButton: some View{
        HStack{
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
            
            Spacer()
            
            Button{
                isImagePickerPresented = true
            }label: {
                Image(systemName: "plus")
                    .padding()
                    .background(.ultraThinMaterial, in: Circle())
            }
            .tint(.primary)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(onImagePicked: { image in
                    if let uiImage = image{
                        withAnimation(.smooth(duration: 0.3)) {
                            if let atAlbum = vm.albums.firstIndex(where: { $0.id == idAlbum }){
                                vm.albums[atAlbum].images.append(.init(imageName: uiImage))
                                vm.selectedImages?.append(.init(imageName: uiImage))
                            }
                        }
                    }
                })
            }
        }
        .padding()
        .offset(y: -20)
    }
}

struct LikePhoto: View {
    @Binding var show: Bool
    var body: some View {
        Image(systemName: "heart.fill").font(.system(size: 50))
            .foregroundStyle(.red)
            .scaleEffect(show ? 2 : 0)
            .animation(.easeIn(duration: 0.5), value: show)
    }
}

#Preview {
    ImageGalleryView()
}
