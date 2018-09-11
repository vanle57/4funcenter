//
//  Rank.swift
//  MyApp
//
//  Created by Kieu Nhi on 8/15/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Rank: Mappable {

    // MARK: - Properties
    var userName = ""
    var avatarUrl = ""
    var score = 0

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        userName <- map["name"]
        avatarUrl <- map ["avatarUrl"]
        score <- map["total_score"]
    }
}
