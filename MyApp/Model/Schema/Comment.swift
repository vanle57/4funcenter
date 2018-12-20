//
//  Comment.swift
//  MyApp
//
//  Created by MBA0203 on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

final class Comment: Mappable {

  var imageUrl = ""
  var username = ""
  var content = ""
  var ratingPoint = 0
  var dateCreate = ""

  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    imageUrl <- map["Avatar"]
    username <- map["HoTen"]
    content <- map["NoiDung"]
    dateCreate <- map["ThoiGianCmt"]
  }
}
