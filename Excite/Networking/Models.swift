//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    let userId: String
    let profile: Profile
    let matches: [DateInstance]
//    let liked: [String] //your likes
//    let likedYou: String //array of userIds that liked you
//    let seen: [String] //array of seen users
//    let blocked: [String] //array of blocked users
    let isPremium: Bool
}


enum GenderType: String, Codable {
    case MALE
    case FEMALE
    case OTHER
}

//class tenQuestions: Game {
//    let question:[String] = []
//}

class Game: Codable {
   let id: String
}



class DateInstance: Codable {
    let id: String
    let chatId: String
    let user1Id: String
    let user2Id: String
    let games: [String]
    
    init(id: String, chatId: String, user1Id: String, user2Id: String, games: [String]) {
        self.id = id
        self.chatId = chatId
        self.user1Id = user1Id
        self.user2Id = user2Id
        self.games = games
    }
}

class Match: DateInstance {
   let isMatch: Bool
    
    init(isMatch: Bool, id: String, chatId: String, user1Id: String, user2Id: String, games: [String]) {
           self.isMatch = isMatch
       super.init(id: id, chatId: chatId, user1Id: user1Id, user2Id: user2Id, games: games)
   }
       
       private enum Key: CodingKey {
           case isMatch
           case id
           case chatId
           case user1Id
           case user2Id
           case games
       }
       
       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: Key.self)
           let isMatch = try container.decode(Bool.self, forKey: .isMatch)
           let id = try container.decode(String.self, forKey: .id)
           let chatId = try container.decode(String.self, forKey: .chatId)
            let user1Id = try container.decode(String.self, forKey: .user1Id)
            let user2Id = try container.decode(String.self, forKey: .user2Id)
            let games = try container.decode(Array<String>.self, forKey: .games)
            self.isMatch = isMatch
           super.init(id: id, chatId: chatId, user1Id: user1Id, user2Id: user2Id, games: games)
       }
    
}


class Profile: Codable {
    let photos: [String]
    let socials: [SocialProfile]
    let freeResponse: [FreeResponse]
    let lat: Double
    let lon: Double
    // your metadata
    let personalDetails: PersonalDetails
    // the answers to the questions that you display on your profile
    let answers: [MultipleChoiceAnswer]
    // traits that you describe yourself as upon sign-up
    let personalityAnswers:  [Personality]
    
    private enum CodingKeys: String, CodingKey {
        case photos
        case socials
        case freeResponse
        case lat
        case lon
        case personalDetails
        case answers
        case personalityAnswers
    }
    
    init(photos: [String], socials: [SocialProfile], freeResponse: [FreeResponse], lat: Double, lon: Double, personalDetails: PersonalDetails, answers: [MultipleChoiceAnswer], personalityAnswers: [Personality]) {
        self.photos = photos
        self.socials = socials
        self.freeResponse = freeResponse
        self.lat = lat
        self.lon = lon
        self.personalDetails = personalDetails
        self.answers = answers
        self.personalityAnswers = personalityAnswers
    }

    required init(from decoder: Decoder) throws {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try container.decode(Array<String>.self, forKey: .photos)
        let socials = try container.decode(Array<SocialProfile>.self, forKey: .socials )
        let freeResponse = try container.decode(Array<FreeResponse>.self, forKey: .freeResponse )
        let lat = try container.decode(Double.self, forKey: .lat)
        let lon = try container.decode(Double.self, forKey: .lon )
        let personalDetails = try container.decode(PersonalDetails.self, forKey: .personalDetails )
        let answers = try container.decode(Array<MultipleChoiceAnswer>.self, forKey: .answers )
        let personalityAnswers = try container.decode(Array<Personality>.self, forKey: .personalityAnswers )
        
        self.photos = photos
        self.socials = socials
        self.freeResponse = freeResponse
        self.lat = lat
        self.lon = lon
        self.personalDetails = personalDetails
        self.answers = answers
        self.personalityAnswers = personalityAnswers
              
        //super.init(num: num, food: food)
        //fatalError("init(from:) has not been implemented")
    }
    
    
}

class Personality: MultipleChoiceAnswer {
    let topValue: String //extroverted
    let bottomValue: String //introverted
    
    private enum Key: CodingKey {
        case question
        case answerChoices
        case answer
        case topValue
        case bottomValue
     }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let question = try container.decode(String.self, forKey: .question)
        let answerChoices = try container.decode(Array<String>.self, forKey: .answerChoices)
        let answer = try container.decode(String.self, forKey: .answer)
        let topValue = try container.decode(String.self, forKey: .topValue)
        let bottomValue = try container.decode(String.self, forKey: .bottomValue)
        self.topValue = topValue
        self.bottomValue = bottomValue
        super.init(answer: answer, question: question, answerChoices: answerChoices)
    }
}

// “Your most embarrassing memory?”
// Open Ended questions and answers
struct FreeResponse: Codable {
    let question: String
    let answer: String
    let image: String
}

class MultipleChoiceAnswer: MultipleChoice {
    let answer: String
    
    private enum Key: CodingKey {
       case question
       case answerChoices
       case answer
    }
    init(answer: String, question: String, answerChoices:[String]) {
        self.answer = answer
        super.init(question: question, answerChoices: answerChoices)
        
    }
       
    required init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: Key.self)
       let question = try container.decode(String.self, forKey: .question)
       let answerChoices = try container.decode(Array<String>.self, forKey: .answerChoices)
       let answer = try container.decode(String.self, forKey: .answer)
       self.answer = answer
     super.init(question: question, answerChoices: answerChoices)
   }
}

//  Question with limited answers
class MultipleChoice: Codable {
    //let id: String //maybe
    let question: String
    let answerChoices: [String]
    
    init(question:String, answerChoices: [String]) {
        self.question = question
        self.answerChoices = answerChoices
    }
}


struct PersonalDetails: Codable {
    let fullName: String
    let age: Int
    let height: String
    let gender: GenderType
    let ethnicity: String
    let location: String
    let jobTitle: String
    let company: String
}


class SocialProfile: Codable {
    let platform: String
    let link: String
    
    init(platform: String, link: String) {
        self.platform = platform
        self.link = link
    }
}

class Filter: Codable {
    let interest: [GenderType]
    let distance: Int
    let age: Int
    let moreFilters: [MultipleChoice]
    
    
}


//struct


class Edible: Codable {
    var name: String
    var size: Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

class Food: Edible {
    var taste: String
    
    init(name: String, size: Int, taste: String) {
        self.taste = taste
        super.init(name: name, size: size)
    }
    
    private enum Key: CodingKey {
        case name
        case size
        case taste
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let name = try container.decode(String.self, forKey: .name)
        let size = try container.decode(Int.self, forKey: .size)
        let taste = try container.decode(String.self, forKey: .taste)
        self.taste = taste
        super.init(name: name, size: size)
    }
}

class Test: Codable {
    let num: String
    let food: Food
    init(num: String, food: Food) {
        self.num = num
        self.food = food
    }
    private enum CodingKeys: String, CodingKey {
        case num
        case food
    }

    required init(from decoder: Decoder) throws {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let num = try container.decode(String.self, forKey: .num)
        let food = try container.decode(Food.self, forKey: .food )
        self.food = food
        self.num = num
        //super.init(num: num, food: food)
        //fatalError("init(from:) has not been implemented")
    }
      
}
