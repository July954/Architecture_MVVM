//
//
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/06.
//  Copyright © 2020 shAhn. All rights reserved.
//

import Foundation
import CommonCrypto
import RxSwift
import Moya

//MARK: String
extension String {
    var md5: String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes { (digestBytes) -> Bool in
            messageData.withUnsafeBytes({ (messageBytes) -> Bool in
                _ = CC_MD5(messageBytes.baseAddress, CC_LONG(messageData.count), digestBytes.bindMemory(to: UInt8.self).baseAddress)
                return true
            })
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

//MARK: Date
extension Date {
  init?(ISO8601: String) {
    let isoFormatter = ISO8601DateFormatter()

    guard let date = isoFormatter.date(from: ISO8601) else { return nil }
    self = date
  }
}
