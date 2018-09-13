//
//  RegisterViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/13/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: BaseViewController {
    // MARIK: - Outlets
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var checkButton: UIButton!

    var viewModel = RegisterViewModel()

    override func setupUI() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }

    // MARK: - Private functions
    private func register() {
        guard let username = usernameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else {
            alert(error: App.Error.emptyFieldError)
            return
        }
        viewModel = RegisterViewModel(username: username, email: email, password: password, confirmPassword: confirmPassword, isChecked: viewModel.isChecked)
        viewModel.register { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                guard let error = error as? RegisterViewModel.RegisterError else {
                    this.alert(error: App.Error.unknownError)
                    return
                }
                this.alert(title: "ERROR", msg: error.localizedDescription, buttons: ["Agree"], handler: nil)
            }
        }
    }

    private func updateCheckButtonUI() {
        if viewModel.isChecked {
            checkButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
        } else {
            checkButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
        }
    }

    // MARK: - Actions
    @IBAction func cameraButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func checkButtonTouchUpInside(_ sender: Any) {
        viewModel.isChecked = !viewModel.isChecked
        updateCheckButtonUI()
    }

    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
        register()
    }

    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
            return true
        }
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            return true
        }
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
            return true
        }
        if textField == confirmPasswordTextField {
            updateCheckButtonUI()
            register()
            return true
        }
        return true
    }
}
