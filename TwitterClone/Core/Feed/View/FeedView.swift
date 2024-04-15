//
//  FeedView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false

    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView {
                LazyVStack{
                    ForEach(0 ... 20 , id: \.self) { _ in
                       TweetRowView() 
                    }
                }
            }
            Button {
                showNewTweetView.toggle()
            }label: {
               Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
                    .foregroundStyle(Color.white)
            }
            .background(Color(.systemBlue))
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView, content: {
               NewTweetView()
            })
        }
    }
}

#Preview {
    FeedView()
        .environmentObject(AuthViewModel())
}
