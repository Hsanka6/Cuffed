//
//  SignupModels.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 10/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation

struct SignupModels {

    class Question: Codable {
        let question: String
        let isMandatory: Bool
        let isHidden: Bool
        let short: String
        
        init(question: String, isMandatory: Bool, isHidden: Bool, short: String) {
            self.question = question
            self.isMandatory = isMandatory
            self.isHidden = isHidden
            self.short = short
        }
    }
    class FreeResponse: Question {
        var answer: String?
        
        init(question: String, answer: String?, isMandatory: Bool, isHidden: Bool, short: String) {
            super.init(question: question, isMandatory: isMandatory, isHidden: isHidden, short: short)
        }
        
        private enum CodingKeys: CodingKey {
            case question
            case answer
            case isMandatory
            case isHidden
            case short
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let question = try container.decode(String.self, forKey: .question)
            let isMandatory = try container.decode(Bool.self, forKey: .isMandatory)
            let isHidden = try container.decode(Bool.self, forKey: .isHidden)
            let short = try container.decode(String.self, forKey: .short)
            super.init(question: question, isMandatory: isMandatory, isHidden: isHidden, short: short)
        }
        
        func setAnswer(answerChoice answer: String) {
            self.answer = answer
        }
        // use compactMap here
//        public func makeFromDict() -> [String: Any] {
//            return ["question": self.question,
//                    "answer": self.answer]
//        }
    }


    class MultipleChoice: Question {
        //let id: String //maybe
        let answer: [String]
        var answerChoice: String?
        
        init(question: String, answer: [String], isMandatory: Bool, isHidden: Bool, short: String) {
            self.answer = answer
            
            super.init(question: question, isMandatory: isMandatory, isHidden: isHidden, short: short)
        }
        private enum CodingKeys: CodingKey {
            case question
            case answer
            case answerChoice
            case isHidden
            case isMandatory
            case short
        }
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let question = try container.decode(String.self, forKey: .question)
            let answer = try container.decode(Array<String>.self.self, forKey: .answer)
            // if key doesn't exist,
            if let answerChoice = try container.decodeIfPresent(String.self, forKey: .answerChoice) {
                self.answerChoice = answerChoice
            }
            let isMandatory = try container.decode(Bool.self, forKey: .isMandatory)
            let isHidden = try container.decode(Bool.self, forKey: .isHidden)
            let short = try container.decode(String.self, forKey: .short)
            self.answer = answer
            super.init(question: question, isMandatory: isMandatory, isHidden: isHidden, short: short)
        }
        
        func setAnswer(answerChoice: String) {
            self.answerChoice = answerChoice
        }
        
        // use compactMap here
//        public func makeFromDict() -> [String: Any] {
//           return ["question": self.question,
//                   "answerChoices": self.answerChoices,
//                   "short": self.short]
//        }
    }
}
