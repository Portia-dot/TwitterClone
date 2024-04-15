//
//  UserStatView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI

struct UserStatView: View {
    var showFull: Bool
    @EnvironmentObject var viewModel : AuthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if showFull 
            {
                if let user = viewModel.currentUser {
                    Text(user.bio)
                        .font(.subheadline).bold()
                        
                }else {
                    Text("User information is not available.")
                                    .font(.subheadline).bold()
                
                }
            }

            HStack {
                Text("172")
                    .font(.subheadline).bold()
                Text("Following")
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
                Text("11.5M")
                    .font(.subheadline).bold()
                Text("Followers")
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
            }
        }
       
    }
}


#Preview {
    UserStatView(showFull: true)
        .environmentObject(AuthViewModel())
}
