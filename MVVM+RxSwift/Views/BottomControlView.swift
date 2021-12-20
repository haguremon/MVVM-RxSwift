//
//  BottomControlView.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/18.
//


import UIKit
//複数のボタンがあるUIViewを作成
class BottomControlView: UIView {
    
    let reloadView = BottomButtonView(frame: .zero, width: 50, imageName: "reload")
    let nopeView = BottomButtonView(frame: .zero, width: 60, imageName: "nope")
    let superlikeView = BottomButtonView(frame: .zero, width: 50, imageName: "superlike")
    let likeView = BottomButtonView(frame: .zero, width: 60, imageName: "like")
    let boostView = BottomButtonView(frame: .zero, width: 50, imageName: "boost")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        let baseStackView = UIStackView(arrangedSubviews: [reloadView, nopeView, superlikeView, likeView, boostView])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        
        addSubview(baseStackView)
        baseStackView.anchor(top:topAnchor,bottom:bottomAnchor,left: leftAnchor,right: rightAnchor,leftPadding: 10,rightPadding: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/*
 let button: UIButton = {
 
 }() みたいなのを複数書かなくてもいい
 */
//これを↓することによって再利用のボタンを複数作成する事ができる↑みてね
class BottomButtonView: UIView {
    //ここのviewにボタンを設置
    var button: BottomButton?
    
    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        
        button = BottomButton(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: .init(width: width * 0.4, height: width * 0.4)), for: .normal)
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2
        
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        
        addSubview(button!)
        
        button?.anchor(centerY:centerYAnchor,centerX: centerXAnchor,width: width,height: width)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BottomButton: UIButton {
    //isHighlightedは選択してる時
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    //transform動きscaleX: 0.8, y: 0.8で大きさをどうするか
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    //identityで元の大きさにする
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
