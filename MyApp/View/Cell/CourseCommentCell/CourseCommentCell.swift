//
//  CourseCommentCell.swift
//  MyApp
//
//  Created by MBA0203 on 9/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseCommentCell: TableCell {
    
    // MARK: - Outlets
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var viewModel: CourseCommentCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            usernameLabel.text = "Demi Lovato"
            commentLabel.text = viewModel.content
            dateCreatedLabel.text = viewModel.dateCreate
            ratingLabel.text = viewModel.ratingString
        }
    }
}
