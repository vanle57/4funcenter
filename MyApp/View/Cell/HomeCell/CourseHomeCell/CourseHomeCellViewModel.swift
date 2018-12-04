//
//  CourseHomeCellViewModel.swift
//  MyApp
//
//  Created by Van Le H. on 11/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CourseHomeCellViewModel {

  var imageUrl = ""
  var name = ""

  init(course: Course) {
    imageUrl = course.imageUrl
    name = course.name
  }
}
