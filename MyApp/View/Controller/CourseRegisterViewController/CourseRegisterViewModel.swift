//
//  CourseRegisterViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseRegisterViewModel: ViewModel {

    var course: Course = Course()

    init() { }

    init(course: Course) {
        self.course = course
    }

    enum TypeOfSection: String {
        case classInfor = "Class information"
        case studentInfor = "Your information"
    }

    enum TypeOfClassInforRow: String {
        case course = "Course"
        case time = "Time"
        case fee = "Fee"
        case classes = "Class"
        case scheduler = "Scheduler"
    }

    enum TypeOfStudentInforRow: String {
        case fullName = "Full Name(*)"
        case email = "Email(*)"
        case phoneNumber = "Phone Number(*)"
        case numberOfIdCard = "Id card(*)"
        case gender = "Gender"
        case address = "Address"
    }

    var sections: [TypeOfSection] = [.classInfor, .studentInfor]
    var classRows: [TypeOfClassInforRow] = [.course, .time, .fee, .classes, .scheduler]
    var studentRows: [TypeOfStudentInforRow] = [.fullName, .email, .phoneNumber, .numberOfIdCard, .gender, .address]

}

extension CourseRegisterViewModel {

    func numberOfSection() -> Int {
        return sections.count
    }


    func numberOfItemInSection(inSection section: Int) -> Int {

        let typeOfSection = sections[section]

        switch typeOfSection {
        case .classInfor:
            return classRows.count
        case .studentInfor:
            return studentRows.count
        }
    }

    func viewModelForItem(at indexPath: IndexPath) -> CourseRegisterCellViewModel {

        let typeOfSection = sections[indexPath.section]

        switch typeOfSection {
        case .classInfor:
            return viewModelForClassInforItem(at: indexPath.row)
        case .studentInfor:
            let rowType = studentRows[indexPath.row]
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .normal)
        }
    }

    func viewModelForClassInforItem(at row: Int) -> CourseRegisterCellViewModel {
        let rowType = classRows[row]

        switch rowType {
        case .course:
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: course.name))
        case .time:
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: course.time))
        case .fee:
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: "\(course.fee)"))
        case .classes:
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .choose)
        case .scheduler:
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: ""))
        }
    }
}
