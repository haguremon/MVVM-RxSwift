//
//  RegisterButton.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/06.
//

import UIKit

class RegisterButton: UIButton {
    
    
    override var isHighlighted: Bool {
        //isHighlightedされた時にボタンのバックグランドを変更する処理
        didSet {
            self.backgroundColor = isHighlighted ? backgroundColor?.withAlphaComponent(0.2) : backgroundColor
        }
    }
    
    init(text: String,backgroundColor: UIColor?) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        self.backgroundColor = backgroundColor//
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
