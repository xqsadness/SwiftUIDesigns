//
//  Onboarding.swift
//  MusicPlayer2024
//
//  Created by xqsadness on 23/05/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("FIRST_LOAD_APP") var FIRST_LOAD_APP = true
    //view props
    @State private var dragAmout = CGSize.zero
    @State private var progress: CGFloat = 0
    private var maxDragAmout: CGFloat = 70
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .center){
                Text("Welcome to my app")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.black)
                
                Image(.welcome)
                    .resizable()
                    .frame(height: 220)
                    .frame(maxHeight:.infinity)
                
                VStack(spacing: 15){
                    progressView
                        .scaleEffect(max(1 + progress / 10,1))
                    
                    Text("Feel free to enjoy your music")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                    
                    HStack(spacing: 16){
                        Text("Slide to start")
                            .font(.system(size: 14))
                            .foregroundStyle(.black)
                        
                        Image(systemName: "arrow.forward")
                            .imageScale(.medium)
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(16)
                    }
                    .offset(x: max(0, dragAmout.width))
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                withAnimation{
                                    let translationWidth = value.translation.width
                                    self.dragAmout.width = min(translationWidth, maxDragAmout)
                                    self.progress = min(1, self.dragAmout.width / maxDragAmout)
                                }
                            }
                            .onEnded{ _ in
                                if self.progress >= 1{
                                    withAnimation(.smooth){
                                        self.dragAmout = .zero
                                        FIRST_LOAD_APP = false
                                    }
                                }else{
                                    withAnimation(.linear){
                                        self.dragAmout = .zero
                                        self.progress = 0
                                    }
                                }
                            }
                    )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    var progressView: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.accentColor, style: StrokeStyle (lineWidth: 6, lineCap: .round, lineJoin: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.degrees (-90))
                .background(
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundStyle(.gray).opacity(0.7)
                )
            
            Image(systemName: "checkmark").bold()
                .font(.system(size: 26))
                .foregroundStyle(.black).opacity(0.7)
        }
        .rotationEffect(.degrees (10), anchor: .bottomTrailing)
    }
}
#Preview {
    OnboardingView()
}
