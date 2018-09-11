//
//  Topic.swift
//  MyApp
//
//  Created by MBA0002 on 8/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class Topic: Object, Mappable {

    // MARK: - Properties
    dynamic var id = 0
    dynamic var levelName = ""
    dynamic var name = ""
    dynamic var statusRaw = ""
    dynamic var numberOfComment = 0
    dynamic var numberOfFavorite = 0
    var author: User?
    dynamic var isFavorite = false
    var isPrivate: Bool {
        return statusRaw != "0"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        statusRaw <- map["status"]
        levelName <- map["level_name"]
        author <- map["from"]
        numberOfFavorite <- map["total_like"]
        numberOfComment <- map["total_comment"]
        isFavorite <- map["is_like"]
    }

    func clone() -> Topic {
        let topic = Topic()
        topic.id = id
        topic.levelName = levelName
        topic.name = name
        topic.statusRaw = statusRaw
        topic.numberOfComment = numberOfComment
        topic.numberOfFavorite = numberOfFavorite
        topic.author = author
        return topic
    }
}
