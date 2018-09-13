//
//  LoginViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

final class LoginViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!

    var viewModel = LoginViewModel()

    override func setupUI() {
        forgotPasswordButton.underline()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    // MARK: - Private function
    private func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            alert(error: App.Error.emptyFieldError)
            return
        }
        viewModel.email = email
        viewModel.password = password
        viewModel.login { (result) in
            switch result {
            case .success:
                print("sucess")
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }

    // MARK: - IBAction
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        login()
    }

    @IBAction func loginWithFacebookButtonTouchUpInside(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .email, .userBirthday, .userGender, .userHometown, .userLocation, .userPhotos ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                self.alert(error: error)
            case .cancelled:
                break
            case .success( _, _, let accessToken):
                Session.share.accessToken = accessToken.userId
            }
        }
    }

    @IBAction func loginWithGoogleButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func forgotPasswordButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
