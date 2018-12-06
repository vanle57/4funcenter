//
//  Errors.swift
//  MyApp
//
//  Created by PCM0019 on 8/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.

import Foundation

extension App {
  struct Error {
    static let indexOutOfBound = NSError(domain: "",
      code: 9,
      userInfo: [NSLocalizedDescriptionKey: "Index out or range!"])
    static let realm = NSError(domain: "",
      code: 10,
      userInfo: [NSLocalizedDescriptionKey: "Realm Error"])

    static let unknown = NSError(domain: "",
      code: 11,
      userInfo: [NSLocalizedDescriptionKey: "Unknow Error"])

    static let emptyField = NSError(domain: "",
      code: 12,
      userInfo: [NSLocalizedDescriptionKey: "Empty Field"])

    static let invalidEmail = NSError(domain: "",
      code: 13,
      userInfo: [NSLocalizedDescriptionKey: "Invalid email!"])

    static let invalidPassword = NSError(domain: "",
      code: 14,
      userInfo: [NSLocalizedDescriptionKey: "Password must have at least 1 uppercase, 1 digit, 1 lowercase, 8 characters total"])

    static let invalidNumberFormat = NSError(domain: "",
      code: 15,
      userInfo: [NSLocalizedDescriptionKey: "Invalid number format!"])

    static let invalidPhoneNumber = NSError(domain: "",
      code: 16,
      userInfo: [NSLocalizedDescriptionKey: "Invalid phone number"])

    static let registerCourse = NSError(domain: "",
      code: 17,
      userInfo: [NSLocalizedDescriptionKey: "Please update your profile in advance!"])
  }
}
