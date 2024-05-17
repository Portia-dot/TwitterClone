//
//  FeedView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI

struct FeedView: View {
    @State private var selectedTweet: TweetViewModel?
    @State private var showNewTweetView = false
    @EnvironmentObject var viewModel: AuthViewModel


    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView {
                if viewModel.isLoadingTweets{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }else{
                    LazyVStack{
                        ForEach(viewModel.tweets, id: \.id) { tweet in
                            TweetRowView(post: tweet)
                        }
                    }
                }
            }
            .onAppear{
                viewModel.fetchTweets()
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
                NewTweetView(mode: .tweet)
            })
        }
    }
}

//#Preview {
//    FeedView()
//        .environmentObject(AuthViewModel())
//}
