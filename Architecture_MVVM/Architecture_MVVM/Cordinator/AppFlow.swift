//
//  AppFlow.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxRelay

class AppFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let service: AppServices
    
    init(service: AppServices) {
        self.service = service
    }
    
    deinit {
        print("deinit AppFlow")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        case .goMain:
            return naviToMain()
        case .goLogin:
            return naviToLogin()
        }
    }
    
    private func naviToLogin() -> FlowContributors {
        let vc = LoginViewController.instantiate(withViewModel: LoginViewModel(), storyBoardName: "Login")
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: vc, withNextStepper: vc))
    }
    
    private func naviToMain() -> FlowContributors {
        let vc = MainViewController.instantiate(withViewModel: MainViewModel(withService: service), storyBoardName: "Main")
        
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: vc, withNextStepper: vc))
    }
}

class AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    private let appServices: AppServices
    private let disPoseBag = DisposeBag()
    
    var initialStep: Step {
        return AppStep.goLogin
    }
    
    init(withService service: AppServices) {
        self.appServices = service
    }

    
}

