//
//  HeaderViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/24/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class HeaderViewModel {

    // MARK: - Properties
    var id = 0
    var title = ""

    // MARK: - init
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
