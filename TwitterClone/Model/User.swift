//
//  User.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-31.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let dateOfBirth: String
    let bio: String
    let location: String
    let industry: String
    let email: String
    let website: String
}
