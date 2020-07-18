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
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.snp.makeConstraints { (make) in
//            make.width.height.equalToSuperview()
//        }
    }
    func initialize() {
        self.backgroundColor = UIColor.blue
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.reuseIdentifier) as? UserDetailTableViewCell
        cell?.initialize()
        return cell ?? UITableViewCell()
    }
}
