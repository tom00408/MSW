//
//  ProfilView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack{
                        
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text(user.username)
                                .font(.headline)
                                .fontWeight(.semibold)
                                
                            Text(user.email)
                                .font(.caption)
                                .foregroundColor(.black)
                                .accentColor(.gray)
                                .fontWeight(.bold)
                        }
                    }
                }
                Section("General"){
                        
                        SettingsRowView(imageName: "gear", title: "Version", description: "1.1.1")
                        
                    
                }
                
                
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    }label: {
                        SettingsRowView(imageName:"arrow.left.circle.fill", title:"Log out" , description: "")
                    }
                    .accentColor(Color.black)
                    Button{
                        print("Delete Account")
                    }label: {
                        SettingsRowView(imageName:"xmark.circle.fill", title:"Delete Account" , description: "")
                    }
                    .accentColor(Color.black)
                }
            }
        }else{
            HStack{
                Text("Nutzerdaten konnten nicht geladen werden :(")
            }
        }
    }
}

#Preview {
    SettingsView()
}
