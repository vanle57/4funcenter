//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import LGSideMenuController

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    override func setupUI() {
        super.setupUI()
        title = "Home"
    }

    private func configNavigationBar() {
        let notificationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_notification"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = notificationButton
    }
}
