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

            leftViewController = SideMenuViewController()

            leftViewWidth = 280.0
            leftViewBackgroundBlurEffect = UIBlurEffect(style: .light)
            leftViewBackgroundColor = UIColor.white
            leftViewPresentationStyle = .slideAbove
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
