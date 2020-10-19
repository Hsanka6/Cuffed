//
//  ProfileViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.parent?.title = "BOBBOI"
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(action))
        self.parent?.navigationItem.rightBarButtonItem = editButton
    }
    @objc func action(sender: UIBarButtonItem) {
        let newViewController = ProfileEditViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
