//
//   UIButton-Extension.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/24.
//

import UIKit

//extensionでボタンを作成
extension UIButton {
    
    func createCardInfoButton() -> UIButton {
        setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        tintColor = .white
        imageView?.contentMode = .scaleAspectFit
        return self
    }
    
    func createAboutAccountButton(text: String) -> UIButton {
        setTitle(text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
        titleLabel?.textColor = .blue
        return self
    }
    
    func createProfileTopButton(text: String) -> UIButton {
        setTitle(text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        return self
    }
    func createEditProfileButton() -> UIButton {
        let image = UIImage(systemName: "square.and.pencil")
        setImage(image, for: .normal)
        layer.cornerRadius = 30
        tintColor = .darkGray
        imageView?.contentMode = .scaleToFill
        backgroundColor = .white
        return self
    }
    
    
}
