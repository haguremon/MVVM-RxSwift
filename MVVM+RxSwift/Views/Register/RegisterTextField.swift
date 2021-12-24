//
//  RegisterTextField.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/24.
//
/*
 viewControllerでクロージャータイプのプロパティを書かなくても良いしここを変えたら全てに変更ができる
 let registerTextField: UITextField = {
 let tv = UITextField
 return tv
 }()
 */

import UIKit

class RegisterTextField: UITextField {
    
    init(placeHolder: String){
        super.init(frame: .zero)
        placeholder = placeHolder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
