//
//  User.swift
//  MyApp
//
//  Created by MBA0002 on 8/4/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift
import ObjectMapper
import Realm

final class User: Mappable {

  // MARK: - Properties
  var id = 0
  var avatarUrl = ""
  var userName = ""
  var password = ""

  // MARK: - init
  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    id <- map["Id"]
    avatarUrl <- map["Avatar"]
    userName <- map["userName"]
  }
}
