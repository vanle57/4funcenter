//
//  Blog.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

@objcMembers final class Entry: Mappable {

  // MARK: - Properties
  dynamic var id = ""
  dynamic var imageUrl = ""
  dynamic var title = ""
  dynamic var description = ""
  dynamic var content = ""
  dynamic var numberOfViews = 0
  dynamic var numberOfComments = 0
  dynamic var dateCreated: Date = Date()

  // MARK: - init
  init() { }

  init(imageUrl: String, title: String, description: String, content: String, dateCreated: Date) {
    self.imageUrl = imageUrl
    self.title = title
    self.description = description
    self.content = content
    self.dateCreated = dateCreated
  }

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
