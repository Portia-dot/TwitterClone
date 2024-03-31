//
//  ProfileDetailsViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-31.
//

import Foundation


class ProfileDetailsViewModel: ObservableObject { 
    @Published var bio: String = ""
    @Published var industry: String = ""
    @Published var location: String = ""
    @Published var website: String = ""
    @Published var dateOfBirth: Date = Date()
}
