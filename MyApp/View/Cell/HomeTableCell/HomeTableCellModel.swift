//
//  HomeTableCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class HomeTableCellModel {
    // MARK: - Property
    var teachers: [Teacher] = []

    // MARK: - Functions
    func numberOfItem() -> Int {
        return teachers.count
    }

    func viewModelForCollectionViewcell(at indexPath: IndexPath) -> TeacherCollectionCellModel {
        let teacher = teachers[indexPath.row]
        let teacherCell = TeacherCollectionCellModel(teacher: teacher)
        teacherCell.imageUrl = teacher.imageUrl
        teacherCell.teacherName = teacher.fullName
        return teacherCell
    }
}
