//
//  NetworkRequester.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import FirebaseFirestoreSwift

protocol NetworkRequesterProtocol {
    //func getQuestion(completion: @escaping (Swift.Result<Question, Error>) -> Void)
    //func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void)
}

class NetworkRequesterMock: NetworkRequesterProtocol {
//    func getQuestion(completion: @escaping (Result<Question, Error>) -> Void) {
//        let oneSecond = DispatchTime.now() + 1
//        let mockResponsePath = Bundle.main.path(forResource: "Question", ofType: "json")
//        do {
//          let data = try Data(contentsOf: URL(fileURLWithPath: mockResponsePath!))
//          let response = try JSONDecoder().decode(Question.self, from: data)
//            DispatchQueue.main.asyncAfter(deadline: oneSecond) {
//                completion(.success(response))
//            }
//          } catch {
//            print(error)
//        }
//    }
//    func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void) {
//        let oneSecond = DispatchTime.now() + 1
//        let mockResponsePath = Bundle.main.path(forResource: "Profile", ofType: "json")
//        do {
//          let data = try Data(contentsOf: URL(fileURLWithPath: mockResponsePath!))
//          let response = try JSONDecoder().decode(Profile.self, from: data)
//            DispatchQueue.main.asyncAfter(deadline: oneSecond) {
//                completion(.success(response))
//            }
//          } catch {
//            print(error)
//        }
//    }

    func getFood(name: String) {
        let db = Firestore.firestore()
        
        db.collection("test").document(name).getDocument { (document, error) in
             let result = Result {
                 try document?.data(as: Test.self)
               }
               switch result {
               case .success(let test):
                   if let test = test {
                       // A `City` value was successfully initialized from the DocumentSnapshot.
                    print("City: \(test.food.taste)")
                       //print(test)
                      // return test
                   } else {
                       // A nil value was successfully initialized from the DocumentSnapshot,
                       // or the DocumentSnapshot was nil.
                       print("Document does not exist")
                   }
               case .failure(let error):
                   // A `City` value could not be initialized from the DocumentSnapshot.
                   print("Error decoding city: \(error)")
                //return test()
               }
        }
       // return test()
    }
}
