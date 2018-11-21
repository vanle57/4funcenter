//
//  TeacherCollectionCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

final class TeacherCollectionCellViewModel {

    // MARK: - Properties
    var imageUrl = ""
    var name = ""

    // MARK: - init
    init(teacher: Teacher) {
        imageUrl = teacher.imageUrl
        name = teacher.fullName
    }
}
