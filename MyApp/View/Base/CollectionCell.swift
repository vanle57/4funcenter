//
//  CollectionCell.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class CollectionCell: UICollectionViewCell, MVVM.View {
    override init(frame: CGRect) {
        super.init(frame: frame)
        corner = 15
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
