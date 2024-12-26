//
//  MSWApp.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI
import Firebase
@main
struct MSWApp: App {
        
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
