//
//  TopControlView.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/20.
//


import UIKit
import RxCocoa //UIの操作
import RxSwift

class TopControlView: UIView {
    //メモリリークを防ぐもの
    private let disposeBag = DisposeBag()
    
    let tinderButton = createTopButton(imageName: "tinder-selected", unselectedImage: "tinder-unselected")
    let goodButton = createTopButton(imageName: "good-selected", unselectedImage: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected", unselectedImage: "comment-unselected")
    let profileButton = createTopButton(imageName: "profile-selected", unselectedImage: "profile-unselected")
    //インスタンスしなくても使えるようにする
    static private func createTopButton(imageName: String, unselectedImage: String) -> UIButton {
        let button = UIButton(type: .custom)
       //選択されてる時のイメージ for: .selected
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 43
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        [baseStackView.topAnchor.constraint(equalTo: topAnchor),
         baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
         baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
         baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
        ].forEach { $0.isActive = true }
        
        tinderButton.isSelected = true
    }
    
    private func setupBindings() {
        
        tinderButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
               //onNext//値が更新
                guard let self = self else { return }
                //選択された時に↓の関数を実行
                self.handleSelectedButton(selectedBtton: self.tinderButton)
            })
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedBtton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedBtton: self.commentButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedBtton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }
    //ボタンの選択認識関数
    private func handleSelectedButton(selectedBtton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        //タップされたuiだけイメージを変える事ができる
        buttons.forEach { button in
            if button == selectedBtton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
