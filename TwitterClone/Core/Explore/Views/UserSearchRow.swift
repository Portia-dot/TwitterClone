//
//  UserSearchRow.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI
import Kingfisher

struct UserSearchRow: View {
    
    let user: User
    var body: some View {
        HStack (spacing: 4) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundStyle(.black)
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


