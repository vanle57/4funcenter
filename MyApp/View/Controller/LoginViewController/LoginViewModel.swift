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
      completion(.failure(App.Error.emptyField))
      return
    }

//    if !password.isValidPassword() {
//      completion(.failure(App.Error.invalidPassword))
//    }

    let params = Api.User.LoginParams(email: email, password: password.md5())
    Api.User.login(params: params) { (result) in
      switch result {
      case .success:
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
