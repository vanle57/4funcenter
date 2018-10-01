//
//  Comment.swift
//  MyApp
//
//  Created by MBA0203 on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Comment {

    var content = ""
    var ratingPoint = 0
    var dateCreate: Date = Date()

    init(content: String, ratingPoint: Int, dateCreate: Date) {
        self.content = content
        self.ratingPoint = ratingPoint
        self.dateCreate = dateCreate
    }
}
