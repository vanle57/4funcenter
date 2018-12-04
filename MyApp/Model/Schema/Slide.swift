//
//  Slide.swift
//  MyApp
//
//  Created by MBA0002 on 9/25/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

@objcMembers final class Slide: Mappable {

  dynamic var imageUrl = ""
  dynamic var title = ""
  dynamic var detail = ""

  /// this is temporary data to create dummy data. Delete it when you have api
  var image = UIImage()
  init() { }

  init(image: UIImage, title: String) {
    self.image = image
    self.title = title
  }

  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    imageUrl <- map["LinkAnh"]
    title <- map["TieuDe"]
    detail <- map["ChiTiet"]
  }
}
