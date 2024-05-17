//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-20.
//

import SwiftUI
import FirebaseFirestore

class TweetViewModel: Identifiable, ObservableObject {
    
    let id: String
    let uid: String
    let caption: String
    let timeStamp: Date
    let likes: Int
    
    // Formatter
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: timeStamp)
    }
    
    var timeAgo: String {
        return timeStamp.timeAgoDisplay()
    }
    
    init(document: DocumentSnapshot) {
        self.id = document.documentID
        let dictionary = document.data() ?? [:]
        self.uid = dictionary["uid"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.timeStamp = (dictionary["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        self.likes = dictionary["likes"] as? Int ?? 0

    }

}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        }else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        }else {
            return "\(secondsAgo / day) days ago"
        }
    }
}
