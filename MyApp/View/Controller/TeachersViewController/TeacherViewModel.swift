//
//  TeacherViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class TeacherViewModel: ViewModel {

    // MARK: - enum
    enum SectionType {
        case cover
        case teachers
    }

    // MARK: - Properties
    var sections: [SectionType] = [.cover, .teachers]
}
