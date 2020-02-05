//
//  LoginViewController.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import ReactorKit

class LoginViewController: BaseVC, StoryboardView, StoryboardBased {
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var pwTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable swipe back when no navigation bar
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setupToHideKeyboardOnTapOnView()
        
    }
    
    func bind(reactor: LoginViewModel) {
        
        loginBtn.rx.tap
            .do(onNext: { _ in
                self.pwTf.resignFirstResponder()
                self.emailTf.resignFirstResponder()
            })
            .map { Reactor.Action.userTapLogin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //loginBtn CallBack
        self.reactor?.state
            .map { $0 }
            .asObservable()
            .subscribe(onNext: { (state) in
                if state.result == .pass {
                    self.moveMain()
                } else if state.result == .fail {
                    CommonAlert.showAlertType1(vc: self, title: "알림", message: state.messgae, completeTitle: "확인", nil)
                }
            })
            .disposed(by: disposeBag)
        
        emailTf.rx.text.orEmpty
            .bind(to: reactor.emailViewModel.data)
            .disposed(by: disposeBag)
        
        pwTf.rx.text.orEmpty
            .bind(to: reactor.passViewModel.data)
            .disposed(by: disposeBag)
        
    
    }
    
    func moveMain() {
        self.steps.accept(AppStep.goMain)
    }
    
    
}

