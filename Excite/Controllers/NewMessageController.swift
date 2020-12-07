//
//  NewMessageController.swift
//  CuffedChat
//
//  Created by Max He on 8/18/20.
//  Copyright © 2020 Max He. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}
class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    private var users = [User]()
    weak var delegate: NewMessageControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    // MARK: - Selector
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureNavigationBar(withTitle: "Dates", prefersLargeTitles: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

// MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG: User count is \(users.count)")
        return users.count
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserCell  // change here
        cell.user = users[indexPath.row]
        return cell
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
    }
}


