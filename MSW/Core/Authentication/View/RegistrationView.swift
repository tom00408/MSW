

//
//  Registration.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Text("Sign Up")
                    .font(.system(size: 64))
                    .bold()
                
                Image("mswgiraffe")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(150)
                    .padding(.vertical,32)
                
                //form field
                VStack(spacing: 24){
                    ZStack(alignment: .trailing){
                        InputView(text: $email,
                                  title: "Email Adresse",
                                  placeholder: "example@gmail.com"  )
                        .autocapitalization(.none)
                        if !email.isEmpty{
                            if email.contains("@"){
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    ZStack(alignment: .trailing){
                        InputView(text: $username,
                                title: "Username",
                                placeholder: "tom123")
                        if !username.isEmpty{
                            if username.count >= 6{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                        
                    }
                    ZStack(alignment: .trailing){
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                        if !password.isEmpty{
                            if password.count >= 6{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    ZStack(alignment: .trailing){
                        InputView(text: $confirmPassword,
                                  title: "Password again",
                                  placeholder: "Confirm your password",
                                  isSecureField: true)
                        if !password.isEmpty && !confirmPassword.isEmpty{
                            if password == confirmPassword{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName:"xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                Spacer()
                //sign in button
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email, username: username, password: password)
                    }
                }label:
                {
                    HStack{
                        Text( "create account")
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
                Button{
                    dismiss()
                } label:{
                    HStack{
                        Text("Already have an account?")
                        Text("Log in")
                            .bold()
                    }
                    .font(.system(size: 14))
                    
                }
            }
        }
    }
}

extension RegistrationView: AuthenticatonFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 6
        && !username.isEmpty
        && username.count >= 5
        && confirmPassword == password
    }
}

#Preview {
    RegistrationView()
}
