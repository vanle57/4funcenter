//
//  Slide.swift
//  MyApp
//
//  Created by MBA0002 on 9/25/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class Slide {

    var id = 0
    var imageUrl = ""
    var title = ""
    var detail = ""


    /// this is temporary data to create dummy data. Delete it when you have api
    var image = UIImage()
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}
