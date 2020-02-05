//
//  AppDelegate.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var disposeBeg = DisposeBag()
    var coordinator = FlowCoordinator()
    
    let appService = AppService()
    lazy var appServices = {
        return AppServices(appService: self.appService)
    }()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         guard let window = self.window else { return false }
        
        
        //Only Ligth Mode
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        //Cordinator
        let appFlow = AppFlow(service: appServices)

        Flows.whenReady(flow1: appFlow) { (root) in
            self.window?.rootViewController = root
            self.window?.makeKeyAndVisible()
        }

        self.coordinator.coordinate(flow: appFlow, with: AppStepper(withService: self.appServices))
        
        return true
    }

}


