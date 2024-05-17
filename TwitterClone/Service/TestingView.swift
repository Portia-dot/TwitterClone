//
//  TestingView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-19.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(0 ... 9, id: \.self) { index in
                        NavigationLink(destination: DetailView(title: "Wizkid \(index)")) {
                            TrendingTesting(title: "Wizkid \(index)", category: "Music . Entertainment", posts: "\(2 * index)M posts")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Trending")
        }
    }
}

struct TrendingTesting: View {
    var title: String
    var category: String
    var posts: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(category)
                .font(.subheadline)
            Text(posts)
                .font(.subheadline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    TestingView()
}




struct DetailView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.largeTitle)
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

