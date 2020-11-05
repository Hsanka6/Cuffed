//
//  CardView.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

// generic type for the SignupViewController that can hold a UI View
// for either a question or for a photos cell

//

class CardViewCell: UICollectionViewCell {
    static var reuseIdentifier: String = "signup-cell"
    
//    var nextButtonAction : ((_ answerChoice: String?)->())?
//    var backButtonAction : ((_ answerChoice: String?)->())?
    
    var nextButtonAction : (()->())?
    var backButtonAction : (()->())?
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//    }
    var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        cardView.dropShadow()
        return cardView
    }()
    
    var viewPlaceholder: UIView = {
        let viewPlaceholder = UIView()
        return viewPlaceholder
    }()
    
    // takes in a UIView. This is what will be rendered to the card!
    func initialize() {
//        let cardView = UIView()
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.height.equalTo(600)
            make.width.equalTo(UIScreen.main.bounds.width - 60)
            make.center.equalToSuperview()
        }

        cardView.addSubview(viewPlaceholder)
        viewPlaceholder.backgroundColor = .green
        viewPlaceholder.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(80)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
//        cardView.backgroundColor = .white
//        cardView.layer.cornerRadius = 15
//        cardView.snp.makeConstraints { (make) in
//            make.height.equalTo(600)
//            make.width.equalTo(UIScreen.main.bounds.width - 60)
//            make.center.equalToSuperview()
//        }
//        cardView.dropShadow()
        
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
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped(_:)), for: .touchUpInside)
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = .blue
        backButton.tintColor = .white
        backButton.layer.cornerRadius = 15
        cardView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(-10)
        }
        backButton.isUserInteractionEnabled = true
        backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
        
//        cardView.addSubview(mainView)
    }
    
    @objc func nextButtonTapped(_ sender: AnyObject) {
            nextButtonAction?()
    }

    @objc func backButtonTapped(_ sender: AnyObject) {
        backButtonAction?()
    }
}
