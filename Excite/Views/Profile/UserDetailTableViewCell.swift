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
    var stackView: UIStackView?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func initialize(model: PersonalDetails, index: Int) {
        let stackView = UIStackView()
        let userLabel = UILabel()
        userLabel.textAlignment = .left
        userLabel.textColor = UIColor.black
        userLabel.text = populate(model: model, index: index).0
        let userTextField = UILabel()
        userTextField.text = populate(model: model, index: index).1
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

    func populate(model: PersonalDetails, index: Int) -> (String, String) {
        let details = Details.allCases[index]
        switch details {
        case .fullName:
            return (details.rawValue, model.fullName.title)
        case .age:
            return (details.rawValue, model.age.title)
        case .height:
            return (details.rawValue, model.height.title)
        case .gender:
            return (details.rawValue, model.gender.title)
        case .ethnicity:
            return (details.rawValue, model.ethnicity.title)
        case .location:
            return (details.rawValue, model.location.title)
        case .company:
            return (details.rawValue, model.company.title)
        case .jobTitle:
            return (details.rawValue, model.jobTitle.title)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.removeFromSuperview()
        stackView = nil
    }
}
