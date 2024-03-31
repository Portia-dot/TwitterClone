//
//  Trending.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI

struct Trending: View {
    var title: String
    var category: String
    var posts: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5)
        {
            HStack{
                Text(category)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .foregroundStyle(.gray)
            .font(.footnote)
            .fontWeight(.bold)
            .bold()
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .bold()
            Text(posts)
                .foregroundStyle(.gray)
                .font(.footnote)
                .fontWeight(.bold)
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
    }
}

#Preview {
    Trending(title: "Wizkid", category: "Music . Trending", posts: "19.4k posts")
}
