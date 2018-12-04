//
//  IntExt.swift
//  MyApp
//
//  Created by MBA0002 on 10/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Int {
    func selfDivide() -> Int {
        var num = self
        var count = 0
        while num > 0 {
            count += 1
            num /= 10
        }
        return count
    }
}
