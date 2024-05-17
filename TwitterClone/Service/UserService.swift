//
//  UserService.swift
//  TwitterClone
//
//  Created by Modamori Noah on 2024-03-31.
//
import Firebase
import FirebaseFirestoreSwift

struct UserService{
    
    func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        //Fetch Current User Information
        let db = Firestore.firestore()
        db.collection("user").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else {return}
            
            guard let user = try? snapshot.data(as: User.self) else {return}
            completion(user)
            
        }
    }
    
    func fetchUsers(completion: @escaping([User]?, Error?) -> Void){
        Firestore.firestore().collection("user").getDocuments { snapshot, error in
            
            if let error = error {
                print("Error featching users\(error.localizedDescription)")
                completion(nil, error)
            }
            guard let documents = snapshot?.documents else {
                print("No User Found")
                completion([], nil)
                return
            }
            let users = documents.compactMap { document -> User? in
                try? document.data(as: User.self)
            }
            if users.isEmpty{
                print("No User could be decoded because document is empty")
            }
            completion(users, nil)
        }
    }
}
