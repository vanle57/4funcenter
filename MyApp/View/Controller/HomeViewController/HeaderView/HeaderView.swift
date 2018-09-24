//
//  HeaderView.swift
//  MyApp
//
//  Created by MBA0002 on 9/24/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: HeaderViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
        }
    }

    @IBAction func moreButtonTouchUpInside(_ sender: Any) {
    }
}
