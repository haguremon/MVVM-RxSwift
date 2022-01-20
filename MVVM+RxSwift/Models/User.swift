//
//  User.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/20.
//

import Foundation
import Firebase

struct User {
    
    let name: String
    let email: String
    let createdAt: Timestamp
    let uid: String
    
    init(_ dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.uid = dic["uid"] as? String ?? ""
    }
    
}
