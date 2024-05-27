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
    var imageName: String
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
            Photo(imageName: "ig1"),
            Photo(imageName: "ig2"),
            Photo(imageName: "ig3"),
            Photo(imageName: "ig4"),
        ]),
        Album(images: [
            Photo(imageName: "ig5"),
            Photo(imageName: "ig6"),
            Photo(imageName: "ig7"),
            Photo(imageName: "ig8"),
        ]),
        Album(images: [
            Photo(imageName: "ig9"),
            Photo(imageName: "ig10"),
            Photo(imageName: "ig11")
        ]),
        Album(images: [
            Photo(imageName: "ig12"),
            Photo(imageName: "ig13"),
            Photo(imageName: "ig7"),
            Photo(imageName: "ig5"),
        ]),
        Album(images: [
            Photo(imageName: "ig10"),
            Photo(imageName: "ig12"),
            Photo(imageName: "ig7"),
            Photo(imageName: "ig9"),
            Photo(imageName: "ig2")
        ])
    ]
}
