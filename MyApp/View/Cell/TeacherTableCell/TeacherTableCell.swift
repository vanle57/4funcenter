//
//  TeacherTableCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class TeacherTableCell: TableCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: TeacherTableCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
