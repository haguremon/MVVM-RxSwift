//
//  RegisterViewController.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2021/12/24.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag() //Rxは常に流れてるのでDisposeBagを使うことによって閉じる事ができてメモリリークを防ぐ
    let viewModel = RegiserViewModel()
    
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    
    private let registerButton = RegisterButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupGradientLayer()
        setupLayout()
        setupBindins()
       
    }
    
    //Gradientの背景を生み出す事ができる
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
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        
        nameTextField.anchor(height: 45) //ここで幅を設定することによって　上の baseStackView.distribution = .fillEquallyによって均等になる
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }
    
    private func setupBindins() {
           
           nameTextField.rx.text
               .asDriver()
               .drive { [weak self] text in
                   //[weak self]を使うことによって自身に参照するときに循環参照を防ぐ
                   // textの情報ハンドル
                  //self?.viewModel.nameTextOutput.onNext(text ?? "")
                   self?.viewModel.nameTextInput.onNext(text ?? "")
               
               }.disposed(by: disposeBag)
               
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
               
           registerButton.rx.tap
               .asDriver()
               .drive { [weak self] _ in
                   // 登録時の処理
                   self?.createUserToFireAuth()
               }.disposed(by: disposeBag)
           
       }
    //いつも通りの登録の処理
    
    private func createUserToFireAuth() {
        guard let email = emailTextField.text else { return }
        guard let passwoard = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
       
        let authCredentials = AuthCredentials(email: email, password: passwoard, name: name)
        
        AuthService.registerUser(withCredential: authCredentials)
        
    }
    
 
    
}
