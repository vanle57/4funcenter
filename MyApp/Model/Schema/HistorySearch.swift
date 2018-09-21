//
//  HistorySearch.swift
//  MyApp
//
//  Created by MBA0002 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift

@objcMembers class HistorySearch: Object {

    dynamic var id = ""
    dynamic var content = ""

    convenience init(content: String) {
        self.init()
        self.content = content
        self.id = content
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    static func saveHistoryToRealm(history: [HistorySearch], completion: Completion<Bool>) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(history)
            }
            completion(.success(true))
        } catch {
            completion(.failure(App.Error.realmError))
        }
    }
}
