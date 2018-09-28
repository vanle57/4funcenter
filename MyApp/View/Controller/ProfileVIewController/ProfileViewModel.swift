//
//  ProfileViewModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class ProfileViewModel: MVVM.Model {

    enum TypeOfSection {
        case profile
        case changePassword
    }

    enum TypeOfProfileRow: String {
        case userName = "User Name"
        case fullName = "Your Name"
        case gender = "Gender"
        case email = "Email"
        case birth = "Birth"
        case phoneNumber = "Phone Number"
        case address = "Address"
    }

    enum TypeOfChangePasswordRow: String {
        case oldPassword = "Old Password"
        case newPassword = "New Password"
        case confirmPassword = "Confirm Password"
    }

    // MARK: - Properties
    var typeOfSections: [TypeOfSection] = [.profile, .changePassword]
    var profileRows: [TypeOfProfileRow] = [.userName, .fullName, .gender, .email, .birth, .phoneNumber, .address]
    var passwordRows: [TypeOfChangePasswordRow] = [.oldPassword, .newPassword, .confirmPassword]

    /// Count Sections in profile table View for user display in table view
    ///
    /// - Returns: Number of sections display in table view
    func numberOfSection() -> Int {
        return typeOfSections.count
    }

    /// Count Number of Cell in each section in Profile table view
    ///
    /// - Parameter section: Current section
    /// - Returns: Number of cell in current section display in table view
    func numberOfItemInSection(inSection section: Int) -> Int {

        let typeOfsection = typeOfSections[section]

        switch typeOfsection {
        case .profile:
            return profileRows.count
        case .changePassword:
            return passwordRows.count
        }
    }

    /// Make view model for Profile TableCellModel
    ///
    /// - Parameter indexPath: indexPath of each item in tableView
    /// - Returns: TableCellModel at indexPath parameter
    func viewModelOfItem(at indexPath: IndexPath) -> TableCellModel {

        let typeOfSection = typeOfSections[indexPath.section]

        switch typeOfSection {
        case .profile:
            return TableCellModel(text: profileRows[indexPath.row].rawValue)
        case .changePassword:
            return TableCellModel(text: passwordRows[indexPath.row].rawValue)
        }
    }

    func confirmPassword(newPassword: String, confirmPassword: String) -> Bool {
        return newPassword == confirmPassword
    }
}
