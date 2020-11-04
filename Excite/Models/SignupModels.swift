//
//  SignupModels.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 10/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation



// TODO:
// Replace the models inside of models.swift with the ones i have here

struct SignupModels {

    class Question: Codable {
        let id: String
        let question: String
        let isMandatory: Bool
        let isHidden: Bool
        let short: String
        var answerChoice: String?
        init(id: String, question: String, isMandatory: Bool, isHidden: Bool, short: String, answerChoice: String?) {
            self.id = id
            self.question = question
            self.isMandatory = isMandatory
            self.isHidden = isHidden
            self.short = short
            self.answerChoice = answerChoice
        }
    }
    
    class FreeResponse: Question {
        
        override init(id: String, question: String, isMandatory: Bool, isHidden: Bool, short: String, answerChoice: String?) {
            super.init(id: id, question: question, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: answerChoice)
        }
        
        private enum CodingKeys: CodingKey {
            case id
            case question
            case answerChoice
            case isMandatory
            case isHidden
            case short
        }
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(String.self, forKey: .id)
            let question = try container.decode(String.self, forKey: .question)
            let isMandatory = try container.decode(Bool.self, forKey: .isMandatory)
            let isHidden = try container.decode(Bool.self, forKey: .isHidden)
            let answerChoice = try container.decodeIfPresent(String.self, forKey: .answerChoice) ?? nil
//            if let answerChoice = try container.decodeIfPresent(String.self, forKey: .answerChoice) {
//                self.answerChoice = answerChoice
//            }
            let short = try container.decode(String.self, forKey: .short)
            super.init(id: id, question: question, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: answerChoice)
        }
        
        
        // use compactMap here
//        public func makeFromDict() -> [String: Any] {
//            return ["question": self.question,
//                    "answer": self.answer]
//        }
    }


    class MultipleChoice: Question {
        // this is the selection of answers
        let answers: [String]
        
        init(id: String, question: String, answers: [String], isMandatory: Bool, isHidden: Bool, short: String, answerChoice: String?) {
            self.answers = answers
            super.init(id: id, question: question, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: answerChoice)
        }
        private enum CodingKeys: CodingKey {
            case id
            case question
            case answers
            case answerChoice
            case isHidden
            case isMandatory
            case short
        }
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(String.self, forKey: .id)
            let question = try container.decode(String.self, forKey: .question)
            let answers = try container.decode(Array<String>.self.self, forKey: .answers)
            // if key doesn't exist,
            let answerChoice = try container.decodeIfPresent(String.self, forKey: .answerChoice) ?? nil
            
            let isMandatory = try container.decode(Bool.self, forKey: .isMandatory)
            let isHidden = try container.decode(Bool.self, forKey: .isHidden)
            let short = try container.decode(String.self, forKey: .short)
            self.answers = answers
            super.init(id: id, question: question, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: answerChoice)
        }
//        func setAnswer(answerChoice: String) {
//            self.answerChoice = answerChoice
//        }
        
        // use compactMap here
//        public func makeFromDict() -> [String: Any] {
//           return ["question": self.question,
//                   "answerChoices": self.answerChoices,
//                   "short": self.short]
//        }
    }
}

