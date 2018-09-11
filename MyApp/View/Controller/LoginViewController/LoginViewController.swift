//
//  LoginViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var viewModel = LoginViewModel()

    // MARK: - Private function
    private func login() {
    }

    // MARK: - IBAction
    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        login()
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func forgotPasswordButtonTouchUpInside(_ sender: Any) {
    }
}
