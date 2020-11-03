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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // key is what type of attribute it should refer to
    // value is the array of questions for that particular attribute
    var collectionViewCells: [UIView]?
    
    var questions = [ String: [SignupModels.Question] ]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructBackground()
        
        self.collectionViewCells = [UIView]()
        self.viewModel = SignupViewModel(currentUser)
        
        NetworkRequester.getProfileQuestions { (questions) in
            self.questions = questions
            // go through all of the questions
            for (attribute, arrayOfQuestions) in self.questions {
                for question in arrayOfQuestions {
                    self.collectionViewCells?.append(QuestionCardView(for: attribute, question: question, frame: self.view.frame))
                }
            }
            // this will be the last element inside of the thing
            self.collectionViewCells?.append(PhotosCardView(frame: self.view.frame))
            self.collectionView.reloadData()
            self.createCollectionView()
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
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.reuseIdentifier)
//        collectionView.isScrollEnabled = false
        collectionView.isScrollEnabled = true
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
        return self.collectionViewCells!.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.collectionViewCells!.count - 1 ) {
            print("WE HAVE REACHED THE END")
            print(self.currentUser?.profile)
//            NetworkRequester.updateUser(user: currentUser!)
//            let newViewController = MainTabBarController()
//            self.navigationController?.pushViewController(newViewController, animated: false)
         }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier, for: indexPath) as? CardViewCell {
            indexPath.row
            print(self.collectionViewCells?.count)
            cell.initialize(mainView: collectionViewCells![indexPath.row])
            return cell
        }
        return UICollectionViewCell()
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
//                    print("Can't scroll anymore")
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
//                    print("Can't scroll anymore")
//                }
//                self.saveFieldInUserObject(questionId: Array(self.questions)[indexPath!.row].key, answerChoice: answerChoice)
//            }
//
//         return cell
//         }
    }

    // saves the user fields
//    func saveFieldInUserObject(questionId: String, answerChoice: String?) {
//
//        self.questions[questionId]?.answerChoice = answerChoice
//
//        print("QUESTION \(self.questions[questionId]?.question)")
//        print("ANSWER \(self.questions[questionId]?.answerChoice)")
//
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.height
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: height)
    }

}


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
