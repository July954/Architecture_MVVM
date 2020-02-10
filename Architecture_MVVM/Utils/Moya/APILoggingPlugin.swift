//
//  APILoggingPlugin.swift
//  yumaapp
//
//  Created by Mephrine on 2020/01/29.
//  Copyright © 2020 yuma. All rights reserved.
//

import Moya
import Result
/**
 API 통신 간의 커스텀 로깅.
 */
final class APILoggingPlugin: PluginType {
    // API를 보내기 직전에 호출 - URL, header, path등
    func willSend(_ request: RequestType, target: TargetType) {
        let headers = request.request?.allHTTPHeaderFields ?? [:]
        let urlStr = request.request?.url?.absoluteString ?? "nil"
        if let body = request.request?.httpBody {
            let bodyString = String(bytes: body, encoding: .utf8) ?? "nil"
//            Logger.i(#"*****willSend*****\n \#(body)"#)
            print(#"🤩🤩🤩🤩🤩🤩\n<willSend  - \#(Date().debugDescription)>\n🤔🤔🤔url: \#(urlStr)\n🤭🤭🤭headers: \#(headers)\n😑😑😑body: \#(bodyString)\n🤩🤩🤩🤩🤩🤩"#)
        } else {
            print(#"🤩🤩🤩🤩🤩🤩\n<willSend  - \#(Date().debugDescription)>\n🤔🤔🤔url: \#(urlStr)\n🤭🤭🤭headers: \#(headers)\n😑😑😑body: nil\n🤩🤩🤩🤩🤩🤩"#)
        }
    }
    
    // API를 통해 받은 데이터.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        let response = result.value
        let error = result.error
        let request = response?.request
        let urlStr = request?.url?.absoluteString ?? "nil"
        let method = request?.httpMethod ?? "nil"
        let statusCode = response?.statusCode ?? -999
        var bodyString = "nil"
        if let data = request?.httpBody,
            let string = String(bytes: data, encoding: .utf8) {
            bodyString = string
        }
        var responseString = "nil"
        if let data = response?.data,
            let responseStr = String(bytes: data, encoding: .utf8) {
            responseString = responseStr
        }
        print(#"🤩🤩🤩🤩🤩🤩\n<didReceive - \#(method) statusCode: \#(statusCode)>\n🤔🤔🤔url: \#(urlStr)\n🤭🤭🤭body: \#(bodyString)\n😑😑😑error: \#(error?.localizedDescription ?? "nil")\n🥴🥴🥴response: \#(responseString)\n🤩🤩🤩🤩🤩🤩"#)
    }
}
