//
//  ProfilView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    //var user = User.TOM
    
    var body: some View {
        if let user = viewModel.currentUser {
        //if true{
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
                Section("Liga"){
                    VStack{
                        SettingsRowView(imageName: "plus.circle", title: "Erstelle eine neue Liga", description: "", color: Color.green)
                        SettingsRowView(imageName: "arrowshape.forward.circle", title: "Trete einer Liga being", description: "", color: Color.green)
                    }
                }
                
                
                Section("General"){
                        
                    SettingsRowView(imageName: "gear", title: "Version", description: "1.1.1",color: Color.white)
                        
                    
                }
                
                
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    }label: {
                        SettingsRowView(imageName:"arrow.left.circle.fill", title:"Log out" , description: "",color: Color.red)
                    }
                    .accentColor(Color.black)
                    Button{
                        print("Delete Account")
                    }label: {
                        SettingsRowView(imageName:"xmark.circle.fill", title:"Delete Account" , description: "",color: Color.red)
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
