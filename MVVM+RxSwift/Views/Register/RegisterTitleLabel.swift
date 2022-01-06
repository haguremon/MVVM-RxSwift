//
//  RegisterTitleLabel.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/06.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.text = "Tinder"
        self.font = .boldSystemFont(ofSize: 80)
        self.textColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

