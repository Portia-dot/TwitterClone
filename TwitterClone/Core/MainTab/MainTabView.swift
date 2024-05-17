//
//  MainTabView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @Binding var showSidebarToggle: Bool
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem { Image(systemName: "house") }
                .tag(0)
                .onAppear { self.showSidebarToggle = true }

            //Second
            
            SearchView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
                .onAppear { self.showSidebarToggle = false }


            //Grok
            GrokView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem { Image(systemName: "pencil.and.scribble") }
                .tag(2)
                .onAppear { self.showSidebarToggle = true }

            
            //Notification
            
            NotificationView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem { Image(systemName: "bell") }
                .tag(3)
                .onAppear { self.showSidebarToggle = true }

            //Inbox
            
            MessagesView()
                .onTapGesture {
                    self.selectedIndex = 4
                }
                .tabItem { Image(systemName: "envelope") }
                .tag(4)
                .onAppear { self.showSidebarToggle = true }

        }
    }
}

//#Preview {
//    @State private var showSidebarToggle: Bool = true
//    MainTabView(showSidebarToggle: $showSidebarToggle)
//        .environmentObject(AuthViewModel())
//}
