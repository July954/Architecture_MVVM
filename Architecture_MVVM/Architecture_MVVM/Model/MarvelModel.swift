//
//  MarvelModel.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/06.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import Moya

public enum Marvel {
    
    //API_KEY
    private static let public_key = "54d6ba7c19ff388eb419379732390e70"
    private static let private_key = "253dd58c9ce2e1feca300290b75abb88dfd3d567"
    
    //API_PATH
    case comics
    
    /**
     Etc
     case characters
     case creators
     case events
     */
}

extension Marvel {
    enum state {
        case loading
        case ready([Comic])
        case error
    }
}

extension Marvel: TargetType {
    
    public var baseURL: URL {
        return URL(string : "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .comics:
            return "/comics"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .comics:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .comics:
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
        }
       
    }
    
    var parameters: [String : Any]? {
        //Deafault Setting With Marvel API
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.private_key + Marvel.public_key).md5
        let authParam = [
            "apikey" : Marvel.public_key,
            "ts"     : ts,
            "hash"   : hash
        ]
        
        
        switch self {
        case .comics:
            return [
                "format" : "comic",
                "formatType" : "comic",
                "orderBy" : "-onsaleDate",
                "dateDescriptor" : "lastWeek",
                "limit" : String(50)].merging(authParam) { $1 }
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
