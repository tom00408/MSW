//
//  LeagueView.swift
//  MSW
//
//  Created by Tom Tiedtke on 27.12.24.
//

import SwiftUI

struct FriendView: View {
    var body: some View {
        ZStack{
            Image("friends")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(0.5)
            ScrollView{
                VStack{
                    HStack{
                        Button{
                            print("Add Friend")
                        }label:{
                            HStack{
                                //Text("Add Friend")
                                Image(systemName: "person.2.badge.plus.fill")
                                    .foregroundColor(Color.primary)
                                    .font(.system(size: 30))
                            }
                            
                        }
                    }
                    .padding()
                    //Wallet Views aller Freunde
                    WalletValueView(user: User.TOM)
                    WalletValueView(user: User.matte)
                }.padding()
            }
        }
    }
}

#Preview {
    FriendView()
}












