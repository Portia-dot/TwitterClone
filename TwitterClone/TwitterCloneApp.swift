//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    @AppStorage("isDarkModeEnabled") private var isDarkModelEnabled: Bool = false
//    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
              ContentView()
//              ProfileSelectorView()
            }
                .environment(\.appColorScheme, isDarkModelEnabled ? .dark: .light)
                .environmentObject(AuthViewModel())
        }
    }
}
