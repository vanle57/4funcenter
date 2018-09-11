//
//  Comment.swift
//  MyApp
//
//  Created by Kieu Nhi on 8/3/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

final class Comment: Mappable {
    // MARK: - Properties
    var id = 0
    var content = ""
    var user = User()
    // MARK: - Init
    init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        user <- map["user"]
    }
}
