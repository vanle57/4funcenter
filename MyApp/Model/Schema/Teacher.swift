//
//  Teacher.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class Teacher {
    var name: String = ""
    var image = UIImage()

    init(name: String = "", image: UIImage) {
        self.name = name
        self.image = image
    }
}
