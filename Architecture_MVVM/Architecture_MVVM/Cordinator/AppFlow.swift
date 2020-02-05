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
        case .goLogin:
            return naviToMain()
        }
    }
    
    private let sb = UIStoryboard(name: "Main", bundle: nil)
    
    private func naviToMain() -> FlowContributors {
        var mainVC: UIViewController
        if #available(iOS 13.0, *) {
             mainVC = sb.instantiateViewController(identifier: "Main")
        } else {
            mainVC = sb.instantiateViewController(withIdentifier: "Main")
        }
        self.rootViewController.pushViewController(mainVC, animated: false)
        
        return .none
    }
}

class AppStepper: Stepper {
    var steps = PublishRelay<Step>()

    
}

