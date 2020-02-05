//
//  ViewModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/04.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import Reusable

class LoginViewModel: Reactor {
    var initialState: LoginViewModel.State = State()
    var emailViewModel = EmailViewModel()
    var passViewModel = PasswordViewModel()
    
    enum LoginResult {
        case none
        case pass
        case fail
    }

    //Interaction With User
    enum Action {
        case userTapLogin
    }
    
    //Bridge of Action to State
    enum Mutation {
        case checkLoginValidation
    }
    
    //State of View
    struct State {
        var result: LoginResult = .none
        var messgae: String = ""
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: LoginViewModel.Action) -> Observable<LoginViewModel.Mutation> {
        switch action {
        case .userTapLogin:
            return Observable.just(Mutation.checkLoginValidation)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> LoginViewModel.State {
        switch mutation {
        case .checkLoginValidation:
            return validationLogin()
        }
    }
    
    
    fileprivate func validationLogin() -> LoginViewModel.State {
        if emailViewModel.validate() && passViewModel.validate() {
            return State(result: .pass, messgae: "")
        } else {
            if emailViewModel.errorValue.value != ""  {
                return State(result: .fail, messgae: emailViewModel.errorValue.value)
            }
            else if passViewModel.errorValue.value != ""  {
                return State(result: .fail, messgae: passViewModel.errorValue.value)
            }
            else {
                return State(result: .fail, messgae: "")
            }
        }
    }
    
}
