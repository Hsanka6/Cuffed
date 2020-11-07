//
//  SignUpViewController.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/30/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

extension UIView {
    var safeArea: ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
}

extension UICollectionView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

class SignupViewController: UIViewController {
    // MARK: - Properties
    let colors = GradientBackground()
    
    var currentUser: User?
    var viewModel: SignupViewModel?
    let acceptedAttributes=["familyPlans", "vices"]
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // key is what type of attribute it should refer to
    // value is the array of questions for that particular attribute
    var collectionViewCells: [UIView]?
    
    var questions = [ String: [SignupModels.Question] ]()
    
    var questionsFlat = [ (String, SignupModels.Question? )]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructBackground()
        
        self.collectionViewCells = [UIView]()
        self.viewModel = SignupViewModel(currentUser)
        self.createCollectionView()
        NetworkRequester.getProfileQuestions { (questions) in
            self.questions = questions
            // go through all of the questions
            
            for (attribute, arrayOfQuestions) in self.questions {
                for question in arrayOfQuestions {
                    self.questionsFlat.append((attribute, question))
                }
            }
//            self.collectionViewCells?.append(PhotosCardView(frame: self.view.frame))
            // pictures slide appended to last
            self.questionsFlat.append(("photos", nil))
            self.collectionView.reloadData()
        }
        
    }
    
    func createCollectionView() {
        self.view.addSubview(collectionView)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout

        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeArea.top)
            make.bottom.equalTo(view.safeArea.bottom)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Selectors
    func constructBackground() {
        let backgroundLayer = self.colors.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    // MARK: - Helpers
}



extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questionsFlat.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.questionsFlat.count - 1 ) {
//            NetworkRequester.updateUser(user: currentUser!)
//            let newViewController = MainTabBarController()
//            self.navigationController?.pushViewController(newViewController, animated: false)
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier, for: indexPath) as? CardViewCell {
            let currentAttribute = self.questionsFlat[indexPath.row].0
            let currentQuestion = self.questionsFlat[indexPath.row].1
            // also load which attribute the question will add to
            cell.initialize()
            DispatchQueue.main.async {
                        
                if self.acceptedAttributes.contains(currentAttribute), let question = currentQuestion as? SignupModels.Question {
                    cell.viewPlaceholder!.addSubview(QuestionCardView(for: currentAttribute, question: question, frame: cell.viewPlaceholder!.frame) {(updatedQuestion) in
                        // TODO
                        // I receive the question with the updated answer choice
                        // I now need to save it by going through the array and matching the question ID
                        // and updating that value with the updatedQuestion's answer choice
                        for (attribute, question) in self.questionsFlat {
                            if attribute==currentAttribute && question?.id==updatedQuestion.id {
                                print("OVERWRITING QUESTION \(question?.question)")
                                question?.answerChoice = updatedQuestion.answerChoice
                                break
                            }
                        }
                        print(updatedQuestion.answerChoice)
                    })
                } else if currentAttribute == "photos" {
//                    cell.addSubview(PhotosCardView(frame: cell.viewPlaceholder.frame))
                    cell.viewPlaceholder!.addSubview(PhotosCardView(frame: cell.viewPlaceholder!.frame))
                }
            }
            // find a way to save the answers from the UIView
            cell.nextButtonAction = {
                var visibleRect    = CGRect()
                visibleRect.origin = self.collectionView.contentOffset
                visibleRect.size   = self.collectionView.bounds.size
                let visiblePoint   = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

                guard let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
                let nextIndexPath = IndexPath(item: visibleIndexPath.row + 1, section: visibleIndexPath.section)
                if nextIndexPath.row < self.questionsFlat.count {
                    collectionView.scrollToItem(at: nextIndexPath, at: .right, animated: true)
                }
            }
            cell.backButtonAction = {
                var visibleRect    = CGRect()
                visibleRect.origin = self.collectionView.contentOffset
                visibleRect.size   = self.collectionView.bounds.size
                let visiblePoint   = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

                guard let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
                let previousIndexPath = IndexPath(item: visibleIndexPath.row - 1, section: visibleIndexPath.section)
                
                if previousIndexPath.row >= 0 {
                    collectionView.scrollToItem(at: previousIndexPath, at: .left, animated: true)
                }
            }
            return cell
        }
        return UICollectionViewCell()

    }

    func saveAnswer() {
        print("SAVING ANSWER")
    }
    // saves the user fields
//    func saveFieldInUserObject(questionId: String, answerChoice: String?) {
//
//        self.questions[questionId]?.answerChoice = answerChoice
//
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.height
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: height)
    }

}



//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells[indexPath.row].reuseIdentifier, for: indexPath) as? CardViewQuestionCell {
//
//        }
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier, for: indexPath) as? CardViewPhotosCell {
//
//            cell.initialize(questionId: Array(questions)[indexPath.row].key, questionNum: indexPath.row, question: Array(questions)[indexPath.row].value)
//
//            cell.nextButtonAction = {
//                (answerChoice) in
//                let indexPath = self.collectionView.indexPathsForVisibleItems.first.flatMap({
//                    IndexPath(item: $0.row + 1, section: $0.section)
//                })
//                if indexPath!.row < self.questions.count {
//                    self.collectionView.scrollToItem(at: indexPath!, at: .right, animated: true)
//                } else {
//                }
//                self.saveFieldInUserObject(questionId: Array(self.questions)[indexPath!.row].key, answerChoice: answerChoice)
//            }
//            cell.backButtonAction = {
//                (answerChoice) in
//                let indexPath = self.collectionView.indexPathsForVisibleItems.first.flatMap({
//                    IndexPath(item: $0.row - 1, section: $0.section)
//                })
//
//                if indexPath!.row >= 0 {
//                    self.collectionView.scrollToItem(at: indexPath!, at: .left, animated: true)
//                } else {
//                }
//                self.saveFieldInUserObject(questionId: Array(self.questions)[indexPath!.row].key, answerChoice: answerChoice)
//            }
//
//         return cell
//         }


// FINAL TODO: -----------------------------------
// so I would render all of the cells inside of collectionViewCEll first
// then register the input for photos last

// two types of cells
// one for individual questions
// the other for group of questions
// those are two children of a generic type

// that generic type will be the one that shows up inside of the SignupViewController

// the way we will identify what types of questions there are is that inside of this file
// there will be a dictonary [ String : [Question] ]
// where the key will be from a network call
// QuestionType (this will be documentID)
// [Question] Generic question object that I already have

// ID the questions as well so any time you want to edit a specific one then you can

// then we will have a generic collectionViewCell
// that renders views
// which can take either an individual question
// or one that renders photo inputs

// so the collectionViewCell will have a generic card inside of it
// the first cards will be constructed from the questions from the collection inside of the dictionary`
// then at the end we will have one individual custom cell that has the photo inputs

// -------------------------------------------------
