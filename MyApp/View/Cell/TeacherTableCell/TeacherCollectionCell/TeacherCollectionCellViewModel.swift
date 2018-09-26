//
//  TeacherCollectionCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherCollectionCellViewModel {

    // MARK: - Properties
    var image = UIImage()
    var name = ""
    var position = ""

    // MARK: - init
    init(teacher: Teacher) {
        image = teacher.image
        name = teacher.name
        position = teacher.positionName
    }
}
