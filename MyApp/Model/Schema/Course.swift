//
//  Course.swift
//  MyApp
//
//  Created by MBA0002 on 9/19/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class Course {

    // MARK: - Properties
    var id = 0
    var name = ""
    var numberOfView = 0
    var numberOfComment = 0
    var imageUrl = ""
    var description = ""
    var detail = ""
    var time = ""
    var fee: Double = 0.0

    // MARK: init
    init() { }

    init(name: String, numberOfView: Int, numberOfComment: Int, description: String, detail: String, time: String, fee: Double) {
        self.name = name
        self.numberOfView = numberOfView
        self.numberOfComment = numberOfComment
        self.description = description
        self.detail = detail
        self.time = time
        self.fee = fee
    }
}
