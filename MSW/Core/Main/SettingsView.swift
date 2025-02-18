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
    
    @State var showingResetAlert: Bool = false
    @State var showingTrollAlert: Bool = false
    
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
                                //.foregroundColor(.black)
                                .accentColor(.gray)
                                .fontWeight(.bold)
                        }
                    }
                }
              
                
                
                Section("General"){
                        
                    SettingsRowView(imageName: "gear", title: "Version", description: "1.1.1",color: Color.white)
                        
                    
                }
                
                Section("App"){
                    //RESET WALLET
                    
                    Button{
                        print("Wallet resetet")
                        showingResetAlert = true
                    }label: {
                        SettingsRowView(imageName:"arrow.trianglehead.clockwise", title:"Reset Wallet" , description: "",color: Color.blue)
                    }
                    .accentColor(Color.primary)
                    .alert("Wallet Reset?",isPresented: $showingResetAlert){
                        Button("Bestätigen"){
                            Task{
                                try await walletReset()
                            }
                        }
                        Button("Nein",role:.cancel){}
                    } message: {
                        Text("Willst du dein Wallet auf 1000€ resetten?")
                    }
                    
                    //TROLL WALLET SYNC
                    
                    Button{
                        print("Troll Wallet")
                        showingTrollAlert = true
                    }label: {
                        SettingsRowView(imageName:"arrow.down.heart", title:"Load TR Wallet" , description: "",color: Color.blue)
                    }
                    .accentColor(Color.primary)
                    .alert("TR Wallet laden?",isPresented: $showingTrollAlert){
                        Button("Bestätigen"){
                            Task{
                                try await loadTrollWallet()
                            }
                        }
                        Button("Nein",role:.cancel){}
                    } message: {
                        Text("TR Wallet laden?")
                    }
                    
                    
                }
                
                
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    }label: {
                        SettingsRowView(imageName:"arrow.left.circle.fill", title:"Log out" , description: "",color: Color.red)
                    }
                    .accentColor(Color.primary)
                    Button{
                        print("Delete Account")
                    }label: {
                        SettingsRowView(imageName:"xmark.circle.fill", title:"Delete Account" , description: "",color: Color.red)
                    }
                    .accentColor(Color.primary)
                }
            }
        }else{
            NavigationStack{
                VStack{
                    Text("Nutzerdaten konnten nicht geladen werden :(")
                    /*NavigationLink(destination: LoginView()){
                        Text("Zum Login")
                            .foregroundColor(.blue)
                    }*/
                    Button{
                        viewModel.userSession = nil
                    }label:{
                        Text("Zum Login")
                    }
                }
            }
        }
    }
    
    func walletReset() async{
        do{
            try await viewModel.updatePersonalWallet(
                userId: (viewModel.currentUser?.getId())!,
                coins: ["EUR":1000]
            )
        }catch{
            print("Wallet konnte nicht resettet werden")
        }
    }
    
    func loadTrollWallet() async{
        do{
            try await viewModel.updatePersonalWallet(
                userId: (viewModel.currentUser?.getId())!,
                coins: ["BTC": 0.000853, "ETH" : 0.00859, "SOL": 10])
        }catch{
            print("TR WALlet konnte nicht geladen werden")
        }
    }
    
}

#Preview {
    SettingsView()
}
