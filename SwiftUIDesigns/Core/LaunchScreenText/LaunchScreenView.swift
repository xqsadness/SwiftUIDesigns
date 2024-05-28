//
//  LaunchScreenView.swift
//  SwiftUIDesigns
//
//  Created by darktech4 on 28/05/2024.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var show = false
    let title = "Hello world"
    private var initalDelays = [0.0, 0.04, 0.012, 0.18,0.28, 0.35]
    
    var body: some View {
        ZStack{
            ZStack{
                AnimatedTitleView(title: title, color: .cyan, initialDelay: initalDelays[5], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .red, initialDelay: initalDelays[4], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .yellow, initialDelay: initalDelays[3], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .pink, initialDelay: initalDelays[2], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .green, initialDelay: initalDelays[1], animationType: .spring(duration: 1))
            }
            AnimatedTitleView(title: title, color: .accent, initialDelay: initalDelays[0], animationType: .spring)
        }
    }
}

struct AnimatedTitleView: View {
    let title: String
    let color: Color
    let initialDelay: Double
    let animationType: Animation
    @State var scall = false
    @State private var show = false
    private var delayStep = 0.1
    init(title: String, color: Color, initialDelay: Double, animationType: Animation) {
        self.title = title
        self.color = color
        self.initialDelay = initialDelay
        self.animationType = animationType
    }
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id: \.self) { index in
                Text(String (title [title.index(title.startIndex, offsetBy: index)]))
                    .font(.system(size: 75)).bold()
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? -30 : 30)
                    .animation (animationType.delay (Double (index) * delayStep + initialDelay),value: show)
                    .foregroundStyle(color)
            }
        }
        .scaleEffect(scall ? 0.8 : 1)
        .onAppear() {
            show.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                withAnimation {
                    scall.toggle()
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
