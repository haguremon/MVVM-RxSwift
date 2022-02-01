//
//  CardView.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/21.
//


import UIKit
import SDWebImage

class CardView: UIView {
    
    private let gradientLayer = CAGradientLayer()

    // MARK: UIViews //めっちゃスッキリしてる使える
               let cardImageView = CardImageView(frame: .zero)
       private let infoButton = UIButton(type: .system).createCardInfoButton()
               let nameLabel = CardInfoLabel(frame: .zero, labelText: "", labelFont: .systemFont(ofSize: 40, weight: .heavy))
       private var residenceLabel = CardInfoLabel(frame: .zero, labelText: "日本、東京", labelFont: .systemFont(ofSize: 20, weight: .regular))
       private var hobbyLabel = CardInfoLabel(frame: .zero, labelText: "ゲーム", labelFont: .systemFont(ofSize: 25, weight: .regular))
       private let introductionLabel = CardInfoLabel(frame: .zero, labelText: "ゲーム大好きです", labelFont: .systemFont(ofSize: 25, weight: .regular))
       private let goodLabel = CardInfoLabel(frame: .zero, labelText: "GOOD", labelColor: .rgb(red: 137, green: 223, blue: 86))
       private let nopeLabel = CardInfoLabel(frame: .zero, labelText: "NOPE", labelColor: .rgb(red: 225, green: 80, blue: 80))
       
    init(user: User) {
         super.init(frame: .zero)
                
        setupLayout(user: user)
        setupGradietntLayer()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGradietntLayer() {
          gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
          gradientLayer.locations = [0.3, 1.1]
          cardImageView.layer.addSublayer(gradientLayer)
      }
      

    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self) // CGPointを取得
        guard let view = gesture.view else { return }
        if gesture.state == .changed {
            //触れてる時の処理
            self.handlePanChange(translation: translation)
            
        } else if gesture.state == .ended {
            //離した時の処理
            self.handlePanEnded(view: view, translation: translation)
        }
    }
    
    private func handlePanChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100
        //angleの軌道で動く
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
        
    }
    
    //触れてるのが終わった時の場所によって変わる処理
    private func handlePanEnded(view: UIView, translation: CGPoint) {
        //NOPE
        if translation.x <= -120 {
            self.removeCardViewAnimation(view: view, x: -600)
        //GOOD
        } else if translation.x >= 120 {
            
            self.removeCardViewAnimation(view: view, x: 600)
         //その他
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
        
    }
    
    private func setupLayout(user: User) {
        let infoVerticalSatckView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalSatckView.axis = .vertical//縦
        //ネストされたStackView
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalSatckView, infoButton])
        baseStackView.axis = .horizontal//
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)
        nameLabel.text = user.name
        introductionLabel.text = user.email
        cardImageView.sd_setImage(with: URL(string: user.profileImageURL), completed: nil)
        
    }
    
    
}
