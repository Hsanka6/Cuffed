//
//  UserPrioritiesTableTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/23/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol UserPrioritiesTableTableViewCellDelegate: class {
    func editPriorites(priorities: [String])
}

class UserPrioritiesTableTableViewCell: UITableViewCell {
    static var reuseIdentifier = "UserPrioritiesTableTableViewCell"
    var tableView = UITableView()
    var priorities: [String]?
    weak var delegate: UserPrioritiesTableTableViewCellDelegate?
      
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(priorities: [String]) {
        self.priorities = priorities
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.top.equalTo(5)
        }
        self.tableView.isEditing = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
          super.prepareForReuse()
          tableView.removeFromSuperview()
          tableView.reloadData()
      }

}

extension UserPrioritiesTableTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priorities?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let priority = self.priorities?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = "\(indexPath.row + 1). \(priority)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard var priorities = priorities, let priority = self.priorities?[sourceIndexPath.row] else { return }
        priorities.remove(at: sourceIndexPath.row)
        priorities.insert(priority, at: destinationIndexPath.row)
        tableView.reloadData()
        delegate?.editPriorites(priorities: priorities)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
       return false
    }
}
