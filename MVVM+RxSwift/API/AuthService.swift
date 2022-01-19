//
//  AuthService.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/09.
//

import Firebase
//送る情報モデルの作成
struct AuthCredentials {
    let email: String
    let password: String
    let name: String
}

struct AuthService {

    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Bool) -> Void) {

            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in

                guard let uid = result?.user.uid else { return }

                let data: [String: Any] = [
                    "email": credentials.email,
                    "name": credentials.name,
                    "createdAt": Timestamp(),
                    "uid": uid
                 ]

                COLLECTION_USERS.document(uid).setData(data) { error in
                    if let error = error {
                        print("ユーザー情報のfirestoreへの保存に失敗: ", error.localizedDescription)
                        completion(false)
                        return
                    }
                    completion(true)
                    print("ユーザー情報のfirestoreへの保存が成功")
                }
            }
       }
    
    static func logUserIn(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error", error.localizedDescription)
                completion(false)
              return
            } else {
                print("ログインに成功しました")
                completion(true)
            }
            
        }
    }

}

