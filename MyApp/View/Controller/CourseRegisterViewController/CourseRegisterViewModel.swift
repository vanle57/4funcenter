//
//  CourseRegisterViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM
import RealmSwift

final class CourseRegisterViewModel: ViewModel {

  // MARK: - Properties for table view
  var sections: [TypeOfSection] = [.classInfor, .studentInfor]
  var classRows: [TypeOfClassInforRow] = [.course, .time, .fee, .classes, .scheduler]
  var studentRows: [TypeOfStudentInforRow] = [.fullName, .email, .phoneNumber, .numberOfIdCard, .gender, .address]

  // MARK: - Properties for register
  var course: Course = Course()
  var scheduler = ""
  var user: User = User()

  init() { }

  init(course: Course) {
    self.course = course
  }

  func loadUserFromRealm() throws {
    let realm = try Realm()
    if let user = realm.objects(User.self).last {
      self.user = user
    }
  }

  func register(_ completion: @escaping RegisterCompletion) {
    do {
      try validate()

      guard let token = Session.share.accessToken else { return }
      let params = Api.RegisterCourse.RegisterParams(id: course.id, token: token)
      Api.RegisterCourse.register(params: params) { (result) in
        switch result {
        case .success:
          completion(.success)
        case .failure(let error):
          completion(.failure(error))
        }
      }
    } catch let error {
      completion(.failure(error))
    }
  }

  /// this function is used to validate all case of register action
  /// including: check empty field
  ///
  /// - Throws: throw register error
  func validate() throws {
    if user.fullName.isEmpty || user.email.isEmpty || user.phoneNumber.isEmpty || user.idCardNumber.isEmpty {
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
      return viewModelForStudentInforItem(at: indexPath.row)
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

  func viewModelForStudentInforItem(at row: Int) -> CourseRegisterCellViewModel {
    let rowType = studentRows[row]

    switch rowType {
    case .fullName:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.fullName))
    case .email:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.email))
    case .phoneNumber:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.phoneNumber))
    case .numberOfIdCard:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.idCardNumber))
    case .gender:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.gender ? "Female" : "Male"))
    case .address:
      return CourseRegisterCellViewModel(title: rowType.rawValue, type: .justDisplay(content: user.address))
    }
  }
}
