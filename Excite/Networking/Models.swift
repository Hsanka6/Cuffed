//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

struct User: Decodable {
    let userId: String
    let fullName: String
    let age: Int
    let email: String
    let profile: Profile
    let currentMoments: [Moment]
}

enum GenderType: String, Decodable {
    case MALE
    case FEMALE
    case OTHER
}

enum Availability: Int, Decodable {
    case NOW = 15 // 0 - 15
    case SOON = 30 // 16 - 30
    case LATER = 60 // 31 - 60
}

struct Moment: Decodable {
    let match: Match
    let time: Date
}

struct Profile: Codable {
    let photos: [String]!
}
//    let matches: [Match]
//    let socials: [SocialProfile]
//    let questions: [Question]
//    let location: String
//    let lat: Double
//    let lon: Double
//    let height: Int //inches
//    let ethnicity: String
//    let jobTitle: String
//    let company: String
//    let gender: GenderType
//    let filter: Filter

struct Question: Decodable {
    let question: String
    let answer: String
}
struct Match: Decodable {
    let matchId: String
    let userId1: String
    let userId2: User
}

struct SocialProfile: Decodable {
    let platform: String
    let profileLink: String
}

struct Filter: Decodable {
    let interest: [GenderType]
    let distance: Int
    let time: Availability
    let age: Int
}
