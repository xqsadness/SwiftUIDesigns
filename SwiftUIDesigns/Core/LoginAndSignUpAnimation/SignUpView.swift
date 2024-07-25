//
//  SignUpView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 24/07/2024.
//

import SwiftUI

struct SignUP: View {
    @FocusState var isActive
    @Binding var email: String
    @Binding var password: String
    @Binding var remember: Bool
    @Binding var showSignIn: Bool
    var action: () -> Void
    var body: some View {
        VStack(spacing: 45){
            TopView(title: "Create new account", details: "Please fill in the form to continue")
            
            InfoTF(title: "Email", text: $email)
            
            PasswordCheckField()
            
            SignButton(title: "Sign Up") {
                
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
            
//            Spacer()
            
            Button{
                email = ""
                password = ""
                withAnimation {
                    showSignIn.toggle()
                }
            }label: {
                Text("Aleady have an account? ***Sign in***")
            }
            .tint(.primary)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInUpHomeView()
}
