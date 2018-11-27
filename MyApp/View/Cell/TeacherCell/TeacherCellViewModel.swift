//
//  TeacherCellViewModel.swift
//  MyApp
//
//  Created by Van Le H. on 11/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class TeacherCellViewModel {

  var avatarUrl = ""
  var name = ""

  init(teacher: Teacher) {
    avatarUrl = teacher.imageUrl
    name = teacher.fullName
  }
}
