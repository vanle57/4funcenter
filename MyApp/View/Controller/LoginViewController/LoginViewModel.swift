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
        guard isValidEmail() else {
            completion(.failure(App.Error.invalidEmailError))
            return
        }
        guard isValidPassword() else {
            completion(.failure(App.Error.invalidPasswordError))
            return
        }
        //query api
        Session.share.accessToken = "accessTokenOfUser"
        completion(.success)
    }

    /// this function is used to validate email.
    ///
    /// - Returns: return true if it is valid email, otherwise return false
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    /// this function is used to validate password
    /// the password must have at least 1 uppercase, 1 digit, 1 lowercase, 8 characters total
    ///
    /// - Returns: return true if it is valid password, otherwise return false
    func isValidPassword() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }

//    func loginToFacebook(_ completion: @escaping LoginCompletion) throws {
//        let loginManager = LoginManager()
//        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
//            switch loginResult {
//            case .Failed(let error):
//                completion(.failure(error))
//            case .Cancelled:
//                completion(.cancelled)
//            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
//                completion(.success)
//            }
//        }
//    }
}
