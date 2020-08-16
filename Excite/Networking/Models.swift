//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//


//import Foundation
//import UIKit
//
//struct User: Codable {
//    let userId: String
//    let profile: Profile
//    let matches: [Date]
//    let liked: [String] //your likes
//    let likedYou: String //array of userIds that liked you
//    let seen: [String] //array of seen users
//    let blocked: [String] //array of blocked users
//    let isPremium: Bool
//}
//
//
//enum GenderType: String, Codable {
//    case MALE
//    case FEMALE
//    case OTHER
//}
//
//struct tenQuestions: Game {
//   let question:[String]
//}
//
//struct Game: Codable {
//   let id: String
//}
//
//
//
//struct Date: Codable {
//    let id: String
//    let chatId: String
//    let user1Id: String
//    let user2Id: String
//    let games: [String]
//}
//
//struct Match: Date {
//   let isMatch: bool
//}
//
//
//struct Profile: Codable {
//    let photos: [String]
//    let socials: [SocialProfile]
//    let freeResponse: [FreeResponse]
//    let lat: Double
//    let lon: Double
//    let personalDetails: PersonalDetails
//    let answers: [MultipleChoiceAnswer]
//    let personalityAnswers:  [Personality]
//}
//
//Struct Personality: MultipleChoiceAnswer {
//    let topValue: String //extroverted
//    let bottomValue: String //introverted
//}
//
//// “Your most embarrassing memory?”
//// Open Ended questions and answers
//struct FreeResponse: Codable {
//    let question: String
//    let answer: String
//    let image: String
//}
//
//struct MultipleChoiceAnswer: MultipleChoice, Codable {
//    let answer: String
//}
//
////  Question with limited answers
//struct MultipleChoice: Codable {
//    let id: String //maybe
//    let question: String
//    let answerChoices: [String]
//}
//
//
//struct PersonalDetails: Codable {
//    let fullName: String
//    let age: Int
//    let height: String
//    let gender: GenderType
//    let ethnicity: String
//    let location: String
//    let jobTitle: String
//    let company: String
//}
//
//
//struct SocialProfile: Codable {
//    let platform: String
//    let link: String
//}
//
//struct Filter: Codable {
//    let interest: [GenderType]
//    let distance: Int
//    let time: Availability
//    let age: Int
//    Let moreFilters: [MultipleChoice]
//}


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
    
    enum Key: CodingKey {
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
