//
//  LoginViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/19.
//

import UIKit
import RxSwift
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag() //Rxは常に流れてるのでDisposeBagを使うことによって閉じる事ができてメモリリークを防ぐ
    let viewModel = RegiserViewModel()
    
    private let titleLabel = RegisterTitleLabel(text: "LOGIN")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let dontHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "新規登録してない方はこちらから")
    
    private let loginButton = RegisterButton(text: "ログイン")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindins()
        
    }
    
    private func setupGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setupLayout() {
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .newPassword
        
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)
        
        emailTextField.anchor(height: 45) //ここで幅を設定することによって　上の baseStackView.distribution = .fillEquallyによって均等になる
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        dontHaveAccountButton.anchor(top: baseStackView.bottomAnchor,centerX: view.centerXAnchor, topPadding: 17)
    }
    
    private func setupBindins() {
        //        nameTextField.rx.value.subscribe(onNext: <#T##((String?) -> Void)?##((String?) -> Void)?##(String?) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報ハンドル
                self?.viewModel.emailTextInput.onNext(text ?? "")
            }.disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報ハンドル
                self?.viewModel.passwordTextInput.onNext(text ?? "")
            }.disposed(by: disposeBag)
        
        viewModel.validLoginDriver
            .drive { validAll in
                //validAllによってボタンの処理が変わる
                self.loginButton.isEnabled = validAll
                self.loginButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }.disposed(by: disposeBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                
                self?.loginUserIN()
                
            }.disposed(by: disposeBag)
        
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                //前のnavigationControllerの場所に戻す
                self?.navigationController?.popViewController(animated: true)
                
            }.disposed(by: disposeBag)
        
    }
    
    private func loginUserIN() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        AuthService.logUserIn(withEmail: email, password: password) { [weak self] success in
            
            if success == true {
                self?.dismiss(animated: true)
                return
            } else {
                print("失敗しました")
            }
        }
    }
    
    
}
