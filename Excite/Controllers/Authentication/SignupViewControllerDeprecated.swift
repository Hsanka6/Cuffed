////
////  SignUpViewController.swift
////  Excite
////
////  Created by Jan Ephraim Nino Tanja on 8/30/20.
////  Copyright © 2020 Haasith Sanka. All rights reserved.
////
//
//import UIKit
//import SnapKit
//import FBSDKLoginKit
//import Firebase
//import FirebaseAuth
//
//// Browse Collections View Controller
//class SignupViewControllerDeprecated: UIViewController {
//    // MARK: - Properties
//    let colors = GradientBackground()
//
//    var currentUser: User?
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    // let nameBox = RoundedRectangleTextField(placeholder: "Your Name")
////    let nameField = UnderlinedTextField(placeholder: "Your Name")
//    var viewModel: SignupViewModel?
//    var numSlides: [SignupCollectionViewCell]?
//    // make questions a dictionary for ease of lookups during autofill between slides and then
//    // when I post it up to Firebase just take all the values and then put that inside of the User's personality questions
//    // with each index in the array being a Question (either MC or FR or the other type)
//    var questions = [String: SignupModels.Question]()
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.viewModel = SignupViewModel(currentUser)
////        if let prefilledName = self.viewModel?.user!.name {
////            nameField.text = prefilledName
////        }
//        self.constructBackground()
//
////        NetworkRequester.getSignupQuestions { (questions) in
////            self.questions = questions
////            self.collectionView.reloadData()
////            self.createCollectionView()
////        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Show the navigation bar on other view controllers
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//
//    // MARK: - Selectors
//    func constructBackground() {
//        let backgroundLayer = self.colors.gradientLayer
//        backgroundLayer.frame = view.frame
//        view.layer.insertSublayer(backgroundLayer, at: 0)
//    }
//
//    // MARK: - Helpers
//
//    func createCollectionView() {
//        self.view.addSubview(collectionView)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        collectionView.collectionViewLayout = layout
//
//        collectionView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(view.safeArea.top)
//            make.bottom.equalTo(view.safeArea.bottom)
//        }
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .none
//        collectionView.clipsToBounds = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(SignupCollectionViewCell.self, forCellWithReuseIdentifier: SignupCollectionViewCell.reuseIdentifier)
//        self.collectionView.isScrollEnabled = false
//    }
//}
//
//extension SignupViewControllerDeprecated: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return questions.count
//    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if (indexPath.row == 3 ) {
//            print("WE HAVE REACHED THE END")
//
//            print("THIS IS THE PROFILE")
//            print(self.currentUser?.profile)
//            NetworkRequester.updateUser(user: currentUser!)
//            let newViewController = MainTabBarController()
//            self.navigationController?.pushViewController(newViewController, animated: false)
//         }
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCollectionViewCell.reuseIdentifier, for: indexPath) as? SignupCollectionViewCell {
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
//         return UICollectionViewCell()
//    }
//
//    // saves the user fields
//    func saveFieldInUserObject(questionId: String, answerChoice: String?) {
//
//        self.questions[questionId]?.answerChoice = answerChoice
//
//        print("QUESTION \(self.questions[questionId]?.question)")
//        print("ANSWER \(self.questions[questionId]?.answerChoice)")
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = self.collectionView.frame.height
//        let width = self.collectionView.frame.width
//        return CGSize(width: width, height: height)
//    }
//
//}
