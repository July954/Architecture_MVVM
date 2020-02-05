//
//  BaseVC.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import ReactorKit
import Reusable
import RxSwift
import RxCocoa
import RxFlow

class BaseVC: UIViewController, Stepper {
    
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(keyBoardWillHide))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyBoardWillHide() {
        view.endEditing(true)
    }
    
}

extension View where Self: StoryboardBased & UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.Reactor {
        let viewController = Self.instantiate()
        viewController.reactor = viewModel
        return viewController
    }
    
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType, storyBoardName: String) -> Self where ViewModelType == Self.Reactor {
        let sb = UIStoryboard.init(name: storyBoardName, bundle: nil)
        if let viewController = sb.instantiateViewController(withIdentifier: String(describing: self)) as? Self {
            viewController.reactor = viewModel
            return viewController
        }
        return Self.instantiate(withViewModel: viewModel)
    }
}
