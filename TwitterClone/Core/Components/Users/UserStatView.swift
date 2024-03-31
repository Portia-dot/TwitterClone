//
//  UserStatView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI

struct UserStatView: View {
    var body: some View {
        HStack{
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
        .padding(.vertical)
    }
}

#Preview {
    UserStatView()
}
