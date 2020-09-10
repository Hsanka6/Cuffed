//
//  SignupViewModel.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/30/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation


struct SignupViewModel {
    // this is where we will be storing the questions, then checking to see if they've filled out a minimum amount of questions
    var user: User?
    init(_ user: User?) {
        self.user = user
    }
    
}
