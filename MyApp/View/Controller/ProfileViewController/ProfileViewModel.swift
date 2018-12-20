//
//  ProfileViewModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift
import MVVM

final class ProfileViewModel: MVVM.Model {

  // MARK: - enum
  enum RowType: String {
    case firstName = "First Name(*)"
    case lastName = "Last Name(*)"
    case gender = "Gender"
    case email = "Email(*)"
    case birth = "Birthday"
    case phoneNumber = "Phone Number(*)"
    case address = "Address(*)"
    case idCardNumber = "Identify card(*)"
  }

  enum UpdateResult {
    case success
    case failure(error: Error)
  }

  typealias UpdateCompletioon = (UpdateResult) -> Void

  // MARK: - Properties
  var profileRows: [RowType] = [.firstName, .lastName, .gender, .email, .birth, .phoneNumber, .address, .idCardNumber]
  var user: User = User()
  var userUpdate: User = User()

  func loadUserFromRealm() throws {
    let realm = try Realm()
    if let user = realm.objects(User.self).last {
      self.user = user
      userUpdate.id = user.id
      userUpdate.address = user.address
      userUpdate.avatarUrl = user.avatarUrl
      userUpdate.birthDay = user.birthDay
      userUpdate.email = user.email
      userUpdate.firstName = user.firstName
      userUpdate.lastName = user.lastName
      userUpdate.gender = user.gender
      userUpdate.idCardNumber = user.idCardNumber
      userUpdate.phoneNumber = user.phoneNumber
    }
  }

  func numberOfItemInSection(inSection section: Int) -> Int {
    return profileRows.count
  }

  /// Make view model for Profile TableCellModel
  ///
  /// - Parameter indexPath: indexPath of each item in tableView
  /// - Returns: TableCellModel at indexPath parameter
  func viewModelOfItem(at indexPath: IndexPath) -> ProfileCellViewModel {
    let item = profileRows[indexPath.row]
    switch item {
    case .firstName: return ProfileCellViewModel(title: item.rawValue, text: user.firstName)
    case .lastName: return ProfileCellViewModel(title: item.rawValue, text: user.lastName)
    case .address: return ProfileCellViewModel(title: item.rawValue, text: user.address)
    case .birth: return ProfileCellViewModel(title: item.rawValue, text: user.birthDay)
    case .email: return ProfileCellViewModel(title: item.rawValue, text: user.email)
    case .gender: return ProfileCellViewModel(title: item.rawValue, text: user.gender ? "Female" : "Male")
    case .phoneNumber: return ProfileCellViewModel(title: item.rawValue, text: user.phoneNumber)
    case .idCardNumber: return ProfileCellViewModel(title: item.rawValue, text: user.idCardNumber)
    }
  }

  func updateProfile(completion: @escaping UpdateCompletioon) {
    do {
      try validate()

      Api.User.update(user: userUpdate) { (result) in
        switch result {
        case .success:
          completion(.success)
        case .failure(let error):
          completion(.failure(error: error))
        }
      }
    } catch let error {
      completion(.failure(error: error))
    }
  }

  /// this function is used to validate all case of change password action
  ///
  /// - Throws: throw change password error
  func validate() throws {
    if userUpdate.firstName.isEmpty || userUpdate.lastName.isEmpty ||
      userUpdate.email.isEmpty || userUpdate.idCardNumber.isEmpty ||
      userUpdate.phoneNumber.isEmpty || userUpdate.address.isEmpty {
      throw App.Error.emptyField
    }

    if !userUpdate.email.isValidEmail() {
      throw App.Error.invalidEmail
    }

    if Int(userUpdate.phoneNumber) == nil || Int(userUpdate.idCardNumber) == nil {
      throw App.Error.invalidNumberFormat
    }
  }

  func saveInformationForIndex(index: Int, value: String) throws {
    let type = profileRows[index]
    switch type {
    case .firstName:
      guard !value.isEmpty else { throw App.Error.emptyField }
      userUpdate.firstName = value
    case .lastName:
      guard !value.isEmpty else { throw App.Error.emptyField }
      userUpdate.lastName = value
    case .email:
      guard value.isValidEmail() else { throw App.Error.invalidEmail }
      userUpdate.email = value
    case .address:
      userUpdate.address = value
    case .idCardNumber:
      guard Int(value) != nil else { throw App.Error.invalidNumberFormat }
      userUpdate.idCardNumber = value
    case .phoneNumber:
      guard Int(value) != nil else { throw App.Error.invalidNumberFormat }
      userUpdate.phoneNumber = value
    case .gender:
      userUpdate.gender = true
    case .birth:
      break
    }
  }
}
