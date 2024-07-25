//
//  SignInUpHomeView.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 24/07/2024.
//

import SwiftUI

struct SignInUpHomeView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var remember = false
    @State private var showSignUp = true
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if showSignUp{
                SignUP(email: $email, password: $password, remember: $remember,showSignIn: $showSignUp){
                    
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }else{
                SignIN(email: $email, password: $password, remember: $remember, showSignUp: $showSignUp){
                    
                }
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    SignInUpHomeView()
}
