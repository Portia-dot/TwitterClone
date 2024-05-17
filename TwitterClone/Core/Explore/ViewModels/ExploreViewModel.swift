//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-04-17.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    func fetchUsers() {
        service.fetchUsers { users, error in
//            print("Fetch User Is Called")
            if let users = users {
                self.users = users
//                print("Users: \(users)")
            } else if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }

}
