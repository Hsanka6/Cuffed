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

// font smaller for questions
// priority list
// picking the questions (see figma) freeResponse questions
// update the Ui
// error checking

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
    let colors = GradientBackground()
    
    var currentUser: User?
    var viewModel: SignupViewModel?
    
    let acceptedAttributes=["familyPlans", "vices", "socials", "freeResponse", "personalDetails", "personalityAnswers"]
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // key is what type of attribute it should refer to
    // value is the array of questions for that particular attribute
    var collectionViewCells: [UIView]?
    
    var questions = [ String: [SignupModels.Question] ]()
    
    var questionsFlat = [ (String, SignupModels.Question? )]()
    var profileImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructBackground()
        
        self.collectionViewCells = [UIView]()
        self.viewModel = SignupViewModel(currentUser)
        NetworkRequester.getProfileQuestions { (questions) in
            self.questions = questions
            for (attribute, arrayOfQuestions) in self.questions {
                for question in arrayOfQuestions {
                    self.questionsFlat.append((attribute, question))
                }
            }
            self.questionsFlat.append(("photos", nil))
            self.questionsFlat.append(("completed", nil))
            self.createCollectionView()
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
    
    func constructBackground() {
        let backgroundLayer = self.colors.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
}



extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questionsFlat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier, for: indexPath) as? CardViewCell {
            let currentAttribute = self.questionsFlat[indexPath.row].0
            let currentQuestion = self.questionsFlat[indexPath.row].1
            cell.initialize()
            DispatchQueue.main.async {
                        
                if self.acceptedAttributes.contains(currentAttribute), let question = currentQuestion as? SignupModels.Question {
                    cell.viewPlaceholder!.addSubview(QuestionCardView(for: currentAttribute, question: question, frame: cell.viewPlaceholder!.frame) {(updatedQuestion) in
                        for (attribute, question) in self.questionsFlat {
                            if attribute==currentAttribute && question?.id==updatedQuestion.id {
                                question?.answerChoice = updatedQuestion.answerChoice
                                break
                            }
                        }
                    })
                } else if currentAttribute == "photos" {
                    cell.viewPlaceholder!.addSubview(PhotosCardView(photos: self.profileImages, frame: cell.viewPlaceholder!.frame, currentViewController: self) { (photos) in
                        self.profileImages = photos
                    })
                }
                else if currentAttribute == "completed" {
                    cell.viewPlaceholder!.addSubview(SignupFinishedCardView(frame: cell.viewPlaceholder!.frame ) {
//x
                        var photos = [String]()
                        var socials = [SocialProfile]()
                        var freeResponse = [FreeResponse]()
                        var lat = 0 // dummy value
                        var lon = 0 // dummy value
                        
                        var familyPlans = [MultipleChoiceAnswer]()
                        var vices = [MultipleChoiceAnswer]()
                        var personalityAnswers = [Personality]()
                        for (attribute, questions) in self.questions {
                            if attribute=="socials" {
                                for question in questions {
                                    socials.append(SocialProfile(platform: question.question, link: question.answerChoice!))
                                }
                            } else if attribute=="freeResponse" {
                                for question in questions {
                                    // image empty rn
                                    freeResponse.append(FreeResponse(question: question.question, answer: question.answerChoice ?? "", image: ""))
                                }
                            } else if attribute=="familyPlans" {
                                for question in questions {
                                    guard let mcFamilyPlanQuestion = question as? SignupModels.MultipleChoice else {continue}
                                    familyPlans.append(MultipleChoiceAnswer(answer: mcFamilyPlanQuestion.answerChoice!, question: mcFamilyPlanQuestion.question, answerChoices: mcFamilyPlanQuestion.answers, short: mcFamilyPlanQuestion.short))
                                }
                            } else if attribute=="vices" {
                                for question in questions {
                                    guard let mcViceQuestion = question as? SignupModels.MultipleChoice else {continue}
                                    vices.append(MultipleChoiceAnswer(answer: mcViceQuestion.answerChoice!, question: mcViceQuestion.question, answerChoices: mcViceQuestion.answers, short: mcViceQuestion.short))
                                }
                            } else if attribute=="personalityAnswers" {
                                for question in questions {
                                    guard let mcPersonalityQuestion = question as? SignupModels.MultipleChoice else {continue}
                                    personalityAnswers.append(Personality(answer: mcPersonalityQuestion.answerChoice!, question: mcPersonalityQuestion.question, answerChoices: mcPersonalityQuestion.answers, short: mcPersonalityQuestion.short, topValue: "", bottomValue: ""))
                                }
                            }
                        }
                        
                        // wait for pictures to upload so we can grab the URLs
                        
//                        NetworkRequester.updateUserPictures(self.viewModel!.user!.userId, images: self.profileImages, completion: {
                        let uploadedPhotoURLs: [String] = NetworkRequester.updateUserPictures(self.viewModel!.user!.userId, images: self.profileImages)
                        for photoURL in uploadedPhotoURLs {
                            photos.append(photoURL)
                        }
                        let personalDetails = PersonalDetails(fullName: self.viewModel!.user!.name , age: 23, height: "", gender: GenderType.MALE, ethnicity: "Filipino", location: "San Diego", jobTitle: "SWE", company: "Two Sigma")
                        self.viewModel?.user?.profile = Profile(photos: photos,
                                                               socials: socials,
                                                               freeResponse: freeResponse,
                                                               lat: Double(lat),
                                                               lon: Double(lon),
                                                               personalDetails: personalDetails,
                                                               familyPlans: familyPlans,
                                                               vices: vices,
                                                               personalityAnswers: personalityAnswers)
                        NetworkRequester.updateUser(user: self.viewModel!.user!) {
                            let newViewController = MainTabBarController()
                            newViewController.user = self.viewModel?.user
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                    })
                }
            }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.height
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: height)
    }
}
