//
//  SwiftUIDesignsApp.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 27/05/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftUIDesignsApp: App {
    
    @State private var show = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{ 
                if show{
                    ContentView()
                }else{
                    LaunchScreenView()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7){
                    withAnimation {
                        show = true
                    }
                }
            }
        }
    }
}
