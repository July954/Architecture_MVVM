//
//  ViewController.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

class ViewController: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable swipe back when no navigation bar
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    func bind(reactor: ViewModel) {
        loginBtn.rx.tap
            .map { Reactor.Action.userTapLogin }
            .debug("loginBtn")
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    
}

