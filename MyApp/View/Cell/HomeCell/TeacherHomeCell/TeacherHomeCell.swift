//
//  TeacherCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherHomeCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    // MARK: - Property
    var viewModel: TeacherHomeCellViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - override
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.circle()
    }

    // MARK: - Private Func
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        imageView.setImage(path: viewModel.imageUrl)
        label.text = viewModel.teacherName
    }
}
