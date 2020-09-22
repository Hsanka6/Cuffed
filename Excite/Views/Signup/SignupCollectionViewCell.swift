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
    
    var question: String?
    var profile: Profile?
    var index: Int?
    var viewController: UIViewController?
    
    func initialize(question: String) {
        self.question = question
        // self.backgroundColor = .gray
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
        make.height.equalTo(600)
        make.width.equalTo(UIScreen.main.bounds.width - 60)
        make.center.equalToSuperview()
        }
        cardView.dropShadow()
        let questionLabel = UILabel()
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = question
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        cardView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        let answerButton = UIButton()
        answerButton.setTitle("Answer", for: .normal)
        answerButton.backgroundColor = .gray
        answerButton.tintColor = .white
        answerButton.layer.cornerRadius = 15
        cardView.addSubview(answerButton)
        answerButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        answerButton.isUserInteractionEnabled = true
        answerButton.addTarget(self, action: #selector(self.answerQuestion), for: .touchUpInside)
    }
    
    @objc func answerQuestion() {
        let controller = AnswerQuestionViewController()
        controller.question = question
        controller.profile = profile
        controller.index = index
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
        
    }

    
}

