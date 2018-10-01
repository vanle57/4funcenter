//
//  CourseDetailCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CourseDetailCellViewModel {

    // MARK: - Properties
    var title = ""
    var content = ""

    // MARK: - init
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
