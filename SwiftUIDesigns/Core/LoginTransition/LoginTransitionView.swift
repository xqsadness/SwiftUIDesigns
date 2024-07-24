//
//  LoginTransitionView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 24/07/2024.
//

import SwiftUI

struct LoginTransitionView: View {
    
    @State private var shows = false
    @State private var bgColor = Color.red

    var body: some View {
        ZStack(alignment: .topTrailing){
            Color.gray.opacity(0.2).ignoresSafeArea()
                        
            VStack(spacing: 0) {
                ColorPicker("", selection: $bgColor)

                Group {
                    if shows {
                        SignUpView(bgColor: $bgColor)
                            .transition(.move(edge: .bottom))
                        
                        WelcomeBackView(bgColor: $bgColor) {
                            withAnimation{
                                shows.toggle()
                            }
                        }
                        .transition(.move(edge: .top))
                    } else {
                        WelcomeView(bgColor: $bgColor) {
                            withAnimation {
                                shows.toggle()
                            }
                        }
                        .transition(.move(edge: .bottom))
                        
                        SignInView(bgColor: $bgColor)
                            .transition(.move(edge: .top))
                    }
                }
            }
            .padding()
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    LoginTransitionView()
}

struct WelcomeView: View {
    @Binding var bgColor: Color
    var action: () -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .frame(height: 350)
            
            VStack {
                Text("Hello, Friend")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Enter your personal details and start \njourney with us.")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom])
                
                Button {
                    withAnimation {
                        action()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 160, height: 45)
                        Text("SIGN UP")
                            .font(.custom("Bebas Neue", size: 25))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct WelcomeBackView: View {
    @Binding var bgColor: Color
    var action: () -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .frame(height: 350)
            
            VStack {
                Text("Welcome back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("To keep connected with us please login \nwith personal info")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom])
                
                Button {
                    withAnimation {
                        action()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 160, height: 45)
                        Text("SIGN IN")
                            .font(.custom("Bebas Neue", size: 25))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct SignInView: View {
    var socialMediaIcon = ["facebook", "google", "linkedin", "apple"]
    @State var email = ""
    @State var password = ""
    @Binding var bgColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(height: 380)
            
            VStack {
                Text("Sign in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 20) {
                    ForEach(socialMediaIcon.indices, id: \.self) { item in
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(.white)
                                .shadow(color: .gray.opacity(0.5), radius: 3)
                            
                            Image(socialMediaIcon[item])
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .buttonStyle(.plain)
                
                Text("or use your account")
                    .font(.footnote)
                    .fontWeight(.regular)
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 40)
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                }
                .padding(.horizontal, 30)
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 40)
                    TextField("Password", text: $password)
                        .padding(.horizontal)
                }
                .padding(.horizontal, 30)
                
                Text("Forgot your password?")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding([.top, .bottom], 10)
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(bgColor)
                            .frame(width: 160, height: 35)
                        
                        Text("SIGN IN")
                            .font(.custom("Bebas Neue", size: 20))
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct SignUpView: View {
    var socialMediaIcon = ["facebook", "google", "linkedin", "apple"]
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Binding var bgColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(height: 380)
            
            VStack {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                HStack(spacing: 20) {
                    ForEach(socialMediaIcon.indices, id: \.self) { item in
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(.white)
                                .shadow(color: .gray.opacity(0.5), radius: 3)
                            
                            Image(socialMediaIcon[item])
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .buttonStyle(.plain)
                
                Text("or use your account")
                    .font(.footnote)
                    .fontWeight(.regular)
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 40)
                    TextField("Name", text: $name)
                        .padding(.horizontal)
                }
                .padding(.horizontal, 30)
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 40)
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                }
                .padding(.horizontal, 30)
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 40)
                    TextField("Password", text: $password)
                        .padding(.horizontal)
                }
                .padding(.horizontal, 30)
                
                Text("Forgot your password?")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding([.top, .bottom], 10)
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(bgColor)
                            .frame(width: 160, height: 35)
                        
                        Text("SIGN UP")
                            .font(.custom("Bebas Neue", size: 20))
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}
