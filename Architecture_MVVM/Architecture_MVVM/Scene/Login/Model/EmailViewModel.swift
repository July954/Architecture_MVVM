//
//  EmailViewModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import RxCocoa
import Reusable
import RxSwift


class EmailViewModel: ValidationModel {
    
    var errorMessage: String = "Please Enter Right Email"
    
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    func validate() -> Bool {
        
        print("EmailViewModel \(data.value)")
        
        guard validation(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }
        
        errorValue.accept("")
        
        return true
    }
    
    func validation(text: String) -> Bool {
        return text.contains("@") && (text == USER_VALUE().USER_EMAIL)
    }
    
    
}
