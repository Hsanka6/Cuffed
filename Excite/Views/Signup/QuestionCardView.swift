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
    var question: SignupModels.Question?

    // keep track of the background card view
    var cardView: UIView?

    let mcAnswersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // index path of current answer of the
    var selectedIndexPath: IndexPath?

    var freeResponseBox: UITextField?

    init(for attribute: String, question: SignupModels.Question?, frame: CGRect) {
        
        // make the frame smaller here
        super.init(frame: frame)
        
        // so i still get the same error --
        // the whole view actually blocks the buttons from being pressed
        
        
//        self.backgroundColor = .green
//        let cardView = UIView()
//        self.addSubview(cardView)
//        cardView.backgroundColor = .lightGray
//        cardView.snp.makeConstraints { (make) in
//            make.height.equalTo(300)
//            make.width.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.top.equalToSuperview().inset(140)
//        }
//
//
        let questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = question!.question
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        addBehavior()
    }

    @objc func watta() {
        print("YO")
    }
    convenience init() {
        self.init(for: "", question: nil, frame: CGRect.zero)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func addBehavior() {
        
    }
    //    func initialize(question: SignupModels.Question, questionNum: Int, user: User) {
    func initialize(questionId: String, questionNum: Int, question: SignupModels.Question) {
    }

}
//
//extension SignupCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return 0}
//        // remember answer is the selection of answers... answerChoice is the choice that the user made
//        return answerChoices.answer.count
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        mcAnswersCollectionView.removeFromSuperview()
//        mcAnswersCollectionView.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier, for: indexPath) as? SignupCellMultipleChoiceAnswer {
//            guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return UICollectionViewCell()}
//            cell.initialize(answer: answerChoices.answer[indexPath.row])
//            return cell
//         }
//        return UICollectionViewCell()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = CGFloat(50.0) // self.collectionView.frame.height
//        let width = self.mcAnswersCollectionView.frame.width
//        return CGSize(width: width, height: height)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? SignupCellMultipleChoiceAnswer {
//
//            if self.selectedIndexPath == indexPath {
//                self.collectionView(mcAnswersCollectionView, didDeselectItemAt: indexPath)
//                return
//            }
//
//            cell.cellView?.backgroundColor = .green
//            self.question?.answerChoice = cell.answer
//
//        }
//        self.selectedIndexPath = indexPath
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? SignupCellMultipleChoiceAnswer {
//            cell.cellView?.backgroundColor = .white
//        }
//        self.selectedIndexPath = nil
//    }
//}



//    func renderQuestion() {
//        if type(of: self.question!) == SignupModels.FreeResponse.self {
//            let freeResponseAnswer: UITextField = {
//                let freeResponseAnswer = UITextField()
//                freeResponseAnswer.textColor       = .black
//                freeResponseAnswer.textAlignment   = .center
//                freeResponseAnswer.textColor       = .black
//                freeResponseAnswer.font            = UIFont.systemFont(ofSize: 30)
//                freeResponseAnswer.attributedPlaceholder = NSAttributedString(string: self.question!.short, attributes: [.foregroundColor : UIColor.lightGray])
//                return freeResponseAnswer
//            }()
//            self.cardView!.addSubview(freeResponseAnswer)
//            freeResponseAnswer.snp.makeConstraints { (make) in
//                make.width.equalTo(300)
//                make.height.equalTo(80)
//                make.center.equalToSuperview()
//            }
////            if let previousAnswerChoice = self.question?.answerChoice {
////                self.freeResponseBox!.text = self.question?.answerChoice ?? nil
////            }
//            self.question?.answerChoice = freeResponseAnswer.text
//            self.freeResponseBox = freeResponseAnswer
//            self.freeResponseBox!.delegate = self
////            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: cardview.self, action: #selector(dDismissKeyboard))
////            self.freeResponseBox!.addGestureRecognizer(tap)
//        } else if type(of: self.question!) == SignupModels.MultipleChoice.self {
//            // guard let answerChoices = self.question! as! SignupModels.MultipleChoice as SignupModels.MultipleChoice? else {return}
//            setupCollectionView()
//        } else {
//            // TableView
//            //
//            print("NOT SUPPOSED TO HAPPEN")
//        }
//    }
//
//    @objc func renderBackButton(_ questionNum: Int) {
//        if questionNum>0 {
//                let backButton = UIButton()
//                backButton.setTitle("Back", for: .normal)
//                backButton.backgroundColor = .blue
//                backButton.tintColor = .white
//                backButton.layer.cornerRadius = 15
//                cardView!.addSubview(backButton)
//                backButton.snp.makeConstraints { (make) in
//                    make.width.equalTo(40)
//                    make.height.equalTo(40)
//                    make.trailing.equalToSuperview().multipliedBy(0.2)
//                    make.bottom.equalTo(-10)
//                }
//                backButton.isUserInteractionEnabled = true
//
//                backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
//        }
//    }
//
//    @objc func nextButtonTapped() {
//        if pageIsFilledOut() {
//            nextButtonAction?(self.question?.answerChoice)
//        }
//    }
//
//    @objc func backButtonTapped() {
//        backButtonAction?(self.question?.answerChoice)
//    }
//
//    @objc func pageIsFilledOut() -> Bool {
//        if type(of: self.question!) == SignupModels.FreeResponse.self {
//            // try to see if
//            if self.freeResponseBox?.text != nil && !self.freeResponseBox!.text!.isEmpty {
//                self.question?.answerChoice = self.freeResponseBox?.text
////                print(self.question!.question)
////                print(self.answer)
//                return true
//            }
//        } else if let answer = self.question?.answerChoice {
////            print(self.question!.question)
////            print(self.answer)
//            return !answer.isEmpty
//        }
//        return false
////        return self.answer != nil && !self.answer!.isEmpty
//    }
//
//    func setupCollectionView() {
//        self.cardView!.addSubview(self.mcAnswersCollectionView)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        mcAnswersCollectionView.collectionViewLayout = layout
//
//        self.mcAnswersCollectionView.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.height.equalTo(300)
//            make.width.equalToSuperview().multipliedBy(0.8)
//        }
////
////        self.mcAnswersCollectionView.dataSource = self
////        self.mcAnswersCollectionView.delegate = self
//        self.mcAnswersCollectionView.backgroundColor = .white
//        self.mcAnswersCollectionView.clipsToBounds = true
//        self.mcAnswersCollectionView.showsVerticalScrollIndicator = false
//        self.mcAnswersCollectionView.register(SignupCellMultipleChoiceAnswer.self, forCellWithReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier)
//        self.mcAnswersCollectionView.isScrollEnabled = true
//
//    }
