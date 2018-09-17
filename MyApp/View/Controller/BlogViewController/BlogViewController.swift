//
//  BlogViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class BlogViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    override func setupUI() {
        super.setupUI()
        title = "Blog"
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
    }
}
