//
//  HomeTableCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class HomeCellViewModel {
  // MARK: - Property
  private let teachers: [Teacher]

  init(teachers: [Teacher] = []) {
    self.teachers = teachers
  }

  // MARK: - Functions
  func numberOfItem() -> Int {
    return teachers.count
  }

  func viewModelForCollectionViewcell(at indexPath: IndexPath) -> TeacherHomeCellViewModel {
    let teacher = teachers[indexPath.row]
    let teacherCell = TeacherHomeCellViewModel(teacher: teacher)
    teacherCell.imageUrl = teacher.imageUrl
    teacherCell.teacherName = teacher.fullName
    return teacherCell
  }
}
