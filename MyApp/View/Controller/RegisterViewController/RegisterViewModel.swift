//
//  RegisterViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class RegisterViewModel {
    // MARK: - enum
    enum RegisterError: Error {
        case emptyField
        case userNameTooShort
        case invalidEmail
        case invalidPassword
        case confirmPasswordNotMatch

        var localizedDescription: String {
            switch self {
            case .emptyField:
                return App.Error.emptyFieldError.localizedDescription
            case .userNameTooShort:
                return "User name must have at least 6 characters!"
            case .invalidEmail:
                return App.Error.invalidEmailError.localizedDescription
            case .invalidPassword:
                return App.Error.invalidPasswordError.localizedDescription
            case .confirmPasswordNotMatch:
                return "Password and confirm password does not match"
            }
        }
    }

    enum RegisterResult {
        case success
        case failure(Error)
    }
    typealias RegisterCompletion = (RegisterResult) -> Void

    // MARK: - Properties
    var avatar: UIImage = UIImage()
    var username = ""
    var email = ""
    var password = ""
    var confirmPassword = ""

    init() { }
    init(username: String, email: String, password: String, confirmPassword: String) {
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }

    func register(_ completion: @escaping RegisterCompletion) {
        do {
            try validate()

            // TODO: query api to register
            completion(.success)
        } catch let error {
            completion(.failure(error))
        }
    }

    /// this function is used to validate all case of register action
    /// including: check empty field, check length of username, valid email and password, match cornfirm password
    ///
    /// - Throws: throw register error
    func validate() throws {
        if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            throw RegisterError.emptyField
        }

        if username.count < 6 {
            throw RegisterError.userNameTooShort
        }

        if !email.isValidEmail() {
            throw RegisterError.invalidEmail
        }

        if !password.isValidPassword() {
            throw RegisterError.invalidPassword
        }

        if confirmPassword != password {
            throw RegisterError.confirmPasswordNotMatch
        }
    }
}
