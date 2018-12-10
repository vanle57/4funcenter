//
//  TableCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd.. All rights reserved.
//

import MVVM

final class ProfileCellViewModel: ViewModel {

  var title = ""
  var text = ""

  init(title: String, text: String) {
    self.title = title
    self.text = text
  }
}
