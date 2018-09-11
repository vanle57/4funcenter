//
//  Errors.swift
//  MyApp
//
//  Created by PCM0019 on 8/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.

import Foundation

extension App {
    struct Error {
        static let realmError = NSError(domain: "",
                                        code: 10,
                                        userInfo: [NSLocalizedDescriptionKey: "Realm Error"])

        static let unknownError = NSError(domain: "",
                                          code: 11,
                                          userInfo: [NSLocalizedDescriptionKey: "Unknow Error"])

        static let emptyFieldError = NSError(domain: "",
                                             code: 12,
                                             userInfo: [NSLocalizedDescriptionKey: "Empty Field"])

        static let invalidEmailError = NSError(domain: "",
                                               code: 13,
                                               userInfo: [NSLocalizedDescriptionKey: "Invalid email!"])

        static let invalidPasswordError = NSError(domain: "",
                                               code: 14,
                                               userInfo: [NSLocalizedDescriptionKey: "Password must have at least 1 uppercase, 1 digit, 1 lowercase, 8 characters total"])
    }
}
