//
//  DummyData.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DummyData {
  
    static func fetchCourses() -> [Course] {
        let course1 = Course(name: "Basic Communication", numberOfView: 50, numberOfComment: 100, description: "Help anyone who don't known anything about English", detail: "This is a course to help you write effective business emails in English. This course is unique because each module will provide tips on writing more professional emails as well as lessons to improve your overall English writing skills. Therefore, you will improve your grammar and vocabulary skills for email writing and also improve your cross cultural knowledge to make you more powerful and successful in your business communication. You will look at different email formats to analyze tone, formality levels, and various organizational styles. You will be able to improve your emails of introduction, announcements, requests and emails that apologize or revise a request. In this course you will write and revise 4–5 emails, complete several comprehension quizzes and review the emails of other participants.", time: "3 months", fee: 5000000)
        let course2 = Course(name: "English online", numberOfView: 50, numberOfComment: 100, description: "Learn English online using our high-quality resources to quickly improve your English. Our website for adult learners, is brought to you by the British Council, the world's English teaching experts. ", detail: "Do you want to speak better English? This course will help you reach that goal. Speak English Professionally: In person, Online and On the Phone will boost your English speaking skills. In this 5 week course, you will learn how to identify and make a strong personal introduction. You will develop and demonstrate the speaking skills for group discussions: how to agree or disagree, how to clarify, restate and summarize. You will review and practice how to give information and respond to requests on the phone. You will study and role play effective interviewing. You will  prepare and give a sales “pitch”, introducing a product or service. Throughout the course, you will change how you speak English and you will become more fluent and accurate when you speak. You will demonstrate  culturally appropriate body language and tone. As you work through the course, you will complete self- and peer-evaluations. Through a combination of lectures, comprehension and vocabulary quizzes, practice and performance, you’ll gain the skills and confidence to communicate well  in English, anywhere in the world.", time: "2 months", fee: 2000000)
        return [course1, course1, course1, course2]
    }

    static func fetchTeachers() -> [Teacher] {
        let teacher1 = Teacher(name: "Dr.Tom", image: #imageLiteral(resourceName: "teacher1"), positionName: "TOEIC")
        let teacher2 = Teacher(name: "Ms.Hoa", image: #imageLiteral(resourceName: "teahcer2"), positionName: "IELTS")
        let teacher3 = Teacher(name: "Ms.Mai", image: #imageLiteral(resourceName: "teacher3"), positionName: "IELTS")
        let teacher4 = Teacher(name: "Mr.Hung", image: #imageLiteral(resourceName: "teacher4"), positionName: "Communication")
        return [teacher1, teacher2, teacher3, teacher4, teacher4, teacher4]
    }

    static func fetchSlide() -> [Slide] {
        let slide1 = Slide(image: #imageLiteral(resourceName: "slide1"), title: "Education Needs Complete Solutions")
        let slide2 = Slide(image: #imageLiteral(resourceName: "slide2"), title: "Education Needs Complete Solutions")
        let slide3 = Slide(image: #imageLiteral(resourceName: "slide3"), title: "Education Needs Complete Solutions")
        return [slide1, slide2, slide3]
    }

    static func fetchComments() -> [Comment] {
        let comment1 = Comment(content: "Great course", ratingPoint: 5, dateCreate: Date())
        let comment2 = Comment(content: "Through a combination of lectures, comprehension and vocabulary quizzes, practice and performance, you’ll gain the skills and confidence to communicate well  in English, anywhere in the world.", ratingPoint: 3, dateCreate: Date())
        return [comment1, comment2, comment2, comment1]
    }
}
