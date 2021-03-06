//
//  HomeCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SlideCell: UICollectionViewCell {

  // MARK: - Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!

  var viewModel: SlideCellViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      imageView.setImage(path: viewModel.imageUrl, placerholder: viewModel.image)
      titleLabel.text = viewModel.title
    }
  }
}
