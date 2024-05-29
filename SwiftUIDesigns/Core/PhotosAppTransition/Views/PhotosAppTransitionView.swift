//
//  PhotosAppTransitionView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 29/05/2024.
//

import SwiftUI

struct PhotosAppTransitionView: View {
    
    @Environment(\.dismiss) var dismiss
    var coordinator: UICoordinator = .init()
    
    var body: some View {
        @Bindable var bindableCoordinator = coordinator
        ScrollViewReader{ reader in
            ScrollView(.vertical){
                LazyVStack(alignment: .leading, spacing : 0){
                    Text("Back")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 3), count: 3), spacing: 3){
                        ForEach($bindableCoordinator.items){ $item in
                            GridImageView(item)
                                .id(item.id)
                                .didFrameChange{ frame, bounds in
                                    let minY = frame.minY
                                    let maxY = frame.maxY
                                    let height = bounds.height
                                    
                                    if maxY < 0 || minY > height{
                                        item.appeared = false
                                    }else{
                                        item.appeared = true
                                    }
                                }
                                .onDisappear{
                                    item.appeared = false
                                }
                                .onTapGesture {
                                    coordinator.selectedItem = item
                                }
                        }
                    }
                    .padding(.vertical, 15)
                }
            }
            .onChange(of: coordinator.selectedItem) { old, new in
                if let item = coordinator.items.first(where: {$0.id == new?.id}), !item.appeared{
                    //Scroll to this item as this it not visible on the screen
                    reader.scrollTo(item.id, anchor: .bottom)
                }
            }
        }
        .overlay{
            Rectangle()
                .fill(.background)
                .ignoresSafeArea()
                .opacity(coordinator.animatedView ? 1 - coordinator.dragProgress : 0)
        }
        .environment(coordinator)
        .allowsHitTesting(coordinator.selectedItem == nil)
        .overlay {
            if coordinator.selectedItem != nil{
                DetailPhotosView()
                    .environment(coordinator)
                    .allowsHitTesting(coordinator.showDetailView)
            }
        }
        .overlayPreferenceValue(HeroKey.self) { value in
            if let selectedItem = coordinator.selectedItem,
               let sAnchor = value[selectedItem.id + "SOURCE"],
               let dAnchor = value[selectedItem.id + "DEST"]{
                HeroLayer(
                    item: selectedItem,
                    sAnchor: sAnchor,
                    dAnchor: dAnchor
                )
                .environment(coordinator)
            }
        }
    }
    //Image view for grid
    @ViewBuilder
    func GridImageView(_ item: ItemPhotoTransition) -> some View{
        GeometryReader{
            let size = $0.size
            
            Rectangle()
                .fill(.clear)
                .anchorPreference(key: HeroKey.self,value: .bounds, transform: { anchor in
                    return [item.id + "SOURCE": anchor]
                })
            
            if let previewImage = item.previewImage{
                Image(uiImage: previewImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .opacity(coordinator.selectedItem?.id == item.id ? 0 : 1)
            }
        }
        .frame(height: 130)
        .contentShape(.rect)
    }
}

#Preview {
    PhotosAppTransitionView()
}
