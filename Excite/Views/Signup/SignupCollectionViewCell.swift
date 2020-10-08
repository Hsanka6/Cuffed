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
    static var reuseIdentifier = "signup"

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
    
    
    // Use the Sign Up Specific Models for FR + MC questions here
    
    var question: SignupModels.Question?
    
    var profile: Profile?
    var index: Int?
    var viewController: UIViewController?
    
    // keep track of the background card view
    var cardView: UIView?
    
    // this is here to switch the cells
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // numSize is the amount of cells we're going to be rendering
    var numSize: Int?
    
    func initialize(question: SignupModels.Question, collectionView: UICollectionView, numSize: Int) {
        self.question = question
        self.collectionView = collectionView
        self.numSize = numSize
        
        
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
        make.height.equalTo(600)
        make.width.equalTo(UIScreen.main.bounds.width - 80)
        make.center.equalToSuperview()
        }
        cardView.dropShadow()
        self.cardView = cardView
        let questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = question.question
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
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = 15
        cardView.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo(-10)
        }
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(self.nextPageButtonClicked), for: .touchUpInside)
        
        let answerBox = UITextView()
        answerBox.backgroundColor = .lightGray
        answerBox.tintColor = .white
        answerBox.layer.cornerRadius = 5
        cardView.addSubview(answerBox)
        answerBox.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(80)
            make.center.equalToSuperview()
        }
        renderQuestion()
    }
    
    func renderQuestion() {
        if type(of: self.question!) == SignupModels.FreeResponse.self {
        }
        else if type(of: self.question!) == SignupModels.MultipleChoice.self {
        }
        else {
            print("NOT SUPPOSED TO HAPPEN")
        }
    }
    
    
    
    @objc func answerQuestion() {
        let controller = AnswerQuestionViewController()
        controller.profile = profile
        controller.index = index
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func nextPageButtonClicked() {
        print("IS THIS CLICKED")
        let indexPath = self.collectionView.indexPathsForVisibleItems.first.flatMap({
            IndexPath(item: $0.row + 1, section: $0.section)
        })
        if indexPath!.row < numSize! {
            self.collectionView.scrollToItem(at: indexPath!, at: .right, animated: true)
        } else {
            print("Can't scroll anymore")
        }
    }
}
