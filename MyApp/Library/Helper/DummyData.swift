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
        let teacher1 = Teacher(name: "Dr.Tom", image: #imageLiteral(resourceName: "teacher1"))
        let teacher2 = Teacher(name: "Ms.Hoa", image: #imageLiteral(resourceName: "teahcer2"))
        let teacher3 = Teacher(name: "Ms.Mai", image: #imageLiteral(resourceName: "teacher3"))
        let teacher4 = Teacher(name: "Mr.Hung", image: #imageLiteral(resourceName: "teacher4"))
        return [teacher1, teacher2, teacher3, teacher4, teacher4, teacher4]
    }
}
