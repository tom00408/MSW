//
//  AuthViewModel.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticatonFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String,password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEGUG: Failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String,username: String,password: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, username: username)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            await fetchUser()
        }catch{
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut() //signs out user on backend
            self.userSession = nil // wipes out usersession und takes us back to login screen
            self.currentUser = nil // wipes out currenUser DataModel
        }catch
        {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("User is currently\(String(describing: self.currentUser))")
    }
    
    
    
    
    
    func updateUserCryptos(userId: String, bitcoin: Int, ethereum: Int, solana: Int) async throws {
        let db = Firestore.firestore()
        try await db.collection("users").document(userId).updateData([
            "bitcoin": bitcoin,
            "ethereum": ethereum,
            "solana": solana
        ])
        // Aktualisiere das lokale Modell
        currentUser?.bitcoin = bitcoin
        currentUser?.ethereum = ethereum
        currentUser?.solana = solana
    }
    
}
