//
//  RegiserViewModel.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/09.
//

import RxSwift

class RegiserViewModel {

    private let disposeBag = DisposeBag()

    // MARK: observable//監視可能
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()

    // MARK: observer
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
//
//    var nameTextOutput1: Observable<String> { AnyObserver　と　Observableの使い分けがわからん
//        nameTextOutput.asObservable()
//    }

    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }

    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }

    init() {

        
        nameTextOutput
            .asObservable()
            .subscribe { text in
                print("name: ", text)
            }.disposed(by: disposeBag)
        
//        nameTextOutput1.subscribe { text in
//
//            print("name: ", text)
//
//        }.disposed(by: disposeBag)


        emailTextOutput
            .asObservable()
            .subscribe { text in
                print("email: ", text)
            }.disposed(by: disposeBag)

        passwordTextOutput
            .asObservable()
            .subscribe { text in
                print("password: ", text)
            }.disposed(by: disposeBag)

    }

}
