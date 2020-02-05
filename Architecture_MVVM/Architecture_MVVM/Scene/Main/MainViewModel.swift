//
//  MainViewModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import Reusable

class MainViewModel: Reactor {

    
    var initialState: MainViewModel.State = State()
    
    //Interaction With User
    enum Action {
       
    }
    
    //Bridge of Action to State
    enum Mutation {
        case normal
    }
    
    //State of View
    struct State {
        
    }
    
    init() {
        self.initialState = State()
    }
    
//    func mutate(action: LoginViewModel.Action) -> Observable<LoginViewModel.Mutation> {
//        switch action {
//        default :
//            return
//        }
//    }
//
//    func reduce(state: State, mutation: Mutation) -> LoginViewModel.State {
//        switch mutation {
//        case .norma
//            return .none
//        }
//    }
}
