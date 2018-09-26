//
//  HeaderView.swift
//  MyApp
//
//  Created by MBA0002 on 9/24/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate: class {
    func headerView(_ view: HeaderView, needPerform action: HeaderView.Action)
}

class HeaderView: UITableViewHeaderFooterView {

    enum Action {
        case navigatetoViewController(index: Int)
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    weak var delegate: HeaderViewDelegate?

    var viewModel: HeaderViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            moreButton.tag = viewModel.id
            titleLabel.text = viewModel.title
        }
    }

    @IBAction func moreButtonTouchUpInside(_ sender: UIButton) {
        delegate?.headerView(self, needPerform: .navigatetoViewController(index: sender.tag))
    }
}
