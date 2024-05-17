//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedFilter: SearchFilterViewModel = .forYou
    @State private var isSearching = false
    @Namespace var animation
    
    
    //Trending Data Model
    let trendingTopics = [
        //Trending here
        TrendingTopic(title: "Wizkid", category: "Music", posts: "19.4k")
    ]
    var body: some View {
        VStack{
            //Top Bar
            HStack {
                Spacer()
                //Search Bar
                SearchView()
            }
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(AuthViewModel())
}

struct TrendingTopic {
    var title: String
    var category: String
    var posts: String
}
