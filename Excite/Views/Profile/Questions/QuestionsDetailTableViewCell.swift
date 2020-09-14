//
//  QuestionsDetailTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/26/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class QuestionsDetailTableViewCell: UITableViewCell {
    static var reuseIdentifier = "QuestionsDetailTableViewCell"
    var stackView = UIStackView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(freeResponse: FreeResponse) {
        self.backgroundColor = .lightGray
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        
        
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        
        cardView.dropShadow()
        
        
        let userLabel = UILabel()
        userLabel.textAlignment = .left
        userLabel.textColor = UIColor.black
        userLabel.text = freeResponse.question
        let userTextField = UILabel()
        userTextField.textColor = UIColor.lightGray
        userTextField.text = freeResponse.answer
        stackView.alignment = .leading
        stackView.addArrangedSubview(userLabel)
        stackView.spacing = 3
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(userTextField)
        cardView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.width.equalToSuperview()
        }
    }

}
