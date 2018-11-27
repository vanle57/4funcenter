//
//  TeacherCell.swift
//  MyApp
//
//  Created by Van Le H. on 11/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherCell: UITableViewCell {

  // MARK: - Outlets
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!

  var viewModel: TeacherCellViewModel? {
    didSet {
      updateUI()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImageView.circle()
  }

  func updateUI() {
    guard let viewModel = viewModel else { return }
    avatarImageView.setImage(path: viewModel.avatarUrl)
    nameLabel.text = viewModel.name
  }
}
