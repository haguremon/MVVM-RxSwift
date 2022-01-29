//
//  UserService.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/20.
//

import FirebaseAuth
import FirebaseFirestore

struct UserService {
    
    
    static func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        COLLECTION_USERS.document(uid).addSnapshotListener { snapshot, _ in
//        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let dictonary = snapshot?.data() else { return }
            let user = User(dictonary)
            completion(user)
        }
        
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
    //更新をすぐにできるを使うとgetDocumentsより便利。チャットアプリなどでよく使う
    
      COLLECTION_USERS.getDocuments { (snapshot, error) in
             if let error = error {
                 print(error.localizedDescription)
                 return
             }
             guard let documents = snapshot?.documents else { return }
             let users = documents.map { snapshot in
                 return User(snapshot.data())
             }
                  completion(users)
         }
         
     }
    
    static func updateUser(dic: [String: Any], completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        COLLECTION_USERS.document(uid).updateData(dic) { error in
            if let error = error {
             print(error.localizedDescription)
                return
            }
            completion()
        }
        
    }
    
}
