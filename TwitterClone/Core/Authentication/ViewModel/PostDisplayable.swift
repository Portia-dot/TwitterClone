//
//  PostDisplayable.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-25.
//

import Foundation

protocol PostDisplayable {
    var id: String {get}
    var uid: String {get}
    var caption: String {get}
    var timeStamp: Date {get}
    var likes: Int {get}
    var formattedDate: String {get}
    var timeAgo: String {get}
//    var commentCount: Int { get } 
}

extension TweetViewModel: PostDisplayable {}
extension CommentViewModel: PostDisplayable{}

