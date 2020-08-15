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

enum Keys: String, CodingKey {
    case name
    case size
}
protocol Edible: Codable {
    var name: String { get }
    var size: Int { get }
//    init(name: String, size: Int) {
//        self.name = name
//        self.size = size
//    }
    
//
//    required init(from decoder: Decoder) throws {
//        print("INSIDE BASE INIT")
//        let container = try decoder.container(keyedBy: Keys.self)
//        name = try container.decode(String.self, forKey: .name)
//        size = try container.decode(Int.self, forKey: .size)
//        print("ABOUT TO LEAVE BASE INIT")
//    }
}

// https://stackoverflow.com/questions/44553934/using-decodable-in-swift-4-with-inheritance
class Food: Edible {

    var taste: String

    init(name: String, size: Int, taste: String) {
        self.taste = taste
        super.init(name: name, size: size)
    }
    private enum CodingKeys: String, CodingKey { case taste
        case name
        case size
    }
    
    //https://stackoverflow.com/questions/46595246/how-can-i-implement-polymorphic-decoding-of-json-data-in-swift-4

    required init(from decoder: Decoder) throws {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        taste = try container.decode(String.self, forKey: .taste)
        
        // otherVar = ...

        // Get superDecoder for superclass and call super.init(from:) with it
        let superDecoder = try container.superDecoder()
        print("BEFORE SUPER.INIT")
        try super.init(from: superDecoder)
        print("AFTER SUPER.INIT")
        fatalError("init(from:) has not been implemented")
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
        num = try container.decode(String.self, forKey: .num)
        food = try container.decode(Food.self, forKey: .food )
        // otherVar = ...

        // Get superDecoder for superclass and call super.init(from:) with it
//        let superDecoder = try container.superDecoder()
//        try super.init(from: superDecoder)
        fatalError("init(from:) has not been implemented")
    }
      
}
