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

    // MARK: - Properties
    var email = ""
    var password = ""

    // MARK: - Puclic function
    func login(_ completion: @escaping (LoginResult) -> Void) {
    }
}
