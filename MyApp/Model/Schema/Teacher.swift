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

    // MARK: - Properties
    var id = 0
    var name = ""
    var imageUrl = ""
    var positionName = ""

    /// temporary data
    var image = UIImage()

    // MARK: - init
    init(name: String, image: UIImage, positionName: String) {
        self.name = name
        self.image = image
        self.positionName = positionName
    }
}
