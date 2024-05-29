//
//  RootAppView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 28/05/2024.
//

import SwiftUI

struct RootAppView: View {
    
    @AppStorage("FIRST_LOAD_APP") var FIRST_LOAD_APP = true
    @State private var show = false
    
    var body: some View {
        if FIRST_LOAD_APP {
            OnboardingView()
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        }else{
            ZStack{
                if show{
                    ContentView()
                }else{
                    LaunchScreenView()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
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

#Preview {
    RootAppView()
}
