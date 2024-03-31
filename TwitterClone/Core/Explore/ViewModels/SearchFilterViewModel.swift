//
//  SearchFilterViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import Foundation

enum SearchFilterViewModel: String, CaseIterable {
    case forYou
    case trending
    case news
    case sports
    case entertainment
    
    var title: String {
        switch self{
        case .forYou: return "For You"
        case .trending:  return "Trending"
        case .news:  return "News"
        case .sports: return "Sports"
        case .entertainment: return "Entertainment"
        }
    }
}
