//
//  DummyData.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DummyData {
    static func fetchEntries() -> [Entry] {
        let entry1 = Entry(imageUrl: "", title: "Mindfulness", description: "Mindfulness’ is a word we hear a lot these days, but what exactly does it mean? Find out what it is, what the benefits of mindfulness are and how you can start to practise it.", authorName: "Kirk Clean", content: "", dateCreated: Date())

        let entry2 = Entry(imageUrl: "", title: "Mindfulness", description: "Mindfulness’ is a word we hear a lot these days, but what exactly does it mean?", authorName: "Kirk Clean", content: "", dateCreated: Date())
        return [entry1, entry1, entry1, entry2]
    }
}
