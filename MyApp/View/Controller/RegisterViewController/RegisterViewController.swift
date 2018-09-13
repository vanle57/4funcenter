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

    @IBOutlet weak var fullnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailOrPhoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var checkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        fullnameTextField.delegate = self
        emailOrPhoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fullnameTextField.resignFirstResponder()
        emailOrPhoneNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }

    private func register() {
    }

    @IBAction func cameraButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func checkButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullnameTextField {
            emailOrPhoneNumberTextField.becomeFirstResponder()
            return true
        }
        if textField == emailOrPhoneNumberTextField {
            passwordTextField.becomeFirstResponder()
            return true
        }
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
            return true
        }
        if textField == confirmPasswordTextField {
            register()
            return true
        }
        return true
    }
}
