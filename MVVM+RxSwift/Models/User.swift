//
//  User.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/20.
//

import Firebase

struct User {
    
    let name: String
    let age: String
    let email: String
    let residence: String
    let hobby: String
    let introduction: String
    let createdAt: Timestamp
    let uid: String
    
    init(_ dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
        self.age = dic["age"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.residence = dic["residence"] as? String ?? ""
        self.hobby = dic["hobby"] as? String ?? ""
        self.introduction = dic["introduction"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.uid = dic["uid"] as? String ?? ""
    }
    
}
