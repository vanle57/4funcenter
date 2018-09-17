//
//  SideMenuViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class SideMenuCellViewModel {

    // MARK: - Properties
    var title = ""
    var isHidden = false

    // MARK: - init
    init(title: String, isHidden: Bool) {
        self.title = title
        self.isHidden = isHidden
    }
}
