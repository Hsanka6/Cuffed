//
//  AuthService.swift
//  CuffedChat
//
//  Created by Max He on 8/18/20.
//  Copyright © 2020 Max He. All rights reserved.
//

import UIKit
import Firebase

struct AuthService {
    static let shared = AuthService()
    
    
    func storeImages(photo: UIImage, index: Int, userId: String, completion: @escaping (String) -> Void) {
            guard let imageData = photo.jpegData(compressionQuality: 0.3) else { return }
        
           // let filename = NSUUID().uuidString
            let storage = Storage.storage()
            let ref = storage.reference(withPath: "/\(userId)/profile_images/\(index)")
            
            ref.putData(imageData, metadata: nil) { (meta, error) in
                if let error = error {
                    print("\(error)")
                    return
                }
                ref.downloadURL { (url, error) in
                    guard let url = url?.absoluteString else { return }
                    if let err = error {
                        print("\(err)")
                    }
                    completion(url)

                     
                }
               
            }
    }
}
