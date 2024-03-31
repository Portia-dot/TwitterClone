//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundStyle(Color(.systemBlue))
                
                VStack(alignment: .leading , spacing: 4){
                    HStack{
                        Text("Bruce Lee")
                            .font(.subheadline).bold()
                        
                        Text("@TimeTriping.")
                            .foregroundStyle(.gray)
                            .font(.caption)
                        Text("6h")
                            .foregroundStyle(.gray)
                            .font(.caption)
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
}


//extension Image {
//    func systemImageStyle() -> some View {
//        self
//            .imageScale(.small)
//            .foregroundColor(.gray)
//            .font(.system(size: 20))
//    }
//}
