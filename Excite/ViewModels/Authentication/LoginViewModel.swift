//
//  LoginViewModel.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/28/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation

struct LoginViewModel {
    var currentUser: User?
    var userId: String?
    init() {
        self.currentUser = nil
        self.userId = nil
    }
    
    // for now, let's just do a lookup to check if they're in Firestore
    // If they aren't, then we don't store their details -> their user is not complete
    
    // for the future, check if they have a User associated
    // even if they do, check if the minimum fields are at least filled out
    // otherwise, redirect them to the signup page
    func completeUser() -> Bool {
        return self.currentUser != nil && self.currentUser!.profile != nil
    }
}
