//
//  ViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/18.
//test git clone push

import UIKit
import FirebaseAuth
import Firebase
import PKHUD
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var user: User?
    
    var users: [User]?
    
    let cardView = UIView()
    let topControlView = TopControlView()
    
    let bottomControlView = BottomControlView()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.setTitle("ログアウト", for: .normal)
        button.addTarget(self, action: #selector(tappedLogOut), for: .touchUpInside)
        return button
    }()
   
    @objc func tappedLogOut() {
        
        do {
            try Auth.auth().signOut()
            let registerViewController = RegisterViewController()
            let naVRVC = UINavigationController(rootViewController: registerViewController)
            naVRVC.modalPresentationStyle = .fullScreen
            self.present(naVRVC, animated: true)
        
        } catch {
            print(error.localizedDescription)
        }
        
       
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        setupLayout()
        setupBindins()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUser()
        fetchUsers()
    }
    
    private func fetchUser() {
         
        UserService.fetchUser { [ weak self ] user in
            self?.user = user
     }
        
    }
    private func fetchUsers() {
        HUD.show(.progress)
        
        UserService.fetchUsers { users in
            self.users = users
            HUD.flash(.success,delay: 1)
            self.users?.forEach({ user in
                //CardViewの引数にuserが必要なのでそれを使って複数のCardViewを作成
                let card = CardView(user: user)
                self.cardView.addSubview(card)//cardViewの上にaddSubviewすると
                //そして制約をする
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
                
            })
            
        }

    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        

        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        view.addSubview(logoutButton)
        
        topControlView.anchor(height:100)
        bottomControlView.anchor(height:120)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom:  view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor,bottomPadding: 10, leftPadding: 10)
        
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let registerViewController = RegisterViewController()
                let naVRVC = UINavigationController(rootViewController: registerViewController)
                naVRVC.modalPresentationStyle = .fullScreen
                self.present(naVRVC, animated: false)
                
            }
        }
}
    
    private func setupBindins() {
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { _ in
                let profileViewController = ProfileViewController()
                profileViewController.user = self.user
                self.present(profileViewController, animated: true)
            }.disposed(by: disposeBag)

        
    }
    
}
