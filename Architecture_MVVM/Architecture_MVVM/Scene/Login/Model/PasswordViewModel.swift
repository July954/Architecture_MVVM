//
//  PasswordViewModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import RxCocoa
import Reusable
import RxSwift


class PasswordViewModel: ValidationModel {
    
    var errorMessage: String = "Please Enter Right Password"
    
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    func validate() -> Bool {
        
        print("PasswordViewModel \(data.value)")
        
        guard validation(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }

        errorValue.accept("")
        
        return true
    }
    
    func validation(text: String) -> Bool {
        return (text.count >= 8) && (text.count <= 15) && (text == USER_VALUE().USER_PW)
    }
    
}
