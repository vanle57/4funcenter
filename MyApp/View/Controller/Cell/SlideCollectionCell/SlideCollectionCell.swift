//
//  HomeCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SlideCollectionCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: SlideCollectionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            imageView.image = viewModel.image
            titleLabel.text = viewModel.title
        }
    }
}
