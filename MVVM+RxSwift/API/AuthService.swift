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


    static func registerUser(withCredential credentials: AuthCredentials) {

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
                        return
                    }

                    print("ユーザー情報のfirestoreへの保存が成功")
                }
            }
       }

    }

