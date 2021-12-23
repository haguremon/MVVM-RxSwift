//
//  CardInfoLabel.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/24.
//

import UIKit

class CardInfoLabel: UILabel {
   //二つのイニシャライザーやるのは初めてかも便利
    // nopeとgoodのラベル
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)
        
        font = .boldSystemFont(ofSize: 45)
        text = labelText
        textColor = labelColor
        
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // その他のtextColorが白のラベル
    init(frame: CGRect, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)
        font = labelFont
        textColor = .white
        text = labelText
    }

}
