//
//  ProfileLabel.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/25.
//

import UIKit

class ProfileLabel: UILabel {
    
    init(){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 45, weight: .bold)
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
