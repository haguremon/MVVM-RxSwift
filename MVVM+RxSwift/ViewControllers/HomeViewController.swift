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
    
    private var isCardAnimating = false
    
    var user: User?
    
    var users: [User]?
    
    let cardView = UIView()
    let topControlView = TopControlView()
    
    let bottomControlView = BottomControlView()
    
     func logOut() {
        
        do {
            try Auth.auth().signOut()
            let registerViewController = RegisterViewController()
            let naVRVC = UINavigationController(rootViewController: registerViewController)
            naVRVC.modalPresentationStyle = .fullScreen
            self.present(naVRVC, animated: false)
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
        self.fetchUser()
        self.fetchUsers()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        topControlView.tinderButton.isSelected = true
        topControlView.commentButton.isSelected = false
        topControlView.goodButton.isSelected = false
        topControlView.profileButton.isSelected = false
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        UserService.fetchUser(uid: uid) { [ weak self ] user in
            self?.user = user
     }
        
    }
    private func  fetchUsers() {
        HUD.show(.progress)
        self.cardView.alpha = 0
        //データの数によってめっちゃ時間かかるやつ
        cardView.subviews.forEach {
            $0.layoutIfNeeded()
            $0.removeFromSuperview()
        }
        self.users = []
        UserService.fetchUsers { users in
            self.users = users
            self.users?.shuffle()
            self.users?.forEach({ user in
                    let card = CardView(user: user)
                    self.cardView.addSubview(card)
                    
                    card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            
            })
            
        }
        
        HUD.hide(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.25) {
            self.cardView.alpha = 1
        }
           
           
       

    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        

        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        topControlView.anchor(height:100)
        bottomControlView.anchor(height:120)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom:  view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
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
                profileViewController.delegate = self
                self.present(profileViewController, animated: true)
            }.disposed(by: disposeBag)
        
        bottomControlView.nopeView.button?.rx.tap
               .asDriver()
               .drive { [weak self] _ in
                   guard let self = self else { return }
                   
                   if !self.isCardAnimating {
                       self.isCardAnimating = true
                       self.cardView.subviews.last?.removeCardViewAnimation(x: -600, completion: {
                           self.isCardAnimating = false
                       })
                   }
               }
               .disposed(by: disposeBag)
           
           bottomControlView.likeView.button?.rx.tap
               .asDriver()
               .drive { [weak self] _ in
                   guard let self = self else { return }
                   
                   if !self.isCardAnimating {
                       self.isCardAnimating = true
                       self.cardView.subviews.last?.removeCardViewAnimation(x: 600, completion: {
                           self.isCardAnimating = false
                       })
                   }
               }
               .disposed(by: disposeBag)
        
        bottomControlView.reloadView.button?.rx.tap
            .asDriver()
            .drive { [ weak self ] _ in
          
            
                    self?.fetchUsers()
            

                  
              
               
            }.disposed(by: disposeBag)

    }
    
}



extension HomeViewController: ProfileViewControllerDelegate {
    func tappedLogOut() {
        logOut()
    }
    
    func didChangedProfile() {
      
         fetchUsers()
       
    }
    

}
