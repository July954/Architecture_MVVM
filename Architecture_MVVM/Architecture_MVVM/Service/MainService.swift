//
//  MainService.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/06.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import RxSwift
import Moya


protocol HasMainService {
    var mainService: MainService { get }
    
}

class MainService {
    
//    private let provider = Networking<Marvel>()
    private let provider = MoyaProvider<Marvel>()
    
    func requestMarvelAPI() -> Single<Marvel.state> {
        
        return Single<Marvel.state>.create { (single) -> Disposable in
            self.provider.request(.comics) { (result) in
                
                switch result {
                case .success(let response):
                    do {
                        return single(.success(.ready(
                            try response.map(MarvelResponse<Comic>.self).data.results
                        )))
                    } catch {
                        Utilty.shared.print(output: error)
                        return single(.error(error))
                    }
                case .failure(let error):
                    Utilty.shared.print(output: error)
                    return single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
}

extension MainService: ReactiveCompatible {
    
}

extension Reactive where Base: MainService {
    func requestMarvelAPI() -> Observable<Marvel.state> {
        return base.requestMarvelAPI().asObservable()
    }
}
