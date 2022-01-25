//
//  ProfileImageVIew.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/25.
//a

import UIKit

class ProfileImageVIew: UIImageView {
    
    init(){
        super.init(frame: .zero)
        image = UIImage(named: "image")
        contentMode = .scaleAspectFill
        layer.cornerRadius = 90
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
