//
//  ImageModel.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI

struct Photo: Identifiable {
    var id = UUID()
    var clipID = UUID()
    var imageName: UIImage
}

struct Album: Identifiable {
    var id = UUID()
    var images: [Photo]
}

@Observable
class DataModel{
    static var shared = DataModel()
    
    var selectedImages: [Photo]?
    var isSheetPresented = false
    var albums: [Album] = [
        Album(images: [
            Photo(imageName: UIImage(named: "ig1")!),
            Photo(imageName: UIImage(named: "ig2")!),
            Photo(imageName: UIImage(named: "ig3")!),
            Photo(imageName: UIImage(named: "ig4")!)
        ]),
        Album(images: [
            Photo(imageName: UIImage(named: "ig5")!),
            Photo(imageName: UIImage(named: "ig6")!),
            Photo(imageName: UIImage(named: "ig7")!),
            Photo(imageName: UIImage(named: "ig8")!)
        ]),
        Album(images: [
            Photo(imageName: UIImage(named: "ig9")!),
            Photo(imageName: UIImage(named: "ig10")!),
            Photo(imageName: UIImage(named: "ig11")!)
        ]),
        Album(images: [
            Photo(imageName: UIImage(named: "ig12")!),
            Photo(imageName: UIImage(named: "ig13")!),
            Photo(imageName: UIImage(named: "ig7")!),
            Photo(imageName: UIImage(named: "ig5")!)
        ]),
        Album(images: [
            Photo(imageName: UIImage(named: "ig10")!),
            Photo(imageName: UIImage(named: "ig12")!),
            Photo(imageName: UIImage(named: "ig7")!),
            Photo(imageName: UIImage(named: "ig9")!),
            Photo(imageName: UIImage(named: "ig2")!)
        ])
    ]
}
