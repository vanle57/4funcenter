//
//  TeacherCollectionCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class TeacherCollectionCell: CollectionCell {

    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fieldLabel: UILabel!

    var viewModel: TeacherCollectionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            avatarImageView.image = viewModel.image
            nameLabel.text = viewModel.name
            fieldLabel.text = viewModel.position
        }
    }
}
