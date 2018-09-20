//
//  CourseCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CourseCellViewModel {

    // MARK: - Properties
    var imageUrl = ""
    var name = ""
    var description = ""
    var numberOfView = ""
    var numberOfComment = ""

    // MARK: - init
    init(course: Course) {
        imageUrl = course.imageUrl
        name = course.name
        description = course.description
        numberOfView = "\(course.numberOfView)"
        numberOfComment = "\(course.numberOfComment)"
    }
}
