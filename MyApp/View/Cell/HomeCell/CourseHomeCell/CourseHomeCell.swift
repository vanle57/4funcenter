//
//  CourseHomeCell.swift
//  MyApp
//
//  Created by Van Le H. on 11/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseHomeCell: UICollectionViewCell {

  // MARK: - Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  var viewModel: CourseHomeCellViewModel? {
    didSet {
      updateUI()
    }
  }

  func updateUI() {
    guard let viewModel = viewModel else { return }
    imageView.setImage(path: viewModel.imageUrl)
    nameLabel.text = viewModel.name
  }
}
