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
    let email: String
    let profile: Profile
   // let currentMoments: [Moment]
}

enum GenderType: String, Codable {
    case MALE
    case FEMALE
    case OTHER
}

enum Availability: Int, Codable {
    case NOW = 15 // 0 - 15
    case SOON = 30 // 16 - 30
    case LATER = 60 // 31 - 60
}

//Potential Date
struct Moment: Codable {
    let id: String
    let match: Match
    let time: Date
}

struct Profile: Codable {
    let photos: [String]
    let matches: [Match]
    let socials: [SocialProfile]
    let questions: [Question]
    let lat: Double
    let lon: Double
    let personalDetails: PersonalDetails
    //let filter: Filter
}

struct PersonalDetails: Codable {
    let fullName: String
    let age: Int
    let height: Int //inches
    let gender: GenderType
    let ethnicity: String
    let location: String
    let jobTitle: String
    let company: String
}

struct Question: Codable {
    let question: String
    let answer: String
}
struct Match: Codable {
    let id: String
    let user1Id: String
    let user2Id: String
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
}
