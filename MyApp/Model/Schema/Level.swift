//
//  Level.swift
//  MyApp
//
//  Created by MBA0002 on 8/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper
import RealmSwift

@objcMembers final class Level: Object, Mappable {
    // MARK: - Properties
    dynamic var id = 1
    dynamic var name = ""

    // MARK: - init
    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - init
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }

    required convenience init?(map: Map) {
        self.init()
    }

    static func saveLevelsToRealm(levels: [Level], completion: Completion<[Level]>) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(levels)
            }
            completion(.success(levels))
        } catch {
            completion(.failure(App.Error.realmError))
        }
    }
}
