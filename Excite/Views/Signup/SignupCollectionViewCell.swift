//
//  SignupCollectionViewCell.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/14/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

// Decouple Business Logic and View here
// If the question is a MC, then build the underlying profile with the selected answer. cannot move on until one is selected
// If the question is a FR, then build the underlying profile with the string of the freeResponseAnswer UITextField.
// at the very end, do a post request using the NetworkRequesterAPI.


// Haasith's suggestions:
// back button
// preserving the fields when you switch cells

// (For the Select types of profile questions page)
// BrowseQuestionsViewController (to show cards) (pass in array of Strings AKA questions)
// Pass any collection of questions

// character limit (30-40)

// for next time
// Caching
// Consolidate some code before we move forward

// AnswerQuestionViewController


// TODO:
// 1. DONT MOVE ON UNTIL AN ANSWER IS SELECTED
// 2. BUILD THE USER PROFILE
// 3. SUBMIT ALL THE ANSWERS VIA FIREBASE AT THE END
// 4.

// 1 picutres
// 2 firebase
// 3 profile questions: https://www.figma.com/file/yktAvueZgO6tP9uBNoyjmN/Excite?node-id=0%3A1
// 4
//
class SignupCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    static var reuseIdentifier = "signup"
    var question: SignupModels.Question?
    
    var profile: Profile?
    var index: Int?
    var viewController: UIViewController?
    
    // keep track of the background card view
    var cardView: UIView?
    
    let mcAnswersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // index path of current answer of the 
    var selectedIndexPath: IndexPath?
    var answer: String?
    
    var freeResponseBox: UITextField?
    
    var nextButtonAction : (()->())?
    
    func initialize(question: SignupModels.Question) {
        self.question = question
        print("THIS IS THE CURRENT QUESTION: ")
        print(self.question?.question)
        self.viewController?.setupToHideKeyboardOnTapOnView()
        
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
        
        // nextButton.addTarget(self, action: #selector(self.nextPageButtonClicked), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        renderQuestion()
    }
    
    func renderQuestion() {
        if type(of: self.question!) == SignupModels.FreeResponse.self {
            let freeResponseAnswer: UITextField = {
                let freeResponseAnswer = UITextField()
                freeResponseAnswer.textColor       = .black
                freeResponseAnswer.textAlignment   = .center
                freeResponseAnswer.textColor       = .black
                freeResponseAnswer.font            = UIFont.systemFont(ofSize: 30)
                freeResponseAnswer.attributedPlaceholder = NSAttributedString(string: self.question!.short, attributes: [.foregroundColor : UIColor.lightGray])
                return freeResponseAnswer
            }()
            self.cardView!.addSubview(freeResponseAnswer)
            freeResponseAnswer.snp.makeConstraints { (make) in
                make.width.equalTo(300)
                make.height.equalTo(80)
                make.center.equalToSuperview()
            }
            self.answer = freeResponseAnswer.text
            self.freeResponseBox = freeResponseAnswer
            self.freeResponseBox!.delegate = self
//            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: cardview.self, action: #selector(dDismissKeyboard))
//            self.freeResponseBox!.addGestureRecognizer(tap)
        } else if type(of: self.question!) == SignupModels.MultipleChoice.self {
            // guard let answerChoices = self.question! as! SignupModels.MultipleChoice as SignupModels.MultipleChoice? else {return}
            setupCollectionView()
        } else {
            // TableView
            //
            print("NOT SUPPOSED TO HAPPEN")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.answer=self.freeResponseBox!.text
        self.freeResponseBox!.endEditing(true)
        return false
    }
    
    @objc func nextButtonTapped() {
        if pageIsFilledOut() {
            nextButtonAction?()
        }
    }
    
    func updateProfile() {
        self.profile?.personalityAnswers
    }
    
    @objc func pageIsFilledOut() -> Bool {
        guard let answer = self.answer else {
            return false
        }
        print("THIS IS ANSWER: \(answer)")
        return !answer.isEmpty
//        return self.answer != nil && !self.answer!.isEmpty
    }
    
    func setupCollectionView() {
        self.cardView!.addSubview(self.mcAnswersCollectionView)
        
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
        self.mcAnswersCollectionView.register(SignupCellMultipleChoiceAnswer.self, forCellWithReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier)
        self.mcAnswersCollectionView.isScrollEnabled = true
        
    }
}

extension SignupCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return 0}
//        print("CALLED INSIDE OF numberOfItemsInSection")
//        for answer in answerChoices.answer {
//            print(answer)
//        }
        return answerChoices.answer.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier, for: indexPath) as? SignupCellMultipleChoiceAnswer {
            guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return UICollectionViewCell()}
//            print("CALLED INSIDE OF cellForItemAt")
//            print(self.question?.question)
//            for answer in answerChoices.answer {
//                print(answer)
//            }
            cell.initialize(answer: answerChoices.answer[indexPath.row])
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
        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? SignupCellMultipleChoiceAnswer {
            
            if self.selectedIndexPath == indexPath {
                self.collectionView(mcAnswersCollectionView, didDeselectItemAt: indexPath)
                return
            }
            
            cell.cellView?.backgroundColor = .green
            //cell.contentView.backgroundColor = UIColor.green
            // cell.cellView!.backgroundColor = .green
            self.answer = cell.answer
            
        }
        self.selectedIndexPath = indexPath
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = self.mcAnswersCollectionView.cellForItem(at: indexPath) as? SignupCellMultipleChoiceAnswer {
            cell.cellView?.backgroundColor = .white
            //cell.contentView.backgroundColor = UIColor.green
            // cell.cellView!.backgroundColor = .green
        }
        self.selectedIndexPath = nil
    }
}
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissTheKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissTheKeyboard()
    {
        view.endEditing(true)
    }
}
