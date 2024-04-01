//
//  UserService.swift
//  TwitterClone
//
//  Created by Modamori Noah on 2024-03-31.
//
import Firebase
import FirebaseFirestoreSwift

struct UserService{
    
    func fetchUseR(withUid uid: String) {
        //Fetch Current User Information
        let db = Firestore.firestore()
        db.collection("user").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else {return}
            
            guard let user = try? snapshot.data(as: User.self) else {return}
            print("Debug: Username is \(user.username)")
            
        }
    }
}