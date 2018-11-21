//
//  BlogCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class BlogCell: TableCell {

  // MARK: - Outlets
  @IBOutlet weak var entryImageView: UIImageView!
  @IBOutlet weak var entryTitleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var viewLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var dateCreateLabel: UILabel!

  var viewModel: BlogCellViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      entryImageView.setImage(path: viewModel.imageUrl)
      entryTitleLabel.text = viewModel.title
      descriptionLabel.text = viewModel.description
      viewLabel.text = "View: \(viewModel.numberOfView)"
      commentLabel.text = "Comment: \(viewModel.numberOfComment)"
      dateCreateLabel.text = viewModel.dateCreated
    }
  }
}
