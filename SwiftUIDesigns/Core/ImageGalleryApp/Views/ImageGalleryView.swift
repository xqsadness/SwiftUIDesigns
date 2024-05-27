//
//  ImageGalleryView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct ImageGalleryView: View {
    
    @State var vm = DataModel()
    @Namespace var namespace
    
    var body: some View {
        if !vm.isSheetPresented{
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(vm.albums){ album in
                        ImageStack(images: album.images, namespace: namespace)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)){
                                    self.vm.selectedImages = album.images
                                    self.vm.isSheetPresented = true
                                }
                            }
                    }
                }
                .safeAreaPadding(.trailing, 30)
                .safeAreaPadding(.top, 40)
            }
        }else{
            if let image = vm.selectedImages{
                SelectedStack(vm: vm, images: image, namespace: namespace)
            }
        }
    }
}

#Preview {
    ImageGalleryView()
}
