//
//  SignupCollectionViewCell.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/14/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

class SignupCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "photo"

    // By valentines day we shoyld have the app finished
    // By mid oct we should have everything we are currently working on finished
    // For me oct 15 should be the early date
    // Oct 30th is the cutoff date for sign up
    
    // builder design pattern
    // question
    // answers
        // selection of MC -> Edit questions View Controller
        // textfield
        // grid of pictures
        // question and answer for the personalized questions
    let label: UILabel = {
        let curr = UILabel()
        curr.text = "Label"
        curr.font = UIFont.systemFont(ofSize: 20)
        curr.textAlignment = .right
        curr.textColor = .black
        curr.backgroundColor = .yellow
        return curr
    }()
    func initialize() {
        self.addSubview(label)
        self.layer.backgroundColor = UIColor.blue.cgColor
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.center.equalToSuperview().inset(30)
        }
    }
    
}

