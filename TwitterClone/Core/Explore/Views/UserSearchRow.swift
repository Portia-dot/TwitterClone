//
//  UserSearchRow.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI

struct UserSearchRow: View {
    let viewModel : UserSearchVM
    var body: some View {
        HStack (spacing: 4) {
            Circle()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.name)
                    .font(.subheadline).bold()
                    .foregroundStyle(.black)
                Text(viewModel.userName)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    UserSearchRow(viewModel: UserSearchVM(id: 1, name: "John Doe", userName: "@Jdoe"))
}
