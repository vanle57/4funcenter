//
//  TeacherCollectionCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class TeacherCollectionCellModel {

    var image: UIImage = UIImage()
    var teacherName: String = ""

    init(teacher: Teacher) {
        self.image = teacher.image
        self.teacherName = teacher.name
    }
}
