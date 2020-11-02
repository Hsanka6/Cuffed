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
//        
//        // questions.append(SignupModels.Question(id: "", question: "", isMandatory: false, isHidden: true, short: "dummy"))
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
//        if (indexPath.row == 3 ) { // questions.count - 1) {
//            // this is the point where we push up the profile to firebase
//            // unwrap the dictionary here, save the user, and then push to firebase
//            print("WE HAVE REACHED THE END")
////            dump(self.questions)
//            
//            // TODO: Let's edit the models
//            // there will be multiple fields inside of the Profile Model
//            // that will hold the same things
//            // vices and familyPlans how will we distinguish those
//            // if they'er all put in the same place? in firebase
////            self.currentUser?.profile = Profile(photos: ["temp"], socials: [SocialProfile()], freeResponse: [FreeResponse()], lat: 37.0, lon: 37.0, personalDetails: , familyPlans: [MultipleChoiceAnswer], vices: <#T##[MultipleChoiceAnswer]#>, personalityAnswers: <#T##[Personality]#>, signupQuestions: Array(self.questions.values))
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
//
//// TODO:
//
//// currently for the collectionView each card is a question of either FR or MC
//// but then what type of card will the pictures card be?
//
//// So essentially there will need to be 3 types of inputs for each card
//// a FR card
//// a MC card
//// (both of which I pull from Firebase directly and render those with one network call)
//// Then I'm going to need to gather the pictures on one card as well
//// which will be its own complete type
//
//
//// So I'm thinking instead of each collectionViewCell accepting a question,
//// It can either render a question or a form prompting you to input images
//
//// so in order to render each cell inside of the collectionViewcell
//// we are going to need an array that has a generic type to provide for MC, FR, or
//// a form input for a collection of pictures
//
//
//// or what if we just passed a view inside of each cell? Instead of a question
//// so we didn't have to make a generic type for MC FR and group of inputs for pictures
//
//// So generalize the Cell input not necessarily make a generic input for the
//
//
//
//// TODO:
//
//// Secondly how do we distinguish inside of the models which question is what type of question?
//
//// what if we inside of a collection grabbed 3 documents
//// Each document is going to be:
//// Personal Details, Vices, Family Plans, Metadata etc.
//
//// into their own objects under the Profile model
//
//// when constructing the object
//// check what type of question it is
//// Probably include a field inside of it as well (QuestionType)
//// or with one Network Call you can grab all of them and then the dictionary would be something like
//// Document.ID() is a key and [ document.getData() ] is the value
////
//
//// FINAL TODO: -----------------------------------
//// so I would render all of the cells inside of collectionViewCEll first
//// then register the input for photos last
//
//// two types of cells
//// one for individual questions
//// the other for group of questions
//// those are two children of a generic type
//
//// that generic type will be the one that shows up inside of the SignupViewController
//
//// the way we will identify what types of questions there are is that inside of this file
//// there will be a dictonary [ String : [Question] ]
//// where the key will be from a network call
//// QuestionType (this will be documentID)
//// [Question] Generic question object that I already have
//
//// ID the questions as well so any time you want to edit a specific one then you can
//
//// then we will have a generic collectionViewCell
//// that renders views
//// which can take either an individual question
//// or one that renders photo inputs
//
//// so the collectionViewCell will have a generic card inside of it
//// the first cards will be constructed from the questions from the collection inside of the dictionary`
//// then at the end we will have one individual custom cell that has the photo inputs
//
//// -------------------------------------------------
