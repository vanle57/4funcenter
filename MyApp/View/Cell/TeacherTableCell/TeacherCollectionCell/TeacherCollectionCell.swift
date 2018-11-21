//
//  TeacherCollectionCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherCollectionCell: CollectionCell {

    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var viewModel: TeacherCollectionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            avatarImageView.setImage(path: viewModel.imageUrl)
            nameLabel.text = viewModel.name
        }
    }
}
