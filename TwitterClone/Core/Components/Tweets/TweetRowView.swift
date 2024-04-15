//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if let user = viewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                }else{
                    Circle()
                        .frame(width: 56, height: 56)
                }
                
                VStack(alignment: .leading , spacing: 4){
                    if let user = viewModel.currentUser {
                        HStack{
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundStyle(.gray)
                                .font(.caption)
                            Text("6h")
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }

                    }
                    Text("First Tweet")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    //Buttons
                    
                    HStack{
                        
                        //Comment
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.left")
                        }
                        
                        Spacer()
                        
                        //Retweet
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                        }
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.up.and.down.text.horizontal")
                        }
                        Spacer()
                        
                        HStack{
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
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    TweetRowView()
        .environmentObject(AuthViewModel())
}


//extension Image {
//    func systemImageStyle() -> some View {
//        self
//            .imageScale(.small)
//            .foregroundColor(.gray)
//            .font(.system(size: 20))
//    }
//}
