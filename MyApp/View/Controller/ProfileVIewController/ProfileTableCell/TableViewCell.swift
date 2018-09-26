//
//  TableViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TableViewCell: TableCell {
    @IBOutlet weak var textField: UITextField!

    var viewModel: TableCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textField.placeholder = viewModel.textField
            textField.text = ""
        }
    }
}
