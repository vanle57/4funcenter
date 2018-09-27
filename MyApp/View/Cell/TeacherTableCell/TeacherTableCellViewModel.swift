//
//  TeacherTableCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class TeacherTableCellViewModel: ViewModel {
    var teachers = DummyData.fetchTeachers()
}

extension TeacherTableCellViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return teachers.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> TeacherCollectionCellViewModel {
        let index = indexPath.row

        guard index < teachers.count else {
            throw App.Error.indexOutOfBound
        }

        let teacher = teachers[index]
        return TeacherCollectionCellViewModel(teacher: teacher)
    }
}
