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
    
    let mcAnswersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var answer: String?
    
    var selectedIndexPath: IndexPath?
    
    
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
        renderQuestion()
    }
    
    func renderQuestion() {
        // this is goign to have a selector to an fillOutAnswer problem
        if type(of: self.question!) == SignupModels.FreeResponse.self {
            print("FR----------")
            let answerBox: UITextField = {
                let answerBox = UITextField()
                answerBox.textColor       = .black
                answerBox.textAlignment   = .center
                answerBox.textColor       = .black
                answerBox.font            = UIFont.systemFont(ofSize: 30)
                answerBox.attributedPlaceholder = NSAttributedString(string: self.question!.short, attributes: [.foregroundColor : UIColor.lightGray])
                return answerBox
            }()
            self.cardView!.addSubview(answerBox)
            answerBox.snp.makeConstraints { (make) in
                make.width.equalTo(300)
                make.height.equalTo(80)
                make.center.equalToSuperview()
            }
//            let answerBox = UITextField()
//            answerBox.backgroundColor = .lightGray
//            answerBox.tintColor = .white
//            answerBox.layer.cornerRadius = 5
//            answerBox.attributedPlaceholder = NSAttributedString(string:"Enter Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//            self.cardView!.addSubview(answerBox)
//            answerBox.snp.makeConstraints { (make) in
//                make.width.equalTo(200)
//                make.height.equalTo(80)
//                make.center.equalToSuperview()
//            }
//
//
//            answerBox.addTarget(self, action: #selector(tester), for: .touchDown)
        }
        else if type(of: self.question!) == SignupModels.MultipleChoice.self {
            // guard let answerChoices = self.question! as! SignupModels.MultipleChoice as SignupModels.MultipleChoice? else {return}
            setupCollectionView()
        }
        else {
            print("NOT SUPPOSED TO HAPPEN")
        }
    }
    
    @objc func tester(textField: UITextField) {
        print("myTargetFunction")
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
        print("INDEX PATH IS \(indexPath!.row)")
        print("NUMSIZE IS \(numSize!)")
        if indexPath!.row < numSize! {
            self.collectionView.scrollToItem(at: indexPath!, at: .right, animated: true)
        } else {
            print("Can't scroll anymore")
        }
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
        self.mcAnswersCollectionView.clipsToBounds = false
        self.mcAnswersCollectionView.showsVerticalScrollIndicator = true
        self.mcAnswersCollectionView.register(SignupCellMultipleChoiceAnswer.self, forCellWithReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier)
        self.mcAnswersCollectionView.isScrollEnabled = true
        
//        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally,  animated: true)
    }
}


extension SignupCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return 0}
        return answerChoices.answer.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCellMultipleChoiceAnswer.reuseIdentifier, for: indexPath) as? SignupCellMultipleChoiceAnswer {
            guard let answerChoices = self.question as? SignupModels.MultipleChoice else {return UICollectionViewCell()}
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
            cell.cellView?.backgroundColor = .green
            //cell.contentView.backgroundColor = UIColor.green
            // cell.cellView!.backgroundColor = .green
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
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = CellWidth * CellCount
//        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
}
