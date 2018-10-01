//
//  PageMenuCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class PageMenuCellViewModel {

    // MARK: - Properties
    var fontColor: UIColor {
        if isSelected {
            return App.Color.blackColor
        } else {
            return App.Color.yellowColor
        }
    }

    var backgroundColor: UIColor {
        if isSelected {
            return App.Color.yellowColor
        } else {
            return App.Color.blackColor
        }
    }

    var title = ""
    var isSelected = false

    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
