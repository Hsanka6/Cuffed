//
//  SmallAttributeCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 11/11/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class SmallAttributeCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "SmallAttributeCollectionViewCell"
    var stackView: UIStackView?
    func initialize(mcAnswer: MultipleChoiceAnswer) {
       let stackView = UIStackView()
             
       let cardView = UIView()
       cardView.backgroundColor = .white
       cardView.layer.cornerRadius = 15
       
       self.addSubview(cardView)
       cardView.snp.makeConstraints { (make) in
           make.top.equalTo(10)
        make.width.height.equalToSuperview()
        
           make.bottom.equalTo(-10)
       }
       cardView.dropShadow()
       
        let image = UIImageView()
        image.image = UIImage(named: "black-user")
        
        
        
       let userLabel = UILabel()
       userLabel.textAlignment = .left
       userLabel.textColor = UIColor.black
        if mcAnswer.answer == "Prefer not to say" {
            userLabel.text = "Hidden"
        }
        else {
        userLabel.text = mcAnswer.answer
        }
       userLabel.numberOfLines = 1
       userLabel.font = UIFont.systemFont(ofSize: 12.0)
       
        stackView.alignment = .center
       stackView.addArrangedSubview(image)
       stackView.spacing = 0
       stackView.axis = .vertical
       stackView.distribution = .fillProportionally
       stackView.addArrangedSubview(userLabel)
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
