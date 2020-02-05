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

class ViewModel: Reactor {
    var initialState: ViewModel.State = State()
    
//    var service: AppServices
    
    enum LoginResult {
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
    
    struct State {
        var result: LoginResult = .fail
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: ViewModel.Action) -> Observable<ViewModel.Mutation> {
        switch action {
        case .userTapLogin:
            return Observable.just(Mutation.checkLoginValidation)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> ViewModel.State {
        var state = state
        
        switch mutation {
        case .checkLoginValidation:
            state.result = validationLogin()
            break
        }
        
        return state
    }
    
    
    fileprivate func validationLogin() -> LoginResult {
        print("validationLogin :: pass")
        return .fail
    }
    
}
