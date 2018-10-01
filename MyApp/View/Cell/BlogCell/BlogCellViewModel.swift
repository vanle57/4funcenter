//
//  BlogCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

class BlogCellViewModel: ViewModel {

    // MARK: - Properties
    var imageUrl = ""
    var title = ""
    var authorName = ""
    var description = ""
    var dateCreated = ""

    // MARK: - init
    init(entry: Entry) {
        imageUrl = entry.imageUrl
        title = entry.title
        authorName = "\(entry.authorName) -"
        description = entry.description
        dateCreated = entry.dateCreated.string()
    }
}
