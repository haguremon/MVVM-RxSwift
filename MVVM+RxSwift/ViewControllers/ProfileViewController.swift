//
//  ProfileViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/25.
//

import UIKit

class ProfileViewController: UIViewController {

    private let cellID = "cell"
    
    var user: User?
    
    let saveButton = UIButton.init(type: .system).createProfileTopButton(text: "保存")
    let logoutButton = UIButton.init(type: .system).createProfileTopButton(text: "ログアウト")
    let profileImageView = ProfileImageVIew()
    let nameLable = ProfileLabel()
    let profileEditButton = UIButton.init(type: .system).createEditProfileButton()
    
    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //セルの大きさを自動にする
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLable)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)
        
        saveButton.anchor(top:view.topAnchor,left: view.leftAnchor,topPadding: 20,leftPadding: 15)
        logoutButton.anchor(top:view.topAnchor,right: view.rightAnchor,topPadding: 20,rightPadding:15)
        profileImageView.anchor(top: view.topAnchor,centerX: view.centerXAnchor,width: 180,height: 180,topPadding: 60)
        nameLable.anchor(top: profileImageView.bottomAnchor,centerX: view.centerXAnchor,topPadding: 20)
        profileEditButton.anchor(top:profileImageView.topAnchor,right: profileImageView.rightAnchor,width: 60,height: 60)
        
        infoCollectionView.anchor(top: nameLable.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor , topPadding: 20)
        
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! InfoCollectionViewCell
      
        cell.user = user
        
        return cell
    }
    
}

