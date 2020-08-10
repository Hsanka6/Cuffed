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
    let matches: [Date]
    let liked: [String] //your likes
    let likedYou: String //array of userIds that liked you
    let seen: [String] //array of seen users
    let blocked: [String] //array of blocked users
    let isPremium: Bool
}


enum GenderType: String, Codable {
    case MALE
    case FEMALE
    case OTHER
}

struct tenQuestions: Game {
   let question:[String]
}

struct Game: Codable {
   let id: String
}



struct Date: Codable {
    let id: String
    let chatId: String
    let user1Id: String
    let user2Id: String
    let games: [String]
}

struct Match: Date {
   let isMatch: bool
}


struct Profile: Codable {
    let photos: [String]
    let socials: [SocialProfile]
    let freeResponse: [FreeResponse]
    let lat: Double
    let lon: Double
    let personalDetails: PersonalDetails
    let answers: [MultipleChoiceAnswer]
    let personalityAnswers:  [Personality]
}

Struct Personality: MultipleChoiceAnswer {
    let topValue: String //extroverted
    let bottomValue: String //introverted
}

// “Your most embarrassing memory?” 
// Open Ended questions and answers
struct FreeResponse: Codable {
    let question: String
    let answer: String
    let image: String
}

struct MultipleChoiceAnswer: MultipleChoice, Codable {
    let answer: String
}

//  Question with limited answers
struct MultipleChoice: Codable {
    let id: String //maybe
    let question: String
    let answerChoices: [String]
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


struct SocialProfile: Codable {
    let platform: String
    let link: String
}

struct Filter: Codable {
    let interest: [GenderType]
    let distance: Int
    let time: Availability
    let age: Int
    Let moreFilters: [MultipleChoice]
}
