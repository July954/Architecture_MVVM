//
//  ValidationModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


protocol ValidationModel {

    var errorMessage: String { get }
    
    //Observable
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String> { get }
    
    //Validation
    func validate() -> Bool
    
}

struct USER_VALUE {
    let USER_EMAIL = "shan@shan.com"
    let USER_PW    = "shan1234"
    
    
    ///// 개발시에는 로그인 넘어가기
//    let DEVLOP = true
    let DEVLOP = false
}
  
