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
    let matches: [Match]
}

enum GenderType: String, Codable {
    case MALE
    case FEMALE
    case OTHER
}


//Po Date
struct Dates: Match {
    let id: String
    let userId1: String
    let userId2: String
}


struct Profile: Codable {
    let photos: [String]
    let socials: [SocialProfile]
    let questions: [Question]
    let lat: Double
    let lon: Double
    let personalDetails: PersonalDetails
    let details: [Detail] // ""
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

struct Question: Codable {
    let question: String
    let answer: String
    let image: String
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
