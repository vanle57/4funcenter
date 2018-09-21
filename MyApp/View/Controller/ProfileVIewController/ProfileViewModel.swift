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

    var typeOfSections: [TypeOfSection] = [.profile, .changePassword]
    var profileRows: [TypeOfProfileRow] = [.userName, .fullName, .gender, .email, .birth, .phoneNumber, .address]
    var passwordRows: [TypeOfChangePasswordRow] = [.oldPassword, .newPassword, .confirmPassword]

    func numberOfSection() -> Int {
        return typeOfSections.count
    }

    func numberOfItemInSectin(inSection section: Int) -> Int {
        let typeOfsection = typeOfSections[section]
        switch typeOfsection {
        case .profile:
            return profileRows.count
        case .changePassword:
            return passwordRows.count
        }
    }
}
