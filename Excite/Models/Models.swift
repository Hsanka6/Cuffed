//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

import FBSDKLoginKit
import FirebaseAuth

class User: Codable {
    let userId: String
    let email: String
    let name: String
    var profile: Profile?
    var matches: [DateInstance]?
//    let liked: [String] //your likes
//    let likedYou: String //array of userIds that liked you
//    let seen: [String] //array of seen users
//    let blocked: [String] //array of blocked users
    var isPremium: Bool?
    
    init(firebaseUser: Firebase.User) {
        self.name = firebaseUser.displayName ?? ""
        self.userId = firebaseUser.uid
        self.email = firebaseUser.email ?? ""
        // fill out the profile as well
        self.profile = nil
        self.matches = nil
        self.isPremium = false
    }
    
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
    var photos: [String]
    let socials: [SocialProfile]
    var freeResponse: [FreeResponse]
    let lat: Double
    let lon: Double
    // your metadata
    var personalDetails: PersonalDetails
    // the answers to the family questions that you display on your profile
    var familyPlans: [MultipleChoiceAnswer]
    // vices: drugs/drinks
    var vices: [MultipleChoiceAnswer]
    // traits that you describe yourself as upon sign-up
    var personalityAnswers: [Personality]
    // priorities list
    var priorities: [String]
    
    private enum CodingKeys: String, CodingKey {
        case photos
        case socials
        case freeResponse
        case lat
        case lon
        case personalDetails
        case familyPlans
        case vices
        case personalityAnswers
        case priorities 
    }
    
    init(photos: [String], socials: [SocialProfile], freeResponse: [FreeResponse], lat: Double, lon: Double, personalDetails: PersonalDetails, familyPlans: [MultipleChoiceAnswer], vices: [MultipleChoiceAnswer], personalityAnswers: [Personality], priorities: [String]) {
        self.photos = photos
        self.socials = socials
        self.freeResponse = freeResponse
        self.lat = lat
        self.lon = lon
        self.personalDetails = personalDetails
        self.familyPlans = familyPlans
        self.vices = vices
        self.personalityAnswers = personalityAnswers
        self.priorities = priorities
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
        let familyPlans = try container.decode(Array<MultipleChoiceAnswer>.self, forKey: .familyPlans )
        let vices = try container.decode(Array<MultipleChoiceAnswer>.self, forKey: .vices )
        let personalityAnswers = try container.decode(Array<Personality>.self, forKey: .personalityAnswers )
        let priorities = try container.decode(Array<String>.self, forKey: .priorities )
        
        self.photos = photos
        self.socials = socials
        self.freeResponse = freeResponse
        self.lat = lat
        self.lon = lon
        self.personalDetails = personalDetails
        self.familyPlans = familyPlans
        self.vices = vices
        self.personalityAnswers = personalityAnswers
        self.priorities = priorities
    }
    
    
    public func makeFromDict() -> [String: Any] {
        var socials: [[String: Any]] = []
        for social in self.socials {
            socials.append(social.makeFromDict())
        }
        
        var freeResponses: [[String: Any]] = []
        for fr in self.freeResponse {
            freeResponses.append(fr.makeFromDict())
        }
        
        var familyPlans: [[String: Any]] = []
        for plans in self.familyPlans {
            familyPlans.append(plans.makeFromDict())
        }
        
        var vices: [[String: Any]] = []
        for vice in self.vices {
            vices.append(vice.makeFromDict())
        }
        
        var personalities: [[String: Any]] = []
        for personality in self.personalityAnswers {
            personalities.append(personality.makeFromDict())
        }
        
       return ["photos": self.photos,
               "socials": socials,
               "freeResponse": freeResponses,
               "lat": self.lat,
               "lon": self.lon,
               "personalDetails": self.personalDetails.makeFromDict(),
               "familyPlans": familyPlans,
               "vices": vices,
               "personalityAnswers": personalities,
               "priorities": self.priorities]
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
        case short
     }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let question = try container.decode(String.self, forKey: .question)
        let answerChoices = try container.decode(Array<String>.self, forKey: .answerChoices)
        let answer = try container.decode(String.self, forKey: .answer)
        let topValue = try container.decode(String.self, forKey: .topValue)
        let bottomValue = try container.decode(String.self, forKey: .bottomValue)
        let short = try container.decode(String.self, forKey: .short)
        self.topValue = topValue
        self.bottomValue = bottomValue
        super.init(answer: answer, question: question, answerChoices: answerChoices, short: short)
    }
    
    
    public override func makeFromDict() -> [String: Any] {
       return ["topValue": self.topValue,
               "bottomValue": self.bottomValue,
               "answer": self.answer,
               "question": self.question,
               "answerChoices": self.answerChoices,
               "short": self.short]
    }
}

