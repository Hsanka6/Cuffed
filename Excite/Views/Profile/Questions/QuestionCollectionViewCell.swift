//
//  QuestionCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/27/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol QuestionCollectionViewCellDelegate: class {
    func didRequestAnswerQuestionViewController(controller: AnswerQuestionViewController)
    func editFreeResponse(freeResponse: [FreeResponse])
}

class QuestionCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "question"
    var question: String?
    var freeResponse: [FreeResponse]?
    var index: Int?
    weak var delegate: QuestionCollectionViewCellDelegate?
    
    func initialize(question: String) {
        self.question = question
        self.backgroundColor = .gray
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
        make.height.equalTo(450)
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
        controller.index = index
        controller.freeResponse = freeResponse
        controller.delegate = self
        delegate?.didRequestAnswerQuestionViewController(controller: controller)
        
    }
}

extension QuestionCollectionViewCell: AnswerQuestionViewControllerDelegate {
    func didEditFreeResponse(freeResponse: [FreeResponse]) {
        delegate?.editFreeResponse(freeResponse: freeResponse)
    }
}
