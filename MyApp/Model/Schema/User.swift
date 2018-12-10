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

@objcMembers final class User: Object, Mappable {

  // MARK: - Properties
  dynamic var id = 0
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var fullName: String {
    return "\(firstName) \(lastName)"
  }
  dynamic var gender = false
  dynamic var birthDay = ""
  dynamic var email = ""
  dynamic var address = ""
  dynamic var phoneNumber = ""
  dynamic var idCardNumber = ""
  dynamic var avatarUrl = ""

  // MARK: - init
  required convenience init?(map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    id <- map["Id"]
    firstName <- map["Ho"]
    lastName <- map["Ten"]
    gender <- map["GioiTinh"]
    birthDay <- map["NgaySinh"]
    email <- map["Email"]
    address <- map["DiaChi"]
    phoneNumber <- map["SoDienThoai"]
    idCardNumber <- map["CMND"]
    avatarUrl <- map["Avatar"]
  }

  static func saveUserToRealm(user: User, completion: Completion<User>) {
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(user)
      }
      completion(.success(user))
    } catch {
      completion(.failure(App.Error.realm))
    }
  }

  static func updateUserInRealm(user: User, completion: Completion<User>) {

    do {
      let realm = try Realm()
      let users = realm.objects(User.self)
      if let userRealm = users.first {
        try realm.write {
          userRealm.firstName = user.firstName
          userRealm.lastName = user.lastName
          userRealm.gender = user.gender
          userRealm.birthDay = user.birthDay
          userRealm.email = user.email
          userRealm.address = user.address
          userRealm.phoneNumber = user.phoneNumber
          userRealm.idCardNumber = user.idCardNumber
        }
        completion(.success(user))
      }
    } catch {
      completion(.failure(App.Error.realm))
    }
  }
}
