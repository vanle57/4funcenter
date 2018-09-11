//
//  Word.swift
//  MyApp
//
//  Created by PCM0019 on 8/3/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class Vocabulary: Mappable {

    // MARK: - struct example
    struct Example: Mappable {
        var exampleEng: String = ""
        var exampleVie: String = ""

        init?(map: Map) { }

        mutating func mapping(map: Map) {
            exampleEng <- map["example_eng"]
            exampleVie <- map["example_vie"]
        }
    }

    // MARK: - Properties
    var id: Int = 0
    var word: String = ""
    var spell: String = ""
    var type: String = ""
    var translate: String = ""
    var examples: [Example] = []
    var imagePath: String = ""

    init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        word <- map["word"]
        spell <- map["spell"]
        type <- map["type"]
        translate <- map["translate"]
        imagePath <- map["picture"]
        examples <- map["examples"]
    }
}
