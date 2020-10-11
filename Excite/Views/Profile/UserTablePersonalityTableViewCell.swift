//
//  UserTablePersonalityTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/20/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol UserTablePersonalityTableViewCellDelegate: class {
    func editPersonality(personalities: [Personality])
}

class UserTablePersonalityTableViewCell: UITableViewCell {
    static var reuseIdentifier = "UserTablePersonalityTableViewCell"
    var tableView = UITableView()
    var personal: [Personality]?
    weak var delegate: UserTablePersonalityTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(personality: [Personality]) {
        self.personal = personality
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.top.equalTo(5)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UserPersonalityTableViewCell.self, forCellReuseIdentifier: UserPersonalityTableViewCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension UserTablePersonalityTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personal?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserPersonalityTableViewCell.reuseIdentifier) as? UserPersonalityTableViewCell
        cell?.selectionStyle = .none
        cell?.personalities = personal
        if let personal = personal {
            cell?.initialize(model: personal[indexPath.row], index: indexPath.row)
            cell?.delegate = self
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension UserTablePersonalityTableViewCell: UserPersonalityTableViewCellDelegate {
    func editPersonality(personalities: [Personality]) {
        delegate?.editPersonality(personalities: personalities)
    }
}
