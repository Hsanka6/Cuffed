//
//  MultipleChoiceCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 9/4/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MultipleChoiceCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "multipleChoice"
    public var button = MultipleChoiceButton()
    var selectedChoice: String?
    func initialize(answerChoice: String, selectedChoice: String) {
        self.selectedChoice = selectedChoice
        button.setupButton()
        self.addSubview(button)
        button.setTitle(answerChoice, for: .normal)
        //let buttonTitleSize = answerChoice.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25 + 1)])

        button.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
        //button.setState(isCurrentAnswer: selectedChoice)
        button.isUserInteractionEnabled = false

    }


    
}
