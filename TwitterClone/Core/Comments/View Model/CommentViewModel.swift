//
//  CommentViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-25.
//

import Foundation
import FirebaseFirestore

struct CommentViewModel: Identifiable, Hashable {
    let id: String
    let uid: String
    let tweetID: String
    let caption: String
    let timeStamp: Date
    let likes: Int

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: timeStamp)
    }

    var timeAgo: String {
        return timeStamp.timeAgoDisplay()
    }

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? UUID().uuidString
        self.uid = dictionary["uid"] as? String ?? ""
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.timeStamp = (dictionary["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        self.likes = dictionary["likes"] as? Int ?? 0
    }
}
