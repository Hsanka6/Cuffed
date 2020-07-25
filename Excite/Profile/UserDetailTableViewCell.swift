//
//  UserDetailTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/18/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import Foundation

class UserDetailTableViewCell: UITableViewCell {
    static var reuseIdentifier = "userDetail"
    enum Details: String, CaseIterable {
        case fullName = "Full Name"
        case age = "Age"
        case height = "Height"
        case gender = "Gender"
        case ethnicity = "Ethnicity"
        case location = "Location"
        case company = "Company"
        case jobTitle = "Job Title"
    }
    var stackView = UIStackView()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func initialize(model: PersonalDetails, index: Int) {
        let userLabel = UILabel()
        userLabel.textAlignment = .left
        userLabel.textColor = UIColor.black
        userLabel.text = populate(model: model, index: index).0
        let userTextField = UITextField()
        userTextField.placeholder = populate(model: model, index: index).1
        userTextField.textColor = UIColor.lightGray
        stackView.alignment = .leading
        stackView.addArrangedSubview(userLabel)
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(userTextField)
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }

    func populate(model: PersonalDetails, index: Int) -> (String, String) {
        print(index)
        let details = Details.allCases[index]
        switch details {
        case .fullName:
            return (details.rawValue, model.fullName)
        case .age:
            return (details.rawValue, String(model.age))
        case .height:
            return (details.rawValue, Helpers().getHeightInInches(inches: model.height))
        case .gender:
            return (details.rawValue, model.gender.rawValue)
        case .ethnicity:
            return (details.rawValue, model.ethnicity)
        case .location:
            return (details.rawValue, model.location)
        case .company:
            return (details.rawValue, model.company)
        case .jobTitle:
            return (details.rawValue, model.jobTitle)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
