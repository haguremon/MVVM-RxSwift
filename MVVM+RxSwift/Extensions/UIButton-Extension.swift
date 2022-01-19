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
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
    func createAboutAccountButton(text: String) -> UIButton {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.titleLabel?.textColor = .blue
        return self
    }
    
}
