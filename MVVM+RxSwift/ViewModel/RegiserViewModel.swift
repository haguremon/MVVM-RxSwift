//
//  RegiserViewModel.swift
//  MVVM+RxSwift
//
//  Created by IwasakIYuta on 2022/01/09.
//

import RxSwift
import RxCocoa

class RegiserViewModel {

    private let disposeBag = DisposeBag()

    // MARK: observable//監視可能 PublishSubjectはアウトプットもインプットも両方行ける認識
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    var validLoginSubject = BehaviorSubject<Bool>(value: false)


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
    
    var validRegisterDriver: Driver<Bool> = Driver.never()
    var validLoginDriver: Driver<Bool> = Driver.never()


    init() {
        
        validRegisterDriver = validRegisterSubject
                    .asDriver(onErrorDriveWith: Driver.empty())//エラーの時に空のDriverを返す?
        //観測可能なシーケンスをasDriverに変更
        
        validLoginDriver = validLoginSubject
                    .asDriver(onErrorDriveWith: Driver.empty())

        let nameVaild = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        //mapを使って観察可能を変更する


        let emailVaild = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        

        let passwordVaild = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        //最新の発行どうしが結合　引数の最新の状態だけを取得する
        Observable.combineLatest(nameVaild, emailVaild, passwordVaild) { $0 && $1 && $2 }.subscribe { vaildAll in
            self.validRegisterSubject.onNext(vaildAll)
        }.disposed(by: disposeBag)
        
        Observable.combineLatest(emailVaild, passwordVaild) { $0 && $1 }.subscribe { vaildAll in
            self.validLoginSubject.onNext(vaildAll)
        }.disposed(by: disposeBag)
    }

}
