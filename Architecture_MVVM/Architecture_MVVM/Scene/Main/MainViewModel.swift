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
import Moya

class MainViewModel: Reactor {

    var initialState: MainViewModel.State = State()
    
    typealias MainServices = HasMainService
    var mainServices: MainServices
    
    //Interaction With User
    enum Action {
        case getMarvelAPI
    }
    
    //Bridge of Action to State
    enum Mutation {
        case resultMarvelAPI(Marvel.state)
    }
    
    //State of View
    struct State {
        var marvelAPIState: Marvel.state = .loading
    }
    
    init(withService services: MainServices) {
        self.mainServices = services
    }
    
    func mutate(action: MainViewModel.Action) -> Observable<MainViewModel.Mutation> {
        switch action {
        case .getMarvelAPI:
            return self.mainServices.mainService.requestMarvelAPI()
                .asObservable()
                .map(Mutation.resultMarvelAPI)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> MainViewModel.State {
        var newState = state
        
        switch mutation {
        case .resultMarvelAPI(.error):
            newState.marvelAPIState = .error
            return newState
        case .resultMarvelAPI(.loading):
            newState.marvelAPIState = .loading
            return newState
        case .resultMarvelAPI(.ready(let result)):
            newState.marvelAPIState = .ready(result)
            return newState
        }
        
    }
}
