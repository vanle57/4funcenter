//
//  BaseTabBarController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = App.Color.tabBarTintColor
        tabBar.barTintColor = App.Color.tabBarBarTintColor
        tabBar.backgroundColor = App.Color.tabBarBackgroudColor
    }
}
