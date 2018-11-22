//
//  TeacherCollectionCellModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

final class TeacherCollectionCellModel {

    var imageUrl = ""
    var teacherName = ""

    init(teacher: Teacher) {
        self.imageUrl = teacher.imageUrl
        self.teacherName = teacher.fullName
    }
}
