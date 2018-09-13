//
//  LoginViewModel.swift
//  MyApp
//
//  Created by PCM0019 on 8/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift

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
        guard email.isValidEmail() else {
            completion(.failure(App.Error.invalidEmailError))
            return
        }
        guard password.isValidPassword() else {
            completion(.failure(App.Error.invalidPasswordError))
            return
        }
        //query api
        Session.share.accessToken = "accessTokenOfUser"
        completion(.success)
    }
}
