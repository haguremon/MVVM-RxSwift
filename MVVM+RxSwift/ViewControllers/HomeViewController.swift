//
//  ViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/18.
//test git clone push

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        
        let cardView = CardView()
        
        let bottomControlView = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        
        topControlView.anchor(height:100)
        bottomControlView.anchor(height:100)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom:  view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
    
}
