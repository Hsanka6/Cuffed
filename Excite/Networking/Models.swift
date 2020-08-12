//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//


import Foundation
import UIKit

class User {
    init(userId, ) {
        self.userId = userId
    }
    let userId: String
    let profile: Profile
    let matches: [Moment]
    let liked: [String] //your likes
    let likedYou: String //array of userIds that liked you
    let seen: [String] //array of seen users
    let blocked: [String] //array of blocked users
    let isPremium: Bool
    let filter: Filter
}


enum GenderType: String {
    case MALE
    case FEMALE
    case OTHER
}

class tenQuestions: Game {
    override init() {
        super.init()
    }
   let question:[String]
   let currentQuestion: Int
}

class Game {
    init() {
        
    }
   let id: String
}

class Moment {
    init() {
        
    }
    let id: String
    let chatId: String
    let user1Id: String
    let user2Id: String
    let games: [String]
}

class Match: Moment {
    override init() {
        
    }
   let isMatch: Bool
}


class Profile {
    init() {
        // ...
    }
    let photos: [String]
    let socials: [SocialProfile]
    let freeResponse: [FreeResponse]
    let lat: Double
    let lon: Double
    let personalDetails: PersonalDetails
    let answers: [MultipleChoiceAnswer]
    let personalityAnswers:  [Personality]
}

class Personality: MultipleChoiceAnswer {
    override init() {
        super.init()
    }
    let topValue: String //extroverted
    let bottomValue: String //introverted
}

class Question {
    init(question: String, isHidden: String, isMandatory: String) {
        self.question = question
    }
    let question: String
    
    let isHidden: Bool
    let isMandatory: Bool
}

// “Your most embarrassing memory?” 
// Open Ended questions and answers
class FreeResponse: Question {
    override init() {
        super.init()
    }
    let answer: String
    let image: String
}

class MultipleChoiceAnswer: MultipleChoice {
    override init() {
        super.init()
    }
    let answer: String
}

//  Question with limited answers
class MultipleChoice: Question {
    override init() {
        super.init()
    }
    let id: String //maybe
    let answerChoices: [String]
}

class PersonalDetails {
    init() {
        // ...
    }
    let fullName: String
    let age: Int
    let height: String 
    let gender: GenderType
    let ethnicity: String
    let location: String
    let jobTitle: String
    let company: String
}


class SocialProfile {
    init() {
        
    }
    let platform: String
    let link: String
}

class Filter {
    init() {
        
    }
    let interest: [GenderType]
    let distance: Int
    let age: Int
    let moreFilters: [MultipleChoice]
}


