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

    static func fetchCourses() -> [Course] {
        let course1 = Course(name: "Basic Communication", numberOfView: 50, numberOfComment: 100, description: "Help anyone who don't known anything about English", detail: "")
        let course2 = Course(name: "English online", numberOfView: 50, numberOfComment: 100, description: "Learn English online using our high-quality resources to quickly improve your English. Our website for adult learners, is brought to you by the British Council, the world's English teaching experts. ", detail: "")
        return [course1, course1, course1, course2]
    }

    static func fetchTeachers() -> [Teacher] {
        let teacher1 = Teacher(name: "Hoa", image: #imageLiteral(resourceName: "image7"))
        let teacher2 = Teacher(name: "Lan", image: #imageLiteral(resourceName: "image2"))
        let teacher3 = Teacher(name: "Mai", image: #imageLiteral(resourceName: "ic_high_beginner"))
        return [teacher1, teacher2, teacher3, teacher3, teacher3]
    }
}
