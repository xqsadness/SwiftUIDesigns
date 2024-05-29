//
//  HeroLayer.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 29/05/2024.
//

import SwiftUI

struct HeroLayer: View {
    
    @Environment(UICoordinator.self) private var coordinator
    var item: ItemPhotoTransition
    var sAnchor: Anchor<CGRect>
    var dAnchor: Anchor<CGRect>

    var body: some View {
        GeometryReader{ proxy in
            let sRect = proxy[sAnchor]
            let dRect = proxy[dAnchor]
            let animatedView = coordinator.animatedView
            
            let viewSize: CGSize = .init(
                width: animatedView ? dRect.width : sRect.width,
                height: animatedView ? dRect.height : sRect.height
            )
            let viewPosition: CGSize = .init(
                width: animatedView ? dRect.minX : sRect.minX,
                height: animatedView ? dRect.minY : sRect.minY
            )
            
            if let image = item.image, !coordinator.showDetailView{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: animatedView ? .fit : .fill)
                    .frame(width: viewSize.width, height: viewSize.height)
                    .clipped()
                    .offset(viewPosition)
                    .transition(.identity)
            }
        }
    }
}

#Preview {
    PhotosAppTransitionView()
}
