//
//  BaseNavigationController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: App.Color.navigationTittleColor]
        navigationBar.tintColor = App.Color.navigationBarTintColor
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}
