//
//  PageMenuCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class PageMenuCell: CollectionCell {

    @IBOutlet weak var itemTitleLabel: UILabel!

    var viewModel: PageMenuCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            itemTitleLabel.text = viewModel.title
            itemTitleLabel.textColor = viewModel.fontColor
            backgroundColor = viewModel.backgroundColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
