//
//  File.swift
//  MyApp
//
//  Created by MBA0002 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseRegisterCellViewModel: ViewModel {

    enum TextFieldType {
        case normal
        case justDisplay
        case choose
    }

    var title = ""
    var type: TextFieldType = .normal
    var contentToDisplay = ""
    var classesToChoose: [CourseClass] = DummyData.fetchClasses()

    init(title: String, type: TextFieldType) {
        self.title = title
        self.type = type
    }
}

// MARK: - Picker view
extension CourseRegisterCellViewModel {
    func numberOfRowsInComponent() -> Int {
        return classesToChoose.count
    }

    func titleForRow(at index: Int) -> String {
        return classesToChoose[index].name
    }
    func didSelectRow(at index: Int) -> String {
        return classesToChoose[index].scheduler
    }
}
