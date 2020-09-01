//
//  NetworkRequester.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Alamofire
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol NetworkRequesterProtocol {
    //func getQuestion(completion: @escaping (Swift.Result<Question, Error>) -> Void)
    //func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void)
}

class NetworkRequester: NetworkRequesterProtocol {
    // specifies that the completion handler takes in a User-object here
    func getUser(_ id: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("Users").document(id).getDocument { (document, error) in
            let result = Result {
                try document?.data(as: User.self)
            }
            switch result {
                case .success(let user):
                    if let user = user {
                        completion(user)
                    } else {
                        print("User \(id) was not found in the Firestore Database.")
                    }
                case .failure(let error):
                    print("Error decoding something here: \(error)")
            }
        }
    }
}
