//
//  UICoordinator.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 29/05/2024.
//

import SwiftUI
import Photos

@Observable
class UICoordinator {
    var items: [ItemPhotoTransition] = sampleItems.map({ .init(title: $0.title, image: $0.image, previewImage: $0.previewImage) })
    // Animation props
    var selectedItem: ItemPhotoTransition?
    var animatedView: Bool = false
    var showDetailView: Bool = false
    //Scroll position
    var detailScrollPosition: String?
    var detailIndicatorPosition: String?
    //Gesture props
    var offset: CGSize = .zero
    var dragProgress: CGFloat = 0
    
    init() {
        fetchImagesFromLibrary()
    }
    
    func fetchImagesFromLibrary() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                self.loadPhotos()
            } else {
                print("Access to photos is not authorized.")
            }
        }
    }

    func loadPhotos() {
        self.items.removeAll()

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        fetchResult.enumerateObjects { (asset, index, stop) in
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                if let image = image {
                    let item = ItemPhotoTransition(title: "Photo \(index + 1)", image: image, previewImage: image)
                    self.items.append(item)
                }
            }
        }
    }
    
    func didDetailPageChanged(){
        if let updateItem = items.first(where: { $0.id == detailScrollPosition }){
            selectedItem = updateItem
            //Updating indicator position
            withAnimation(.easeInOut(duration: 0.1)) {
                detailIndicatorPosition = updateItem.id
            }
        }
    }
    
     func didDetailIndicatorPageChanged(){
        if let updateItem = items.first(where: { $0.id == detailIndicatorPosition }){
            selectedItem = updateItem
            // Updating detail paging view as well
            detailScrollPosition = updateItem.id
        }
    }
    
    func tooogleView(show: Bool){
        if show{
            detailScrollPosition = selectedItem?.id
            detailIndicatorPosition = selectedItem?.id
            withAnimation(.easeIn(duration: 0.2), completionCriteria: .removed) {
                animatedView = true
            } completion: {
                self.showDetailView = true
            }
        }else{
            showDetailView = false
            withAnimation(.easeIn(duration: 0.2), completionCriteria: .removed) {
                animatedView = false
                offset = .zero
            } completion: {
                self.resetAnimationProps()
            }
        }
    }
    
    func resetAnimationProps(){
        selectedItem = nil
        detailScrollPosition = nil
        offset = .zero
        dragProgress = 0
        detailIndicatorPosition = nil
    }
}
