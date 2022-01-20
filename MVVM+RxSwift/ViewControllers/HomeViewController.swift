//
//  ViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/18.
//test git clone push

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    var user: User? { didSet { configureuser(user: self.user) } }
    
    let cardView = CardView()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUser()

    }
    
    private func fetchUser() {
         
        UserService.fetchUser { [ weak self ] user in
            self?.user = user
     }
        
    }
    
    private func configureuser(user: User?) {
        guard let user = user else { return }
            self.cardView.nameLabel.text = user.name
    
    
    }
    private func setupLayout() {
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        
        let bottomControlView = BottomControlView()
        
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
    
}
