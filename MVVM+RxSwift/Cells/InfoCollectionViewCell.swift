//
//  InfoCollectionViewCell.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/26.
//

import UIKit


class InfoCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            nameTextField.text = user?.name
            emailTextField.text = user?.email
        }
    }
    
    // MARK: UIViews
    let nameLabel = ProfileLabel(title: "名前")
    let ageLabel = ProfileLabel(title: "年齢")
    let emailLabel = ProfileLabel(title: "email")
    let residenceLabel = ProfileLabel(title: "居住地")
    let hobbyLabel = ProfileLabel(title: "趣味")
    let introductionLabel = ProfileLabel(title: "自己紹介")
    
    let nameTextField = ProfileTextField(placeholder: "名前")
    let ageTextField = ProfileTextField(placeholder: "年齢")
    let emailTextField = ProfileTextField(placeholder: "email")
    let residenceTextField = ProfileTextField(placeholder: "居住地")
    let hobbyTextField = ProfileTextField(placeholder: "趣味")
    let introductionTextField = ProfileTextField(placeholder: "自己紹介")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        let views = [
            [nameLabel,nameTextField],[ageLabel,ageTextField],
            [emailLabel,emailTextField],[residenceLabel,residenceTextField],
            [hobbyLabel,hobbyTextField],[introductionLabel,introductionTextField]
        ]
        //めちゃくちゃ便利だからこれから使う
        let stackViews = views.map { views -> UIStackView in
            guard let label = views.first,
                  let textField = views.last else { return UIStackView() }
            let stackView = UIStackView(arrangedSubviews: [label,textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height:50)
            return stackView
        }
        //セルの大枠のStackView
        let baseStackView = UIStackView(arrangedSubviews: stackViews)
            baseStackView.axis = .vertical
            baseStackView.spacing = 15
        addSubview(baseStackView)
        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height: 80)
        
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor,topPadding: 10,leftPadding: 20, rightPadding: 20)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
