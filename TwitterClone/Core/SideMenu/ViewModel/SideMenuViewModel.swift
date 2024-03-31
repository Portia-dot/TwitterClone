//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case lists
    case getPremium
    case communities
    case bookmarks
    case spaces
    case monietisation
    case logout
    
    var description: String{
        switch self {
        case .profile: return "Profile"
        case .lists: return "List"
        case .getPremium: return "Get Premium+"
        case .communities: return "Communites"
        case .bookmarks: return "Bookmarks"
        case .spaces: return "Spaces"
        case .monietisation: return "Monietisation"
        case .logout: return "Log Out"
        }
    }
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .lists: return "list.bullet"
        case .getPremium: return "xmark.app"
        case .communities: return "person.2"
        case .bookmarks: return "bookmark"
        case .spaces: return "mic"
        case .monietisation: return "wallet.pass"
        case .logout: return "rectangle.portrait.and.arrow.right"
        }
    }
}
