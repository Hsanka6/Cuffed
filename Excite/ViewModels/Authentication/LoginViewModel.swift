//
//  LoginViewModel.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/28/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation

/**
 LoginViewModel object that correlates to Controllers/Authentication/LoginController.swift
 */
struct LoginViewModel {
    var currentUser: User?
//    mutating func setUser(_ id: String) {
//        currentUser = User(id)
//    }
    func completeUser(_ id: String) -> Bool {
        // check to see if profile is filled out at all
        // define minimum properties for a user to be considered "complete" here
        return false
    }
}

