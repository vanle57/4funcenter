//
//  TableCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd.. All rights reserved.
//

import MVVM

class TableCellModel: ViewModel {

    var textField = ""

    init(text: String) {
        self.textField = text
    }
}
