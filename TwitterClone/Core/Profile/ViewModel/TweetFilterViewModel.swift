//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case replies
    case highlights
    case articles
    case media
    case likes
    
    var title: String {
        switch self{
        case .tweets: return "Tweets"
        case .replies:  return "Replies"
        case .highlights:  return "Highlight"
        case .articles: return "Articles"
        case .media: return "Media"
        case .likes: return "Likes"
        }
    }
}
