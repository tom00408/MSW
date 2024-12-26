//
//  LoginView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 21.12.24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Text("Login")
                    .font(.system(size: 64))
                    .bold()
                
                Image("mswgiraffe")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(150)
                    .padding(.vertical,32)
                
                //form field
                VStack(spacing: 24){
                    InputView(text: $email,title: "Email Adresse", placeholder: "Email"  ).autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                Spacer()
                //sign in button
                Button{
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                }label:
                {
                    HStack{
                        Text( "Sign in")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 48)
                    
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                .cornerRadius(10)
                
                Spacer()
                //sign up button
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label:{
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign up")
                            .bold()
                    }
                    
                }
            }
        }
    }
}

extension LoginView: AuthenticatonFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 6
    }
}

#Preview {
    LoginView()
}
