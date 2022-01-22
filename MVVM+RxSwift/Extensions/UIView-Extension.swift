//
//  UIView-Extension.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/20.
//

import Foundation

import UIKit

extension UIView {
  //制約の拡張
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        topPadding: CGFloat = 0,
        bottomPadding: CGFloat = 0,
        leftPadding: CGFloat = 0,
        rightPadding: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
}
//MARK: - animation
extension UIView {
    func removeCardViewAnimation(view: UIView, x: CGFloat) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            let degree: CGFloat = x / 20
            let angle = degree * .pi / 180
            let rotateTranslation = CGAffineTransform(rotationAngle: angle)
            view.transform = rotateTranslation.translatedBy(x: x, y: 100)//消える座標かな？
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()//動きが終わった後にremoveする
        }
    }
    
}
