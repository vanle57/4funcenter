//
//  RegisterViewController.swift
//  MyApp
//
//  Created by PCM0019 on 7/31/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterController: BaseViewController {

    @IBOutlet weak var fullnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailOrPhoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setupUI() {
        title = "Register"
    }

    override func setupData() {
    }
}
