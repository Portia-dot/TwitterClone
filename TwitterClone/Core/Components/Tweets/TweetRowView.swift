//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    var post: PostDisplayable
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingComment = false
    @State private var isLiked = false
    @State private var likeCount = 0
    var hideButton = false

    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment: .top, spacing: 12) {
                HStack {
                    ProfileViewImage()
                    userHeader()
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                if let tweet = post as? TweetViewModel {
                    NavigationLink(destination: CommentView(tweet: tweet, post: post), isActive: $showingComment) {
                        captionView()
                            .onTapGesture {
                                if !self.showingComment {
                                    self.showingComment = true
                                }
                            }
                    }
                } else {
                    captionView()
                }

                HStack {
                    if !hideButton {
                        Button {
                            if !self.showingComment {
                                self.showingComment = true
                            }
                        } label: {
                            Image(systemName: "bubble.left")
                        }
                    }
                    Text("\(viewModel.commentCount[post.id, default: 0])")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Button {
                        viewModel.fetchComment()
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            isLiked.toggle()
                            if isLiked {
                                likeCount += 1
                            } else {
                                likeCount -= 1
                            }
                            viewModel.updateLikeStatus(for: post.id, isLiked: isLiked)
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundStyle(isLiked ? .red : .gray)
                        }
                        Text("\(likeCount)")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                    }
                }
                .padding(.top, 8)
                .foregroundStyle(.gray)
                .font(.subheadline)
            }
            .onAppear {
                viewModel.fetchCommentCount(forTweetID: post.id) { count in
                    viewModel.commentCount[post.id] = count
                }
                viewModel.fetchLikeStatus(for: post.id) { liked, count in
                    self.isLiked = liked
                    self.likeCount = count
                }
            }
        }
        .padding()
        Divider()
    }

    @ViewBuilder
    private func ProfileViewImage() -> some View {
        if let user = viewModel.currentUser {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
        } else {
            Circle()
                .frame(width: 56, height: 56)
        }
    }

    @ViewBuilder
    private func userHeader() -> some View {
        if let user = viewModel.currentUser {
            HStack {
                VStack(alignment:.leading) {
                    Text(user.fullname)
                        .font(.subheadline).bold()
                    
                    Text("@\(user.username)")
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                Spacer()
                Text(post.timeAgo)
                    .foregroundStyle(.gray)
                    .font(.caption)
                Spacer()
            }
        } else {
            HStack {
                VStack(alignment: .leading) {
                    Text("Peter Pan")
                        .font(.subheadline).bold()
                    Text("@Peter")
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                Spacer()
                Text("6h")
                    .foregroundStyle(.gray)
                    .font(.caption)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func captionView() -> some View {
        Text(post.caption)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.black)
    }
}

struct MockPost: PostDisplayable {
    var id: String = "123"
    var uid: String = "456"
    var caption: String = "This is a sample tweet for previewing purposes in SwiftUI."
    var timeStamp: Date = Date()
    var likes: Int = 10
    var formattedDate: String {
        DateFormatter.localizedString(from: timeStamp, dateStyle: .medium, timeStyle: .short)
    }
    var timeAgo: String {
        timeStamp.timeAgoDisplay()
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView(post: MockPost())
//            .environmentObject(AuthViewModel())
//            .previewLayout(.sizeThatFits)
//    }
//}
