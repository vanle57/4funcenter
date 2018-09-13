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
        case notAgreeWith4FunTerms

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
            case .notAgreeWith4FunTerms:
                return "Did you agree with 4fun terms?"
            }
        }
    }

    enum RegisterResult {
        case success
        case failure(Error)
    }
    typealias RegisterCompletion = (RegisterResult) -> Void

    // MARK: - Properties
    var avatar: UIImage = #imageLiteral(resourceName: "img_no_avatar")
    var username = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isChecked = false

    init() { }
    init(avatar: UIImage?, username: String, email: String, password: String, confirmPassword: String, isChecked: Bool) {
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.isChecked = isChecked
        if let avatar = avatar {
            self.avatar = avatar
        }
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

        if !isChecked {
            throw RegisterError.notAgreeWith4FunTerms
        }
    }
}
