//
//  AppService.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import RxSwift

struct AppServices: HasAppService, HasMainService{
    let appService: AppService
    let mainService: MainService
}

protocol HasAppService {
    var appService: AppService { get }
}

class AppService {

}

extension AppService: ReactiveCompatible {}

extension Reactive where Base: AppService {
//    func getLoginValidation() -> Observable<LoginModel> {
//        return base.getLoginValidation().asObserVable()
//    }
}


