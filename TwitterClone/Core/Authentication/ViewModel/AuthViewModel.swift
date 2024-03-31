//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-21.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var didAuthenticateUser = false
    //Store User Session Temp
    var tempUserSession: FirebaseAuth.User?
    //Store User Session
    @Published var userSession: FirebaseAuth.User?
    //Show LogOut Alert
    @Published var showLogOutAlert = false
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.verifyUserSession()
        
        print("Debug: User session is \(String(describing: self.userSession))")
    }
    
    //Verify User Session

    func verifyUserSession(){
        if let currentUser = Auth.auth().currentUser{
            let db = Firestore.firestore()
            db.collection("user").document(currentUser.uid).getDocument { document, error in
                if let document = document, document.exists{
                    self.userSession = currentUser
                }else{
                    self.logout()
                    self.showLogOutAlert = true
                }
            }
        }else{
            self.userSession = nil
        }
    }
    
    //Login
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password ){ result, error  in
            if let error = error {
                       print("Debug: Failed to log in with error \(error.localizedDescription)")
                       return
                   }
                   
                   guard let user = result?.user else {
                       print("Debug: User not found")
                       return
                   }
                   
                   self.userSession = user
                   print("Debug: User logged in successfully. User ID: \(user.uid)")
        }
        print("Debug: Login with email \(email)")
    }
   //Register
    func register(withEmail email: String, password: String, fullname: String, username: String, completion: @escaping () -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug: Failed to register with error \(error.localizedDescription)")
                completion()
                return
            }
            guard let user = result?.user else {
                completion()
                return
            }
            self.tempUserSession = user
            
            //Prepare For Upload
            let data = ["email": email, "username": username.lowercased(), "fullname": fullname, "uid": user.uid]
            //Upload to fire database
            let db = Firestore.firestore()
            db.collection("user").document(user.uid).setData(data) {error in
                if let error = error {
                               print("Debug: Failed to upload user data to Firestore with error \(error.localizedDescription)")
                           } else {
                               print("Debug: User data uploaded to Firestore successfully")
                                   self.didAuthenticateUser = true
                               completion()
                           }
            }
            print("Debug: User is \(String(describing: self.userSession))")
        }
    }
    
    //Logout
    func logout() {
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            print("Debug: Successfully logged out.")
        } catch let signOutError as NSError{
            print("Debug: Error signing out:", signOutError)
        }
    }
    
    func uploadProfileImage(_ image: UIImage){
        guard let uid = tempUserSession?.uid else {return}
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl" : profileImageUrl]) { _ in
                self.userSession = self.tempUserSession
                }
        }
    }
    
    //Update User Details
    
    func updateUserDetails(uid: String, bio: String, industry: String, location: String, website: String, dateOfBirth: Date, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateOfBirthString = dateFormatter.string(from: dateOfBirth)
        
        let userDetails = [
            "bio": bio,
            "industry": industry,
            "location": location,
            "website": website,
            "dateOfBirth": dateOfBirthString
        ]
        db.collection("user").document(uid).setData(userDetails, merge: true){ error in
            if let error = error {
                print("Debug: Failed to update user detailed with error \(error.localizedDescription)")
                completion(false)
            }else{
                print("Debug: User profile details updated successfully")
                completion(true)
            }
        }
    }
}
