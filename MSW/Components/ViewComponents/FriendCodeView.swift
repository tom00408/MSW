//
//  FriendCodeView.swift
//  MSW
//
//  Created by Tom Tiedtke on 14.01.25.
//
import Foundation
import SwiftUI
import FirebaseFirestore

struct FriendCodeView: View {
    
    @State private var friendCode = "generate Code"
    
    var body: some View {
        HStack{
            Text(friendCode)
            
            Button{
              //  generateFriendCode()
            }label:{
                Image(systemName: "plus.arrow.trianglehead.clockwise")
            }
        }
    }
    
   /* func generateFriendCode(){
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let code =  String((0..<6).map { _ in letters.randomElement()! })
        friendCode = "#"+code
        
        let db = Firestore.firestore()
            
            // User-Dokument aktualisieren
            db.collection("users").document(userID).updateData(["friendCode": friendCode]) { error in
                if let error = error {
                    print("Error beim Hochladen des FriendCodes: \(error.localizedDescription)")
                    completion(false, error)
                } else {
                    print("FriendCode erfolgreich hochgeladen: \(friendCode)")
                    completion(true, nil)
                }
            }
        
       
    }*/
}

#Preview {
    FriendCodeView()
}
