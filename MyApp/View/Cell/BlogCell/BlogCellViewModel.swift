//
//  BlogCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class BlogCellViewModel: ViewModel {

  // MARK: - Properties
  var imageUrl = ""
  var title = ""
  var numberOfView = 0
  var numberOfComment = 0
  var description = ""
  var dateCreated = ""

  // MARK: - init
  init(entry: Entry) {
    imageUrl = entry.imageUrl
    title = entry.title
    numberOfView = entry.numberOfViews
    numberOfComment = entry.numberOfComments
    description = entry.description
    dateCreated = entry.dateCreated.string()
  }
}
