//
//  SettingsRowView.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName :String
    let title :String
    let description :String
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
              
            Text(title)
                .font(.headline)
            Spacer()
            Text(description)
                .foregroundColor(Color.black)
        }
    }
        
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", description:   "1.0.0")
}
