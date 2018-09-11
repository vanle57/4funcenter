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

@objcMembers class User: Object, Mappable {
    // MARK: - enum
    enum Gender {
        case male
        case female
        case other

        var name: String {
            switch self {
            case .male:
                return "Nam"
            case .female:
                return "Nữ"
            case .other:
                return "Khác"
            }
        }
    }

    // MARK: - Properties
    dynamic var id = 0
    dynamic var username = ""
    dynamic var password = ""
    dynamic var accesToken = ""
    dynamic var avatarUrl = ""
    dynamic var birthday: Date = Date()
    dynamic var gender: User.Gender = .other
    dynamic var email = ""
    dynamic var idLevel = 1

    // MARK: - init
    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        username <- map["name"]
        accesToken <- map["token"]
        email <- map["email"]
        avatarUrl <- map["avatarUrl"]
        var level = Level()
        level <- map["level"]
        idLevel = level.id
    }

    required convenience init?(map: Map) {
        self.init()
    }

    static func saveUserToRealm(user: User, completion: Completion<User>) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
            completion(.success(user))
        } catch {
            completion(.failure(App.Error.realmError))
        }
    }
}
