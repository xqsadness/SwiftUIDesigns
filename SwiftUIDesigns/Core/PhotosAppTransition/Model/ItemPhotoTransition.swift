//
//  ItemPhotoTransition.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 29/05/2024.
//

import SwiftUI

struct ItemPhotoTransition: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var image: UIImage?
    var previewImage: UIImage?
    var appeared: Bool = false
}

var sampleItems: [ItemPhotoTransition] = [
    .init(title: "Fancy hu",image: UIImage(named: "ig1")),
    .init(title: "Joe Adam",image: UIImage(named: "ig2")),
    .init(title: "Kenedy",image: UIImage(named: "ig3")),
    .init(title: "Nza",image: UIImage(named: "ig4")),
    .init(title: "The expensive",image: UIImage(named: "ig5")),
    .init(title: "Jeel",image: UIImage(named: "ig6")),
    .init(title: "Lorem isump",image: UIImage(named: "ig7")),
    .init(title: "Han-child",image: UIImage(named: "ig8")),
    .init(title: "Snow fall",image: UIImage(named: "ig9")),
    .init(title: "I am blue",image: UIImage(named: "ig10")),
    .init(title: "Named",image: UIImage(named: "ig7")),
    .init(title: "Alpha",image: UIImage(named: "ig2")),
    .init(title: "Mobile legend",image: UIImage(named: "ig9")),
    .init(title: "Sadness",image: UIImage(named: "ig11")),
    .init(title: "Changes",image: UIImage(named: "ig12")),
    .init(title: "Mnnnackttce",image: UIImage(named: "ig13"))
]
