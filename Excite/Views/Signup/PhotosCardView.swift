//
//  CardViewPhotos.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit


class PhotosCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cardView = UIView()
        self.addSubview(cardView)
        cardView.backgroundColor = .black
        cardView.snp.makeConstraints { (make) in
            make.height.equalTo(500)
            make.width.equalTo(UIScreen.main.bounds.width - 60)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(140)
        }
        
        addBehavior()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func addBehavior() {
        print("INSIDE OF PHOTOS CARD VIEW")
    }
//    static var reuseIdentifier = "signupPhotos"
//    var question: SignupModels.Question?
//
//    var profile: Profile?
//    var index: Int?
//
//    // keep track of the background card view
//    var cardView: UIView?
//
//    let mcAnswersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    // index path of current answer of the
//    var selectedIndexPath: IndexPath?
//
//    var freeResponseBox: UITextField?
//
//    // this isn't working as I intended
//    var nextButtonAction : ((_ answerChoice: String?)->())?
//    var backButtonAction : ((_ answerChoice: String?)->())?
//
////    func initialize(question: SignupModels.Question, questionNum: Int, user: User) {
//    func initialize(questionId: String, questionNum: Int, question: SignupModels.Question) {
//        self.question = question
//        let cardView = UIView()
//        cardView.backgroundColor = .white
//        cardView.layer.cornerRadius = 15
//
//        self.addSubview(cardView)
//        cardView.snp.makeConstraints { (make) in
//            make.height.equalTo(600)
//            make.width.equalTo(UIScreen.main.bounds.width - 80)
//            make.center.equalToSuperview()
//        }
//        cardView.dropShadow()
//        self.cardView = cardView
//        self.cardView?.setupToHideKeyboardOnTapOnView()
//
//        let questionLabel = UILabel()
//        questionLabel.textAlignment = .center
//        questionLabel.numberOfLines = 3
//        questionLabel.textColor = UIColor.black
//        questionLabel.text = "Photos"
//        questionLabel.font = UIFont.systemFont(ofSize: 25)
//        cardView.addSubview(questionLabel)
//        questionLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(15)
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//        }
//    }
}
