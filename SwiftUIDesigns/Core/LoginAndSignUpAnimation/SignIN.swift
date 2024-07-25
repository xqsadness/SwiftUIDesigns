//
//  SignIN.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 24/07/2024.
//

import SwiftUI

struct SignIN: View {
    @FocusState var isActive
    @Binding var email: String
    @Binding var password: String
    @Binding var remember: Bool
    @Binding var showSignUp: Bool
    @State var showForgotView: Bool = false
    var action: () -> Void
    var body: some View {
        VStack(spacing: 45){
            TopView(title: "Welcome back", details: "Please sign up in to your account")
            
            InfoTF(title: "Email", text: $email)
            
            VStack(spacing: 24){
                PasswordTF(title: "Password", text: $password)
                
                HStack{
                    Toggle(isOn: $remember) {
                        Text("Label")
                    }
                    .toggleStyle(RememberStyle())
                    
                    Spacer()
                    
                    Button{
                        showForgotView.toggle()
                    }label: {
                        Text("Forgot Password")
                            .bold()
                            .font(.footnote)
                    }
                    .tint(.primary)
                }
            }
            
            SignButton(title: "Sign In") {
                
            }
            
            OrView(title: "or")
            
            HStack(spacing: 65){
                SignAccount(image: .apple, width: 32, height: 32) {
                    
                }  
                
                SignAccount(image: .facebook, width: 32, height: 32) {
                    
                } 
                
                SignAccount(image: .google, width: 32, height: 32) {
                    
                }
            }
            
            Spacer()
            
            Button{
                email = ""
                password = ""
                withAnimation {
                    showSignUp.toggle()
                }
            }label: {
                Text("Don't have an account? ***Sign up***")
            }
            .tint(.primary)
        }
        .padding()
        .sheet(isPresented: $showForgotView){
            ForgotView()
                .presentationDetents([.fraction(0.40)])
        }
    }
}

#Preview {
    SignInUpHomeView()
}

struct TopView: View {
    var title: String
    var details: String
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(title).font(.title.bold())
            
            Text(details)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct InfoTF: View {
    var title: String
    @Binding var text: String
    @FocusState var isActive
    var body: some View {
        ZStack(alignment: .leading){
            TextField("", text: $text)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .focused($isActive)
                .background(.gray.opacity(0.3), in: .rect(cornerRadius: 16))
            
            Text(title)
                .padding(.leading)
                .offset(y: (isActive || !text.isEmpty) ? -50 : 0)
                .animation(.spring, value: isActive)
                .foregroundStyle(isActive ? .white : .secondary)
                .onTapGesture {
                    isActive = true
                }
        }
    }
}

struct RememberStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        }label: {
            HStack{
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .contentTransition(.symbolEffect)
                Text("Remember")
            }
        }
        .tint(.primary)
    }
}

struct SignButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button{
            
        }label: {
            Text(title)
                .foregroundStyle(.bgr)
                .font(.title2).bold()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.primary, in: .rect(cornerRadius: 16))
        }
        .tint(.primary)
    }
}

struct OrView: View {
    var title: String
    var body: some View {
        HStack{
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.gray.opacity(0.3))
            
            Text(title)
            
            Rectangle()
                .frame(height: 1.5)
                .foregroundStyle(.gray.opacity(0.3))
        }
    }
}

struct SignAccount: View {
    var image: ImageResource
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    var body: some View {
        Button{
            
        }label: {
            Image(image)
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.gray.opacity(0.3))
                }
        }
        .tint(.primary)
    }
}
