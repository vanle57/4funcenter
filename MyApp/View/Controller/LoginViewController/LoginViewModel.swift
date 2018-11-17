//
//  LoginViewModel.swift
//  MyApp
//
//  Created by PCM0019 on 8/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift
import CommonCrypto

final class LoginViewModel {
  // MARK: - enum
  enum LoginResult {
    case success
    case failure(Error)
  }
  typealias LoginCompletion = (LoginResult) -> Void

  // MARK: - Properties
  var email = ""
  var password = ""

  // MARK: - Puclic function

  /// this function is used to query api to login
  /// first, check email and password if it is empty, then validate them. finally, call api
  ///
  /// - Parameter completion: return closure for view controller
  func login(_ completion: @escaping LoginCompletion) {

    if email.isEmpty || password.isEmpty {
      completion(.failure(App.Error.emptyFieldError))
      return
    }

    let params = Api.User.LoginParams(email: email, password: md5(password))
    Api.User.login(params: params) { (result) in
      switch result {
      case .success:
        Session.share.accessToken = "accessTokenOfUser"
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func md5(_ string: String) -> Data {
    let messageData = string.data(using:.utf8)!
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
      messageData.withUnsafeBytes {messageBytes in
        CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
      }
    }
    
    return "\(digestDat)"a
  }
}
