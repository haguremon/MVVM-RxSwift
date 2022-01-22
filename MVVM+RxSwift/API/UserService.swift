//
//  UserService.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/20.
//

import FirebaseAuth
import UIKit

struct UserService {
    
    
    static func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let dictonary = snapshot?.data() else { return }
            let user = User(dictonary)
            completion(user)
        }
        
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
      
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
    
}
