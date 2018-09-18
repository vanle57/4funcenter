//
//  SlideCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SlideCell: TableCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: SlideCellViewModel?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
