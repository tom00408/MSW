//
//  InputView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 21.12.24.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title : String
    let placeholder : String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading,spacing: 12){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if(isSecureField){
                SecureField(placeholder,text: $text)
                    .font(.system(size: 14))
            }else{
                TextField(placeholder,text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Adress", placeholder: "name@example.com")
}
