//
//  Teacher.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

@objcMembers final class Teacher: Mappable {

  // MARK: - Properties
  dynamic var idUser = 0
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var imageUrl = ""
  var fullName: String {
    return "\(firstName) \(lastName)"
  }

  /// temporary data
  var image = UIImage()

  // MARK: - init
  init() { }

  init(name: String, image: UIImage) {
    self.firstName = name
    self.image = image
  }

  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    idUser <- map["IdUser"]
    imageUrl <- map["Avatar"]
    firstName <- map["Ho"]
    lastName <- map["Ten"]
  }
}