// “Your most embarrassing memory?”
// Open Ended questions and answers
class FreeResponse: Codable {
    let question: String
    let answer: String
    let image: String
    
    init(question: String, answer: String, image: String) {
        self.question = question
        self.answer = answer
        self.image = image
    }
    
    public func makeFromDict() -> [String: Any] {
        return ["question": self.question,
                "answer": self.answer,
                "image": self.image]
    }
}

class MultipleChoiceAnswer: MultipleChoice {
    var answer: String
    
    private enum Key: CodingKey {
       case question
       case answerChoices
       case answer
       case short
    }
    init(answer: String, question: String, answerChoices: [String], short: String) {
        self.answer = answer
        super.init(question: question, answerChoices: answerChoices, short: short)
        
    }
       
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let question = try container.decode(String.self, forKey: .question)
        let answerChoices = try container.decode(Array<String>.self, forKey: .answerChoices)
        let answer = try container.decode(String.self, forKey: .answer)
        let short  = try container.decode(String.self, forKey: .short)
        self.answer = answer
        super.init(question: question, answerChoices: answerChoices, short: short)
    }
    public override func makeFromDict() -> [String: Any] {
       return ["answer": self.answer,
               "question": self.question,
               "answerChoices": self.answerChoices,
               "short": self.short]
    }
}

//  Question with limited answers
class MultipleChoice: Codable {
    //let id: String //maybe
    let question: String
    let answerChoices: [String]
    let short: String
    let isHidden: Bool
    let isMandatory: Bool
    
    init(question: String, answerChoices: [String], short: String, isHidden: Bool, isMandatory: Bool) {
        self.question = question
        self.answerChoices = answerChoices
        self.short = short
        self.isHidden = isHidden
        self.isMandatory = isMandatory
    }
    
    public func makeFromDict() -> [String: Any] {
       return ["question": self.question,
               "answerChoices": self.answerChoices,
               "short": self.short]
    }
}


struct PersonalDetails: Codable {
    let fullName: PersonalDetailItem
    let age: PersonalDetailItem
    let height: PersonalDetailItem
    var gender: PersonalDetailItem
    var ethnicity: PersonalDetailItem
    var location: PersonalDetailItem
    var jobTitle: PersonalDetailItem
    var company: PersonalDetailItem
    
    public func makeFromDict() -> [String: Any] {
        return ["fullName": self.fullName.makeFromDict(),
                "age": self.age.makeFromDict(),
                "height": self.height.makeFromDict(),
                "gender": self.gender.makeFromDict(),
                "ethnicity": self.ethnicity.makeFromDict(),
                "location": self.location.makeFromDict(),
                "jobTitle": self.jobTitle.makeFromDict(),
                "company": self.company.makeFromDict()]
    }
}



class PersonalDetailItem: Codable {
    var title: String
    let isEditable: Bool
    let type: PersonalDetailType
    let answerChoices: [String]?
    
    //use rawValue on makeFromDict
    enum PersonalDetailType: String, Codable {
        case textfield
        case spinner
        case multipleChoice
    }
    
    
    init(title: String, isEditable: Bool, type: PersonalDetailType, answerChoices: [String]? = nil) {
        self.title = title
        self.isEditable = isEditable
        self.type = type
        self.answerChoices = answerChoices
    }
    
    public func makeFromDict() -> [String: Any] {
        var answerChoices: [String]?
        if let answers = self.answerChoices {
            answerChoices = answers
        }
          return ["title": self.title,
                  "isEditable": self.isEditable,
                  "type": self.type.rawValue,
                  "answerChoices": answerChoices]
    }
}



class SocialProfile: Codable {
    let platform: String
    let link: String
    
    init(platform: String, link: String) {
        self.platform = platform
        self.link = link
    }
    
    public func makeFromDict() -> [String: Any] {
          return ["platform": self.platform,
                  "link": self.link]
    }
}

//class Filter: Codable {
//    let interest: [GenderType]
//    let distance: Int
//    let age: Int
//    let moreFilters: [MultipleChoice]
//}

struct QuestionCards: Codable {
    let questions: [String]
}

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
    
    public func makeFromDict() -> [String: Any] {
        return ["name": self.name,
                "size": self.size,
                "taste": self.taste]
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
