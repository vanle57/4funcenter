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
    var fontColor: UIColor = App.Color.yellowColor
    var backgroundColor: UIColor = App.Color.blackColor

    var title = ""

    init(title: String) {
        self.title = title
    }
}
