//
//  SideMenuCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SideMenuCell: TableCell {

    // MARK: - Properties
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    var viewModel: SideMenuCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            itemLabel.text = viewModel.title
            itemLabel.font = viewModel.font
            moreButton.isHidden = viewModel.isNotMain
        }
    }

    @IBAction func moreButtonTouchUpInside(_ sender: Any) {
    }

}
