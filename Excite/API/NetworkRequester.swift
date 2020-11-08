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
import CodableFirebase

protocol NetworkRequesterProtocol {
    //func getQuestion(completion: @escaping (Swift.Result<Question, Error>) -> Void)
    //func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void)
}


extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
    }
}

class NetworkRequester: NetworkRequesterProtocol {
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

    
    func getUser(_ id: String, completion: @escaping(User?) -> Void) {
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
                    completion(nil)
                }
            case .failure(let error):
                print("Error decoding something here: \(error)")
            }
        }
    }

    static func updateUser(user: User, completion: @escaping() -> Void) {
        let database = Firestore.firestore()
        // there are 4 network calls here whoops lol
        database.collection("Users").document(user.userId).setData([ "profile": user.profile!.makeFromDict() ], merge: true)
        database.collection("Users").document(user.userId).setData([ "userId": user.userId ], merge: true)
        database.collection("Users").document(user.userId).setData([ "name": user.name ], merge: true)
        database.collection("Users").document(user.userId).setData([ "email": user.email ], merge: true)
        database.collection("Users").document(user.userId).setData([ "isPremium": user.isPremium ?? false ], merge: true)
        completion()
    }
    
    // return a key of questions organized by documentID as key and an array of corresponding questions as values.
    static func getProfileQuestions(completion: @escaping([ String: [SignupModels.Question] ]) -> Void) {
        let database = Firestore.firestore()
        var results = [ String: [SignupModels.Question] ]()
//        database.collection("QuestionsCollection").getDocuments { (documents, error) in
        database.collection("QuestionsCollection").getDocuments { (documents, error) in
            for document in documents!.documents {
                // print("\(document.documentID) => \(document.data())")
                
                // ------------------------------------
                let profileAttribute = document.documentID
                let value = document.data()
                var arr = [SignupModels.Question]()
                
                print(profileAttribute)
                let cnt = value.compactMap { (tuple) in
                    guard let dictionaryValue = tuple.value as? Dictionary<String, Any> else {return}
                    if let question = dictionaryValue["question"] as? String,
                       let isHidden = dictionaryValue["isHidden"] as? Bool,
                       let short = dictionaryValue["short"] as? String,
                       let isMandatory = dictionaryValue["isMandatory"] as? Bool,
                       let answers = dictionaryValue["answers"] as? [String] {
                            arr.append(SignupModels.MultipleChoice(id: tuple.key, question: question, answers: answers, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: nil))
                        
                    } else if let question = dictionaryValue["question"] as? String,
                           let isHidden = dictionaryValue["isHidden"] as? Bool,
                           let short = dictionaryValue["short"] as? String,
                           let isMandatory = dictionaryValue["isMandatory"] as? Bool {
                            arr.append(SignupModels.FreeResponse(id: tuple.key, question: question, isMandatory: isMandatory, isHidden: isHidden, short: short, answerChoice: nil))
                    }
                }
                results[profileAttribute]=arr
            }
            completion(results)
        }
    }
    
    func getQuestions(completion: @escaping(QuestionCards) -> Void) {
        let database = Firestore.firestore()
        database.collection("FreeResponse").document("ProfileQuestions").getDocument { (document, error) in
            let result = Result {
                try document?.data(as: QuestionCards.self)
            }
            switch result {
            case .success(let questions):
                if let questions = questions {
                    completion(questions)
                } else {
                    print("Document doesn't exist")
                }
            case .failure(let error):
                print("Error decoding something here \(error)")
            }
        }
    }

    
        static func getProfileQuestions(completion: @escaping() -> Void) {
            let database = Firestore.firestore()
            var results = [ String: [SignupModels.Question] ]()
    //        database.collection("QuestionsCollection").getDocuments { (documents, error) in
            database.collection("Questions").getDocuments { (documents, error) in
                for document in documents!.documents {
                    
                    
                    
                    // print("\(document.documentID) => \(document.data())")
                    
                    // ------------------------------------
                    /*
                    let profileAttribute = document.documentID
                    let value = document.data()
                    var results = [SignupModels.Question]()
                    
                    print(profileAttribute)
                    let cnt = value.compactMap { (tuple) in
                        guard let dictionaryValue = tuple.value as? Dictionary<String, Any> else {return}
                        print(type(of: dictionaryValue))
                        print(dictionaryValue)
                        let MC: SignupModels.MultipleChoice = try dictionaryValue as
    //                    let model = try! dictionaryValue as SignupModels.MultipleChoice
    //                    let model = try! JSONDecoder().decode(SignupModels.MultipleChoice.self, from: dictionaryValue)
    //                    print(
    //                    let jsonData = dictionary.value.data(using: .utf8)!
    //                    print(type(of: dictionary))
                        
    //                    let jsonData = dictionary.data(using: .utf8)!
    //                    let model = try! JSONDecoder().decode(SignupModels.MultipleChoice.self, from: dictionary)
                    }
                    print(type(of: cnt))
                     //                for val in value.values {
                     //                    guard let json = val as
                     //                }
                     //                print(profileAttribute)
                     //                let MC = value.values as? SignupModels.MultipleChoice
                     //                let FR = value.values as? SignupModels.FreeResponse
                     //                print(MC)
                     //                print(FR)
                                     
                    */
                    // ------------------------------------
                    
                    print(type(of: document.data()))
                    // document.data() is a dictionary<String, Any>
                    let MCResult = Result {
                         try document.data(as: SignupModels.MultipleChoice.self)
                    }
                    switch MCResult {
                    case .success(let question):
                        if let question = question {
                            
    //                        results[key] = question
                            continue
                        } else {
                            print("Document doesn't exist")
                        }
                    default:
                        break
                    }

                    let FRresult = Result {
                        try document.data(as: SignupModels.FreeResponse.self)
                    }
                    switch FRresult {
                    case .success(let question):
                        if let question = question {
    //                        results[document.documentID] = question
                        } else {
                            print("Document doesn't exist")
                        }
                    case .failure(let error):
                        print("Wasn't able to decode a FR or MC question \(error)")
                    }
                }
                completion()
            }
        }
}
