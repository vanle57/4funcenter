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
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!

    var viewModel: BlogCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            entryTitleLabel.text = viewModel.title
            descriptionLabel.text = viewModel.description
            authorNameLabel.text = viewModel.authorName
            dateCreateLabel.text = viewModel.dateCreated
        }
    }
    //override func prepareForReuse() {
        //super.prepareForReuse()
      //  entryImageView.image = nil
    //}
}
