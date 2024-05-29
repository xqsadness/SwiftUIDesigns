//
//  HeroKey.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 29/05/2024.
//

import SwiftUI

struct HeroKey: PreferenceKey{
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]){
        value.merge(nextValue()) { $1 }
    }
}
