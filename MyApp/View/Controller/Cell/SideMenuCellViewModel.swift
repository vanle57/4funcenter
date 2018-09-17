//
//  SideMenuViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SideMenuCellViewModel {

    // MARK: - Properties
    var title = ""
    var isNotMain = false
    var font: UIFont? = App.Font.tableCellTextLabel

    // MARK: - init
    init(title: String, isNotMain: Bool) {
        self.title = title.uppercased()
        self.isNotMain = isNotMain
        if isNotMain {
            font = App.Font.heeboRegularFont
        } else {
            font = App.Font.heeboBoldFont
        }
    }
}
