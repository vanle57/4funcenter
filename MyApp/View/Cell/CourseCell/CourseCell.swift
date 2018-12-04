//
//  CourseCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CourseCell: TableCell {

  // MARK: - Outlets
  @IBOutlet weak var courseImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var numberOfViewLabel: UILabel!
  @IBOutlet weak var numberOfCommentLabel: UILabel!

  var viewModel: CourseCellViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      courseImageView.setImage(path: viewModel.imageUrl)
      nameLabel.text = viewModel.name
      descriptionLabel.text = viewModel.description
      numberOfViewLabel.text = viewModel.numberOfView
      numberOfCommentLabel.text = viewModel.numberOfComment
    }
  }
}
