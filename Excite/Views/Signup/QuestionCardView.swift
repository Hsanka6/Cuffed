//
//  CardViewQuestion.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit


// Render question here, and have references to either the object or pass in a closure function to update user data inside of  SignupViewController

// can either be Multiple Choice or Free Response
class QuestionCardView: UIView {
    var question: SignupModels.Question
    
    // free response
    var freeResponseAnswer: UITextField?
    
    // multiple choice fields
    var selectedIndexPath: IndexPath?
    let mcAnswersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var saveAnswer: ((SignupModels.Question)->())?
    init(for attribute: String, question: SignupModels.Question, frame: CGRect, saveClosure: @escaping(SignupModels.Question) -> Void) {
        self.saveAnswer = saveClosure
        self.question = question
        super.init(frame: frame)
        let questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = question.question
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        renderQuestion()
        
    }
    convenience init() {
        self.init(for: "", question: SignupModels.Question(id: "", question: "", isMandatory: false, isHidden: true, short: "", answerChoice: ""), frame: CGRect.zero) { _ in }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func renderQuestion() {
        if type(of: self.question) == SignupModels.MultipleChoice.self {
            setupCollectionView()
        } else if type(of: self.question) == SignupModels.FreeResponse.self {
            let freeResponseAnswer: UITextField = {
                let freeResponseAnswer = UITextField()
                freeResponseAnswer.textColor       = .black
                freeResponseAnswer.textAlignment   = .center
                freeResponseAnswer.textColor       = .black
                freeResponseAnswer.font            = UIFont.systemFont(ofSize: 30)
                freeResponseAnswer.attributedPlaceholder = NSAttributedString(string: self.question.short, attributes: [.foregroundColor : UIColor.lightGray])
                freeResponseAnswer.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
                if let previousAnswer = question.answerChoice {
                    freeResponseAnswer.text = previousAnswer
                }
                return freeResponseAnswer
            }()
            self.addSubview(freeResponseAnswer)
            self.freeResponseAnswer = freeResponseAnswer
            freeResponseAnswer.snp.makeConstraints { (make) in
                make.width.equalTo(300)
                make.height.equalTo(80)
                make.center.equalToSuperview()
            }
            
        }
    }
    @objc func enterPressed() {
        self.question.answerChoice = self.freeResponseAnswer?.text
        self.saveAnswer?(self.question)
    }
    func setupCollectionView() {
        self.addSubview(self.mcAnswersCollectionView)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        mcAnswersCollectionView.collectionViewLayout = layout

        self.mcAnswersCollectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalToSuperview().multipliedBy(0.8)
        }

        self.mcAnswersCollectionView.dataSource = self
        self.mcAnswersCollectionView.delegate = self
        self.mcAnswersCollectionView.backgroundColor = .white
        self.mcAnswersCollectionView.clipsToBounds = true
        self.mcAnswersCollectionView.showsVerticalScrollIndicator = false
        self.mcAnswersCollectionView.register(MultipleChoiceQuestionViewCell.self, forCellWithReuseIdentifier: MultipleChoiceQuestionViewCell.reuseIdentifier)
        self.mcAnswersCollectionView.isScrollEnabled = true

    }
}


extension QuestionCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return 0}
        return answerChoices.answers.count
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        mcAnswersCollectionView.removeFromSuperview()
//        mcAnswersCollectionView.reloadData()
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleChoiceQuestionViewCell.reuseIdentifier, for: indexPath) as? MultipleChoiceQuestionViewCell {
            guard let currentQuestion = self.question as? SignupModels.MultipleChoice else {return UICollectionViewCell()}
            cell.initialize(answer: currentQuestion.answers[indexPath.row])
            return cell
         }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(50.0) // self.collectionView.frame.height
        let width = self.mcAnswersCollectionView.frame.width
        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? MultipleChoiceQuestionViewCell {

            if self.selectedIndexPath == indexPath {
                self.collectionView(mcAnswersCollectionView, didDeselectItemAt: indexPath)
                return
            }

            cell.cellView?.backgroundColor = .green
//            self.question?.answerChoice = cell.answers.count

        }
        self.selectedIndexPath = indexPath
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? MultipleChoiceQuestionViewCell {
            cell.cellView?.backgroundColor = .white
        }
        self.selectedIndexPath = nil
    }
}

