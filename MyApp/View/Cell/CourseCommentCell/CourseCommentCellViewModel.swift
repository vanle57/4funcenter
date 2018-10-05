//
//  CourseCommentCellViewModel.swift
//  MyApp
//
//  Created by MBA0203 on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseCommentCellViewModel {

    // MARK: - Propeties
    var avatar: UIImage = UIImage()
    var username = "demi lovato"
    var content = ""
    var dateCreate = ""
    var ratingPoint = 0

    var ratingString: String {
        switch ratingPoint {
        case 1:
            return "★"
        case 2:
            return "★★"
        case 3:
            return "★★★"
        case 4:
            return "★★★★"
        case 5:
            return "★★★★★"
        default:
            return ""
        }
    }

    // MARK: - init
    init(comment: Comment) {
//        self.avatar = comment.user.
        content = comment.content
        dateCreate = comment.dateCreate.string()
        ratingPoint = comment.ratingPoint
    }
}
