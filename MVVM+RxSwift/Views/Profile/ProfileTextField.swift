//
//  ProfileTextField.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/26.
//

import UIKit

class ProfileTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        self.placeholder = placeholder
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
