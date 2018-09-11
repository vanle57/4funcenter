//
//  Score.swift
//  MyApp
//
//  Created by PCM0019 on 8/22/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper
import RealmSwift

@objcMembers final class Score: Object, Mappable {
    // MARK: - Properties
    dynamic var id = 1
    dynamic var name = ""
    dynamic var score = 0

    // MARK: - init
    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: - init
    func mapping(map: Map) {
        id <- map["topic_id"]
        name <- map["topic_name"]
        score <- map["score"]
    }

    required convenience init?(map: Map) {
        self.init()
    }

    static func saveScoresToRealm(scores: [Score], completion: Completion<[Score]>) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(scores)
            }
            completion(.success(scores))
        } catch {
            completion(.failure(App.Error.realmError))
        }
    }

    static func updateScoresInRealm(scores: Score) throws {
        let realm = try Realm()
        let score = realm.objects(Score.self).filter("id = %@", scores.id)
        try realm.write {
            score.setValue(scores.score, forKey: "score")
        }
    }
}
