//
//  CodableResponse.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/06.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
  let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}

