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
                                        userInfo: [NSLocalizedDescriptionKey: "Lỗi Realm"])

        static let unknownError = NSError(domain: "",
                                          code: 11,
                                          userInfo: [NSLocalizedDescriptionKey: "Lỗi không xác định"])
    }
}
