//
//  ProfileQuestionCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 11/4/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileQuestionCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "ProfileQuestionsCollectionTableViewCell"
    var stackView: UIStackView?
    func initialize(freeResponse: FreeResponse) {
       let stackView = UIStackView()
             
       let cardView = UIView()
       cardView.backgroundColor = .white
       cardView.layer.cornerRadius = 15
       
       self.addSubview(cardView)
       cardView.snp.makeConstraints { (make) in
           make.top.equalTo(10)
           make.width.equalToSuperview()
           make.bottom.equalTo(-10)
       }
       cardView.dropShadow()
       
       let userLabel = UILabel()
       userLabel.textAlignment = .left
       userLabel.textColor = UIColor.black
       userLabel.text = freeResponse.question
       userLabel.numberOfLines = 1
       let userTextField = UILabel()
       userTextField.textColor = UIColor.lightGray
       userTextField.text = freeResponse.answer
       
       stackView.alignment = .leading
       stackView.addArrangedSubview(userLabel)
       stackView.spacing = 2
       stackView.axis = .vertical
       stackView.distribution = .fillProportionally
       stackView.addArrangedSubview(userTextField)
       cardView.addSubview(stackView)
       stackView.snp.makeConstraints { (make) in
           make.top.equalTo(8)
           make.bottom.equalTo(-8)
           make.left.equalTo(15)
           make.right.equalTo(-15)
       }
       
       self.stackView = stackView
    }


}
