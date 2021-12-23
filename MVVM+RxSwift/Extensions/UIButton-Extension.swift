//
//   UIButton-Extension.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/24.
//

import UIKit

extension UIButton {
    
    func createCardInfoButton() -> UIButton {
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
}
