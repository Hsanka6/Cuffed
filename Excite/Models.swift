//
//  Models.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let userId: String
    let fullName: String
    let age: Int
    let email: String
    let profile: Profile
    let currentMoments: [Moment]
    let interest: [GenderType]
}

enum GenderType: String {
    case MALE
    case FEMALE
}

struct Moment {
    let match: Match
    let time: Date
}

struct Profile {
    let photos: [String]?
    let matches: [Match]
    let socials: [SocialProfile]
    let questions: [Question]
    let location: String
    let lat: Double
    let lon: Double
    let height: Int //inches
}

struct Question {
    let question: String
    let answer: String
}
struct Match {
    let matchId: String
    let userId1: String
    let userId2: User
}

struct SocialProfile {
    let platform: String
    let profileLink: String
}
