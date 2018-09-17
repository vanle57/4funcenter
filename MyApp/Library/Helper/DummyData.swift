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
        let entry = Entry(imageUrl: "", title: "Mindfulness", description: "Mindfulness’ is a word we hear a lot these days, but what exactly does it mean? Find out what it is, what the benefits of mindfulness are and how you can start to practise it.", authorName: "Kirk", content: "", dateCreated: Date())
        return [entry, entry, entry, entry]
    }
}
