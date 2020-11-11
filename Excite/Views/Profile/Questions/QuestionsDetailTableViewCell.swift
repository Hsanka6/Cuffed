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
        let userTextField = UILabel()
        userTextField.textColor = UIColor.lightGray
        userTextField.text = freeResponse.answer
        userTextField.numberOfLines = 2
        userTextField.font = UIFont.systemFont(ofSize: 15.0)
        
        stackView.alignment = .fill
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
