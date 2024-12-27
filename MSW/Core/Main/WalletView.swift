//
//  WalletView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            ScrollView{
                VStack{
                    Text("Username: \(user.username) ")
                    Text("Hier ist dein Wallet:")
                }
            }
        }
    }
}

#Preview {
    WalletView()
}
