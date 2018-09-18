//
//  RegisterSuccessViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class RegisterSuccessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func configNavigationBar() {
        let cancelButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_cancel"), style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc func cancelAction() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func continueButtonTouchUpInside(_ sender: Any) {
        if App.userDefault.string(forKey: App.KeyUserDefault.accessToken) != nil {
            AppDelegate.shared.switchRoot(rootType: .logined)
        } else {
            AppDelegate.shared.switchRoot(rootType: .notLogin)
        }
    }
}
