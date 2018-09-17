//
//  BlogCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class BlogCell: TableCell {

    // MARK: - Outlets
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextView.textContainerInset = UIEdgeInsets.zero
        contentTextView.textContainer.lineFragmentPadding = 0
    }
    
}
