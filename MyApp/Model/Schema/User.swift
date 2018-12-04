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

    // MARK: - Properties
    dynamic var userName = ""
    dynamic var password = ""

    // MARK: - init
    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        userName <- map["userName"]
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
            completion(.failure(App.Error.realm))
        }
    }
}
