//
//  Course.swift
//  MyApp
//
//  Created by MBA0002 on 9/19/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

@objcMembers final class Course: Mappable {

  // MARK: - Properties
  dynamic var id = 0
  dynamic var name = ""
  dynamic var numberOfView = 0
  dynamic var numberOfComment = 0
  dynamic var imageUrl = ""
  dynamic var detail = ""
  dynamic var openingDate = ""
  dynamic var fee: Double = 0.0

  // MARK: init
  init() { }

  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    id <- map["BeautyId"]
    name <- map["TenKhoaHoc"]
    numberOfView <- map["SoLuongView"]
    numberOfComment <- map["SoLuongComment"]
    imageUrl <- map["AnhMinhHoa"]
    detail <- map["TomTat"]
    openingDate <- map["NgayKhaiGiang"]
  }
}
