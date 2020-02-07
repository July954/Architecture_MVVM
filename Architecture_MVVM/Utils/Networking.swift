//
//  Networking.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/06.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class Networking<Target: TargetType>: MoyaProvider<Target> {
    func request(_ target: Target) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .do(
                onSuccess: { value in
                    let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                    Utilty.shared.print(output: message)
            },
                onError: { error in
                    if let response = (error as? MoyaError)?.response {
                        if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                            Utilty.shared.print(output: message)
                        } else if let rawString = String(data: response.data, encoding: .utf8) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                            Utilty.shared.print(output: message)
                        } else {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))"
                            Utilty.shared.print(output: message)
                        }
                    } else {
                        let message = "FAILURE: \(requestString)\n\(error)"
                        Utilty.shared.print(output: message)
                    }
            },
                onSubscribed: {
                    let message = "REQUEST: \(requestString)"
                    Utilty.shared.print(output: message)
            }
        )
    }
}

