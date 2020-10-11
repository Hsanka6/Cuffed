//
//  MultipleChoiceCellTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/23/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MultipleChoiceCellTableViewCell: UITableViewCell {
    static var reuseIdentifier = "MultipleChoiceCellTableViewCell"
    var stackView: UIStackView?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize(question: MultipleChoiceAnswer) {
        let stackView = UIStackView()
        let userLabel = UILabel()
        userLabel.textAlignment = .left
        userLabel.textColor = UIColor.black
        userLabel.text = question.short
        let userTextField = UITextField()
        userTextField.placeholder = question.answer
        userTextField.textColor = UIColor.lightGray
        stackView.alignment = .leading
        stackView.addArrangedSubview(userLabel)
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(userTextField)
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        self.stackView = stackView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.removeFromSuperview()
        stackView = nil
    }
}
