//
//  Blog.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

final class Entry: Mappable {

  // MARK: - Properties
  var id = ""
  var imageUrl = ""
  var title = ""
  var description = ""
  var content = ""
  var numberOfViews = 0
  var numberOfComments = 0
  var dateCreated: Date = Date()

  // MARK: - init
  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    id <- map["Id"]
    imageUrl <- map["AnhMinhHoa"]
    title <- map["TieuDe"]
    description <- map["TomTat"]
    numberOfViews <- map["SoLuongView"]
    numberOfComments <- map["SoLuongComment"]
    dateCreated <- map["NgayDang"]
  }
}
