//
//  CommentView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-25.
//

import SwiftUI

struct CommentView: View {
    var tweet: TweetViewModel
    var post: PostDisplayable
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var newComment = ""
    
    var body: some View {
        ScrollView {
        VStack(alignment:.leading){
            TweetRowView(post: post)
                .environmentObject(viewModel)
            Divider()
            Text("Comments")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding()
                 
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.comments) { comment in
                        TweetRowView(post: comment)
                            .environmentObject(viewModel)
                        HStack{
                            Text("\(comment.formattedDate).")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Text("From Earth.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Text("99k View.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                    
                }
            }
        .navigationBarTitle("Comments", displayMode: .inline)

            Spacer()
            
            
        }
        .onAppear{
            viewModel.fetchComments(forTweetID: tweet.id)
            print("Fetching comments for tweet ID: \(tweet.id)")
        }
        HStack{
            TextField("Post a reply", text: $newComment)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                if !newComment.isEmpty {
                    viewModel.postComment(tweetID: tweet.id, caption: newComment) { success in
                        if success{
                            print("Comment Posted")
                            newComment = ""
                            viewModel.fetchComments(forTweetID: tweet.id)
                        }else{
                            print("Fail To Post")
                        }
                    }
                }
            }, label: {
                Image(systemName: "paperplane.fill")
            })
        }
        .padding()
    }
}

//#Preview {
//    CommentView(tweet: <#TweetViewModel#>)
//}
