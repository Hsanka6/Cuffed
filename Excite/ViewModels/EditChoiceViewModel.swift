//
//  EditChoiceViewModel.swift
//  Excite
//
//  Created by Haasith Sanka on 10/17/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation

class EditChoiceViewModel {
    var choices: [String]?
    var selectedAnswer: String?
    var questions: [MultipleChoiceAnswer]?
    var index: Int?
    var identifier: String?
    var personal: PersonalDetails?


    init(choices: [String]? = nil, index: Int, questions: [MultipleChoiceAnswer]? = nil, identifier: String? = nil, selectedAnswer: String? = nil, personal: PersonalDetails? = nil) {
        self.choices = choices
        self.index = index
        self.questions = questions
        self.identifier = identifier
        self.selectedAnswer = selectedAnswer
        self.personal = personal
    }
}
