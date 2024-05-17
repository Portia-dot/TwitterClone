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
    
    //USER DATA
    @Published var currentUser: User?
    
    //User Search Result
    @Published var selectedUser: User?
    
    private let service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.verifyUserSession()
        self.fetchUser()
        
    }
    
    //Tweets
    @Published var tweets: [TweetViewModel] = []
    @Published var isLoadingTweets = false
    
    //Comment
    @Published var comments = [CommentViewModel]()
    @Published var commentCount: [String : Int] = [:]
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
//                   print("Debug: User logged in successfully. User ID: \(user.uid)")
                    self.fetchUser()
        }
//        print("Debug: Login with email \(email)")
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
//            print("Debug: User is \(String(describing: self.userSession))")
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
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else {return}

        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("user")
                .document(uid)
                .updateData(["profileImageUrl" : profileImageUrl]) { error in
                    if let error = error {
                        print("Error updating user profile image: \(error.localizedDescription)")
                        return
                    }
                    
                    self.userSession = self.tempUserSession
                    self.fetchUser()
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
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        service.fetchUser(withUid: uid){ user in
            self.currentUser = user
        }
    }
    
    func selectedUser(_ user: User){
        selectedUser = user
    }
    
    func clearSelectedUser(){
        selectedUser = nil
    }
    
    //Tweets Functions
    func postTweet(caption: String, completion: @escaping (String?, Bool) -> Void) {
        guard let uid = userSession?.uid else {
            completion(nil, false)
            return
        }
        
        let data = ["uid": uid, "caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0] as [String: Any]
        let documentReference = Firestore.firestore().collection("tweets").addDocument(data: data)
        documentReference.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error posting tweet: \(error.localizedDescription)")
                completion(nil, false)
            } else {
                completion(documentReference.documentID, true)
            }
        }
    }



    //Post Comment
    
    func postComment(tweetID: String, caption: String, completion: @escaping (Bool) -> Void){
        guard let uid = userSession?.uid, !tweetID.isEmpty else {
            print("Missing UserID or TweetID")
            completion(false)
            return
        }
        let commentData : [String: Any] = [
            "uid": uid,
            "tweetID" : tweetID,
            "caption" : caption,
            "timestamp": Timestamp(date: Date()),
            "likes": 0
        ]
        Firestore.firestore().collection("comments").addDocument(data: commentData) {error in
            if let error  = error {
                print("DEBUG: Error in posting comment \(error.localizedDescription)")
                completion(false)
                
            }else {
                print("Comment Added")
                self.fetchComment()
                completion(true)
            }
        }
    }
    
    
    
    // Fetch Tweets
    
    func fetchTweets(for uid: String? = nil){
        isLoadingTweets  = true
        let userId = uid ?? userSession?.uid
        guard let userId = userId else{
            isLoadingTweets = false
            print("Error: User ID is nil")
            return
        }
        Firestore.firestore().collection("tweets").whereField("uid", isEqualTo: userId).order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            if let error = error{
                print("Error fetching tweets: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoadingTweets = false
                }
                return
            }
            guard let documents = snapshot?.documents else {
                print("No Documents found")
                DispatchQueue.main.async {
                    self.isLoadingTweets = false
                }
                return
            }
            
            DispatchQueue.main.async {
                self.tweets = documents.map{TweetViewModel(document: $0)}
                self.isLoadingTweets = false
            }
        }

    }
    
    var commentsListener: ListenerRegistration?
    
    func fetchComment(){
        Firestore.firestore().collection("comments").getDocuments { (snapshot, error) in
            if error != nil {
                print("Error")
            }else if let snapshot = snapshot {
                for document in snapshot.documents {
                    print("\(document.documentID) -> \(document.data())")
                }
            }
        }
    }
    

    
    func fetchComments(forTweetID tweetID: String) {
//        print("Fetching comments for Tweet ID: \(tweetID)")
        
        // Fetch the actual comments
        Firestore.firestore().collection("comments")
            .whereField("tweetID", isEqualTo: tweetID)
            .order(by: "timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching comments: \(error.localizedDescription)")
                    return
                }else if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        print("Updating comments for tweetid \(tweetID)")
                        self.comments = snapshot.documents.map{ document in
                            CommentViewModel(dictionary: document.data())
                        }
                        self.commentCount[tweetID] = snapshot.documents.count
                    }
                }
            }
    }

//    func fetchComments(forTweetID tweetID: String) {
//           print("Fetching comments for Tweet ID: \(tweetID)")
//           Firestore.firestore().collection("comments")
//               .whereField("tweetID", isEqualTo: tweetID)
//               .order(by: "timestamp", descending: true)
//               .getDocuments { (snapshot, error) in
//                   if let error = error {
//                       print("Error fetching comments: \(error.localizedDescription)")
//                   } else if let snapshot = snapshot {
//                       DispatchQueue.main.async {
//                           self.comments = snapshot.documents.map{document in
//                               CommentViewModel(dictionary: document.data())
//                           }
//                       }
//                   } else {
//                       print("No snapshot data received")
//                   }
//               }
//       }
//    
    
    func updateLikeStatus(for tweetID: String, isLiked: Bool) {
        let userID = userSession!.uid
        let tweetRef = Firestore.firestore().collection("tweets").document(tweetID)
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            let tweetDocument: DocumentSnapshot
            do{
                tweetDocument = try transaction.getDocument(tweetRef)
            }catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                print("Failled to fetch document: \(fetchError.localizedDescription)")
                return nil
            }
            var likes = tweetDocument.data()?["likes"] as? [String: Bool] ?? [:]
            likes[userID] = isLiked
            let totalLikes = likes.values.filter{$0}.count
            transaction.updateData(["likes": likes, "totalLikes" : totalLikes], forDocument: tweetRef)
            return nil
        }, completion: {object, error in
            if let error = error {
                print("Transaction failed: \(error)")
            }else {
                print("Transaction successfully committed")
            }
            
        })
            
    }
    
    func fetchLikeStatus(for tweetID: String, completion: @escaping (Bool, Int) -> Void){
        let userID = userSession!.uid
        let tweetRef = Firestore.firestore().collection("tweets").document(tweetID)
        tweetRef.getDocument{documentSnapshot, error in
            guard let document = documentSnapshot, error == nil else {
                print("Error fetching document : \(error?.localizedDescription ?? "Unknown")")
                completion(false, 0)
                return
            }
            let likes = document.data()?["likes"] as? [String: Bool] ?? [:]
            let isLiked = likes[userID] ?? false
            let totalLikes = likes.values.filter{$0}.count
            completion(isLiked, totalLikes)
        }
    }
    
    //Func Fetch Comment Count
    
    func fetchCommentCount(forTweetID tweetID: String, completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("comments")
            .whereField("tweetID", isEqualTo: tweetID)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Debug: Error fetching comment counts: \(error.localizedDescription)")
                    completion(0)
                }else if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        completion(snapshot.documents.count)
                    }
                }
            }
    }
}
