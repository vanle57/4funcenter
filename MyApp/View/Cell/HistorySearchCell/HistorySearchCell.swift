//
//  HistorySearchCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HistorySearchCell: TableCell {

    // MARK: - Outlet
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: HistorySearchCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
        }
    }
}
