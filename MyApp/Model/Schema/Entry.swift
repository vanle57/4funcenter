//
//  Blog.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Entry {

    // MARK: - Properties
    var imageUrl = ""
    var title = ""
    var description = ""
    var authorName = ""
    var content = ""
    var dateCreated: Date = Date()

    // MARK: - init
    init(imageUrl: String, title: String, description: String, authorName: String, content: String, dateCreated: Date) {
        self.imageUrl = imageUrl
        self.title = title
        self.description = description
        self.authorName = authorName
        self.content = content
        self.dateCreated = dateCreated
    }
}
