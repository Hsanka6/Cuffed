//
//  UserDetailTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/18/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    static var reuseIdentifier = "userDetail"
    var stackView = UIStackView()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func initialize() {
        let userLabel = UILabel()
        userLabel.textAlignment = .left
        userLabel.textColor = UIColor.black
        userLabel.text = "name"
        let userTextField = UITextField()
        userTextField.placeholder = "placeholder"
        userTextField.backgroundColor = UIColor.orange
        stackView.alignment = .leading
        stackView.addArrangedSubview(userLabel)
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(userTextField)
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
