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
    var stackView: UIStackView?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize(freeResponse: FreeResponse) {
        let stackView = UIStackView()
              
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        
//        cardView.layer.shadowColor = UIColor.gray.cgColor
//        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        cardView.layer.shadowRadius = 12.0
//        cardView.layer.shadowOpacity = 0.7

        
        self.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
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
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        
        self.stackView = stackView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.removeFromSuperview()
        stackView = nil
   }

}
