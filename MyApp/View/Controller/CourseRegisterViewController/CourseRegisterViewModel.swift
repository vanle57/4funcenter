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
    var scheduler = ""
    var information: RegisterInformationForm = RegisterInformationForm()

    func saveInformationForIndex(index: Int, value: String) throws {
        let type = studentRows[index]
        switch type {
        case .fullName:
            information.fullName = value
        case .email:
            information.email = value
        case .address:
            information.address = value
        case .numberOfIdCard:
            guard let result = Int(value) else { throw App.Error.invalidNumberFormatError }
            information.numberOfIdCard = result
        case .phoneNumber:
            guard let result = Int(value) else { throw App.Error.invalidNumberFormatError }
            information.phoneNumber = result
        case .gender:
            information.gender = true
        }
    }
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

    func titleForHeaderInSection(in section: Int) -> String {
        return sections[section].rawValue
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
            return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: scheduler))
        }
    }
}

struct RegisterInformationForm {
//    var courseId: Int
//    var classId: Int
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: Int = 0
    var numberOfIdCard: Int = 0
    var gender: Bool = false
    var address: String = ""
}
