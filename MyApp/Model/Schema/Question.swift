//
//  Question.swift
//  MyApp
//
//  Created by MBA0002 on 8/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class Question {

    // MARK: - enum
    enum QuestionType: Int {
        case sound = 1
        case word
        case meaning
    }

    // MARK: - Properties
    var type: QuestionType = .word
    var vocabulary: Vocabulary
    var question: NSMutableAttributedString = NSMutableAttributedString(string: "")
    var choices: [String] = []

    // MARK: - init
    init(type: QuestionType, vocalbulary: Vocabulary, choices: [String]) {
        self.type = type
        self.vocabulary = vocalbulary
        self.choices = choices
        createQuestion()
    }

    private func createQuestion() {
        let attributeKeyWord: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.red,
            NSAttributedStringKey.font: App.Font.questionTextLabel]
        let attribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: App.Color.questionColor,
            NSAttributedStringKey.font: App.Font.questionTextLabel]

        switch type {
        case .word:
            var text = "Từ "
            var attributeText = NSAttributedString(string: text, attributes: attribute)
            question.append(attributeText)

            let atrributeWord = NSAttributedString(string: vocabulary.word, attributes: attributeKeyWord)
            question.append(atrributeWord)
            text = " có nghĩa là gì?"
            attributeText = NSAttributedString(string: text, attributes: attribute)
            question.append(attributeText)
        case .meaning:
            var text = "Nghĩa "
            var attributeText = NSAttributedString(string: text, attributes: attribute)
            question.append(attributeText)

            let atrributeWord = NSAttributedString(string: vocabulary.translate, attributes: attributeKeyWord)
            question.append(atrributeWord)

            text = " là của từ nào dưới đây?"
            attributeText = NSAttributedString(string: text, attributes: attribute)
            question.append(attributeText)
        case .sound:
            let text = "Nghe từ dưới đây và chọn đáp án tương ứng?"
            let attributeText = NSAttributedString(string: text, attributes: attribute)
            question.append(attributeText)
        }
    }
    // MARK: - Public function
    func getCorrectAnswer() -> String {
        switch type {
        case .word:
            return vocabulary.translate
        case .meaning:
            return vocabulary.word
        case .sound:
            return vocabulary.word
        }
    }
}
