//
//  Course.swift
//  MyApp
//
//  Created by MBA0002 on 9/19/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Course: Mappable {

  // MARK: - Properties
  var id = 0
  var beautyId = ""
  var name = ""
  var numberOfView = 0
  var numberOfComment = 0
  var imageUrl = ""
  var detail = ""
  var openingDate = ""
  var fee: Int = 100_000

  // MARK: init
  init() { }

  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    beautyId <- map["BeautyId"]
    let range = beautyId.index(beautyId.startIndex, offsetBy: 9)..<beautyId.endIndex
    let idStr = beautyId[range]
    if let id = Int("\(idStr)") {
      self.id = id
    }
    name <- map["TenKhoaHoc"]
    numberOfView <- map["SoLuongView"]
    numberOfComment <- map["SoLuongComment"]
    imageUrl <- map["AnhMinhHoa"]
    detail <- map["TomTat"]
    openingDate <- map["NgayKhaiGiang"]
  }
}
