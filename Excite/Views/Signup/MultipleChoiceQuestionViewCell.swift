//
//  MultipleChoiceQuestionViewCell.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/5/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceQuestionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "SignupCellMultipleChoiceAnswer"
    var answer: String?
    var cellView: UIView?
    var answerLabel: UILabel?
    func initialize(answer: String) {
        let cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.borderWidth = 2
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        cellView.layer.cornerRadius = 5
        
        self.addSubview(cellView)
        self.cellView = cellView
        
        cellView.snp.makeConstraints { (make) in
        make.height.equalTo(50)
        make.width.equalToSuperview()
        make.center.equalToSuperview()
        }
        
        self.answer = answer
        let answerLabel = UILabel()
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 3
        answerLabel.textColor = UIColor.black
        answerLabel.text = answer
        answerLabel.font = UIFont.systemFont(ofSize: 25)
        cellView.addSubview(answerLabel)
        answerLabel.snp.makeConstraints { (make) in
        make.height.equalToSuperview()
        make.width.equalToSuperview()
        make.center.equalToSuperview()
        }
        self.answerLabel = answerLabel
    }
}
