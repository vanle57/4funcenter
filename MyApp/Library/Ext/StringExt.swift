//
//  String.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import SwiftUtils
import CommonCrypto

enum Process {
  case encode
  case decode
}

extension String {

  var trimmed: String {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }

  func base64(_ method: Process) -> String? {
    switch method {
    case .encode:
      guard let data = data(using: .utf8) else { return nil }
      return data.base64EncodedString()
    case .decode:
      guard let data = Data(base64Encoded: self) else { return nil }
      return String(data: data, encoding: .utf8)
    }
  }
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + dropFirst()
  }
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }

  /// this function is used to validate email.
  ///
  /// - Returns: return true if it is valid email, otherwise return false
  func isValidEmail() -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }

  /// this function is used to validate password
  /// the password must have at least 1 uppercase, 1 digit, 1 lowercase, 8 characters total
  ///
  /// - Returns: return true if it is valid password, otherwise return false
  func isValidPassword() -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
    return passwordTest.evaluate(with: self)
  }

  func md5() -> String {
    guard let messageData = self.data(using: .utf8) else { return "" }
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    _ = digestData.withUnsafeMutableBytes { digestBytes in
      messageData.withUnsafeBytes { messageBytes in
        CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
      }
    }

    return "\(digestData)"
  }
}
