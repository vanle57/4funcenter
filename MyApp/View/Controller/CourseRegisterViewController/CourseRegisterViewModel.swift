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

  // MARK: - Properties for table view
  var sections: [TypeOfSection] = [.classInfor, .studentInfor]
  var classRows: [TypeOfClassInforRow] = [.course, .time, .fee, .classes, .scheduler]
  var studentRows: [TypeOfStudentInforRow] = [.fullName, .email, .phoneNumber, .numberOfIdCard, .gender, .address]

  // MARK: - Properties for register
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
      guard let result = Int(value) else { throw App.Error.invalidNumberFormat }
      information.numberOfIdCard = result
    case .phoneNumber:
      guard let result = Int(value) else { throw App.Error.invalidNumberFormat }
      information.phoneNumber = result
    case .gender:
      information.gender = true
    }
  }

  func register(_ completion: @escaping RegisterCompletion) {
    do {
      try validate()

      // TODO: query api to register
      completion(.success)
    } catch let error {
      completion(.failure(error))
    }
  }

  /// this function is used to validate all case of register action
  /// including: check empty field, valid email and phone number
  ///
  /// - Throws: throw register error
  func validate() throws {
    if information.fullName.isEmpty || information.email.isEmpty || information.phoneNumber == 0 || information.numberOfIdCard == 0 {
      throw App.Error.registerCourse
    }
  }
}

// MARK: - enum
extension CourseRegisterViewModel {
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

  enum RegisterResult {
    case success
    case failure(Error)
  }

  typealias RegisterCompletion = (RegisterResult) -> Void
}

// MARK: - Table view
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
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: course.openingDate))
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
