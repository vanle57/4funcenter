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
    case fullName = "Your Name"
    case gender = "Gender"
    case email = "Email"
    case birth = "Birthday"
    case phoneNumber = "Phone Number"
    case address = "Address"
    case idCardNumber = "Identify card"
  }

  enum ChangePasswordResult {
    case success
    case failure(error: Error)
  }

  typealias ChangePasswordCompletioon = (ChangePasswordResult) -> Void

  enum ChangePasswordError: Error {
    case emptyField
    case oldPasswordIncorrect
    case invalidPassword
    case confirmPasswordNotMatch

    var localizedDescription: String {
      switch self {
      case .emptyField:
        return App.Error.emptyField.localizedDescription
      case .oldPasswordIncorrect:
        return "Incorrect old password"
      case .invalidPassword:
        return App.Error.invalidPassword.localizedDescription
      case .confirmPasswordNotMatch:
        return "New password and confirm password does not match"
      }
    }
  }

  // MARK: - Properties
  var profileRows: [RowType] = [.fullName, .gender, .email, .birth, .phoneNumber, .address, .idCardNumber]
  var user: User = User()
  var oldPassword = ""
  var newPassword = ""
  var confirmPassword = ""

  func loadUserFromRealm() throws {
    let realm = try Realm()
    if let user = realm.objects(User.self).last {
      self.user = user
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
    case .fullName: return ProfileCellViewModel(title: item.rawValue, text: user.fullName)
    case .address: return ProfileCellViewModel(title: item.rawValue, text: user.address)
    case .birth: return ProfileCellViewModel(title: item.rawValue, text: user.birthDay)
    case .email: return ProfileCellViewModel(title: item.rawValue, text: user.email)
    case .gender: return ProfileCellViewModel(title: item.rawValue, text: user.gender ? "Female" : "Male")
    case .phoneNumber: return ProfileCellViewModel(title: item.rawValue, text: user.phoneNumber)
    case .idCardNumber: return ProfileCellViewModel(title: item.rawValue, text: user.idCardNumber)
    }
  }

  func changePassword(completion: ChangePasswordCompletioon) {
    do {
      try validate()

      // TODO: query api to change password
      completion(.success)
    } catch let error {
      completion(.failure(error: error))
    }
  }

  /// this function is used to validate all case of change password action
  ///
  /// - Throws: throw change password error
  func validate() throws {
    if oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
      throw ChangePasswordError.emptyField
    }

    // TODO: call api check whether old password is correct or not

    if newPassword != confirmPassword {
      throw ChangePasswordError.confirmPasswordNotMatch
    }

    if !newPassword.isValidPassword() {
      throw ChangePasswordError.invalidPassword
    }
  }
}
