//
//  NetworkRequester.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequesterProtocol {
    func getQuestion(completion: @escaping (Swift.Result<Question, Error>) -> Void)
    func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void)
}

class NetworkRequesterMock: NetworkRequesterProtocol {
    func getQuestion(completion: @escaping (Result<Question, Error>) -> Void) {
        let oneSecond = DispatchTime.now() + 1
        let mockResponsePath = Bundle.main.path(forResource: "Question", ofType: "json")
        do {
          let data = try Data(contentsOf: URL(fileURLWithPath: mockResponsePath!))
          let response = try JSONDecoder().decode(Question.self, from: data)
            DispatchQueue.main.asyncAfter(deadline: oneSecond) {
                completion(.success(response))
            }
          } catch {
            print(error)
        }
    }
    func getProfile(completion: @escaping (Swift.Result<Profile, Error>) -> Void) {
        let oneSecond = DispatchTime.now() + 1
        let mockResponsePath = Bundle.main.path(forResource: "Profile", ofType: "json")
        do {
          let data = try Data(contentsOf: URL(fileURLWithPath: mockResponsePath!))
          let response = try JSONDecoder().decode(Profile.self, from: data)
            DispatchQueue.main.asyncAfter(deadline: oneSecond) {
                completion(.success(response))
            }
          } catch {
            print(error)
        }
    }
//    func getCurrentArtist(completion: @escaping (Swift.Result<Artist, Error>) -> Void) {
//        let oneSecond = DispatchTime.now() + 1
//        let mockResponsePath = Bundle.main.path(forResource: "CurrentArtist", ofType: "json")
//        let data = try! Data(contentsOf: URL(fileURLWithPath: mockResponsePath!))
//        let response = try! JSONDecoder().decode(Artist.self, from: data)
//        DispatchQueue.main.asyncAfter(deadline: oneSecond) {
//            completion(.success(response))
//        }
//    }
}
