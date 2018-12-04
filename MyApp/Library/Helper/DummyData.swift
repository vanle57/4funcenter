//
//  DummyData.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DummyData {

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
