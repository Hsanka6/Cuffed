//
//  UserTableTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/18/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class UserTableTableViewCell: UITableViewCell {
    static var reuseIdentifier = "UserTableTableViewCell"
    var tableView = UITableView()
    var personal: PersonalDetails?
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func initialize(personalDetails: PersonalDetails) {
        self.personal = personalDetails
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.top.equalTo(5)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.reuseIdentifier)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserTableTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.reuseIdentifier) as? UserDetailTableViewCell
        cell?.selectionStyle = .none
        if let personal = personal {
            cell?.initialize(model: personal, index: indexPath.row)
        }
        return cell ?? UITableViewCell()
    }
}
