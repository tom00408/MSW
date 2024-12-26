//
//  ContentView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 21.12.24.
//

import SwiftUI
import Firebase
struct ContentView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                MainView()
            }else{
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
