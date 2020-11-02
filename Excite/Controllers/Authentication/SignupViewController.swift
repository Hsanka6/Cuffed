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

// Browse Collections View Controller
class SignupViewController: UIViewController {
    // MARK: - Properties
    let colors = GradientBackground()
    
    var currentUser: User?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var viewModel: SignupViewModel?
    var cells: [CardViewCell]?
    var questions = [ String: [SignupModels.Question] ]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SignupViewModel(currentUser)
        self.constructBackground()
        
        NetworkRequester.getProfileQuestions { (questions) in
            self.questions = questions
        }
        
        
        // render a cell for each question
        // and then add the CardViewPhotosCell at the end
        
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
