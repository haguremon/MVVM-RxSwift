//
//  ImageService.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/02/01.
//

import FirebaseStorage
import UIKit

// MARK: - イメージをアップロードする
struct ImageService {
    
    static func uploadImage(image: UIImage?, dic: [String: Any],completion: @escaping () -> Void) {
        guard let image = image else {
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString //NSUUIDなので被る事がない
        //storageのリファレンスのパスを決める
        let ref = Storage.storage().reference(withPath: "/profile_image\(filename)")
        //storageにputDataする
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let profileImageURL = url?.absoluteString else { return }
                var dicWithImage = dic
                dicWithImage["profileImageURL"] = profileImageURL
                UserService.updateUser(dic: dicWithImage) {
                    print("成功しました")
                }
                completion()
                
                
            }
        }
    }
    
}
