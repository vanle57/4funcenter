//
//  ViewController.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM
import SVProgressHUD

class BaseViewController: UIViewController, MVVM.View {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        configBackButton()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - setup Data & UI
    func setupData() {

    }

    func setupUI() {

    }

    func configBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
