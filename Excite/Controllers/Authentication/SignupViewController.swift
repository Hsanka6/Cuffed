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
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Welcome!"
        curr.font = UIFont(name: "Barcelony", size: 50)
        curr.textColor = .white
        return curr
    }()
    
    var currentUser: User?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // let nameBox = RoundedRectangleTextField(placeholder: "Your Name")
//    let nameField = UnderlinedTextField(placeholder: "Your Name")
    var viewModel: SignupViewModel?
    var numSlides: [SignupCollectionViewCell]?
    var questions = [SignupModels.Question]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignupViewModel(currentUser)
//        if let prefilledName = self.viewModel?.user!.name {
//            nameField.text = prefilledName
//        }
        self.constructBackground()
        
        // get questions here
        NetworkRequester.getSignupQuestions { (questions) in
            self.questions = questions
            self.collectionView.reloadData()
            self.createCollectionView()
        }
        questions.append(SignupModels.Question(question: "", isMandatory: false, isHidden: true, short: "dummy"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // we use this function to indentify the frame width and height here, these values are only available after viewDidLayoutSubviews starts to run.
//        nameField.underlined(frameWidth: CGFloat(nameField.frame.width),
//                             frameHeight: CGFloat(nameField.frame.height))
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
        collectionView.register(SignupCollectionViewCell.self, forCellWithReuseIdentifier: SignupCollectionViewCell.reuseIdentifier)
        self.collectionView.isScrollEnabled = false
        
//        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally,  animated: true)
        
    }
}

extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // last view here
         if (indexPath.row == questions.count - 1 ) {
            let newViewController = MainTabBarController()
            self.navigationController?.pushViewController(newViewController, animated: false)
         }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("YEET \(indexPath.row)")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCollectionViewCell.reuseIdentifier, for: indexPath) as? SignupCollectionViewCell {
            print("WHEN SHOULD I RENDER THE NEW VIEW CONTROLLER: \(indexPath.row)")
            cell.initialize(question: questions[indexPath.row], parentCollectionView: self.collectionView, numSize: questions.count)
         return cell
         }
         return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.height
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
}
