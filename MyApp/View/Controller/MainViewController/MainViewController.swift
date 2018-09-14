//
//  MainViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import LGSideMenuController

class MainViewController: LGSideMenuController {

    func setup() {

            leftViewController = UITableViewController()

            leftViewWidth = 250.0
            leftViewBackgroundImage = UIImage(named: "imageLeft")
            leftViewBackgroundColor = UIColor(red: 0.5, green: 0.65, blue: 0.5, alpha: 0.95)
//            rootViewCoverColorForLeftView = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.05)

        // -----

        leftViewPresentationStyle = .slideBelow
    }

    override func leftViewWillLayoutSubviews(with size: CGSize) {
        super.leftViewWillLayoutSubviews(with: size)

        if !isLeftViewStatusBarHidden {
            leftView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }

    override var isLeftViewStatusBarHidden: Bool {
        get {

            return super.isLeftViewStatusBarHidden
        }

        set {
            super.isLeftViewStatusBarHidden = newValue
        }
    }

    deinit {
        print("MainViewController deinitialized")
    }

}
