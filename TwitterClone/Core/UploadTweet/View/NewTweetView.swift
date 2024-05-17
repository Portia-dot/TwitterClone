//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-12.
//

import SwiftUI
import Kingfisher

enum PostMode{
    case tweet, comment
}

struct NewTweetView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    var tweetID: String?
    var mode: PostMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        switch mode{
                        case .tweet:
                            viewModel.postTweet(caption: caption) {tweetID, success in
                                if success{
                                    dismiss()
                                }else{
                                    //Handle This Later
                                    print("Error")
                                }
                            }
                        case .comment:
                            if let tweetID = self.tweetID{
                                viewModel.postComment(tweetID : tweetID, caption: caption)  {
                                    success in
                                    if success{
                                        dismiss()
                                    }else{
                                        //Handle This Later
                                        print("Error")
                                    }
                                }
                            }else{
                                print("Tweet Id is missing")
                            }
                        }
                    }) {
                        Text(mode == .tweet ? "Tweet" : "Comment")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
                .padding()
                
                HStack(alignment: .top) {
                    if let user = viewModel.currentUser{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
    
                    TextArea("What's happening?", text: $caption)
                        .frame(minHeight: 100)
                        .bold()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    NewTweetView(mode: .comment)
        .environmentObject(AuthViewModel())
}
