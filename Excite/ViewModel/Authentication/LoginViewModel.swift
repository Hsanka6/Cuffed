//
//  LoginViewModel.swift
//  CuffedChat
//
//  Created by Max He on 8/15/20.
//  Copyright © 2020 Max He. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
