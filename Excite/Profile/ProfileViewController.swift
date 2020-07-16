//
//  ProfileViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        self.parent?.title = "BOBBOI"
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(action))

        self.parent?.navigationItem.rightBarButtonItem = editButton
        makeUI() //single stackview
        //make() //nested stackview
    }
    @objc func action(sender: UIBarButtonItem) {
        let newViewController = ProfileEditViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func makeUI() {
        
    }
    
    
  
}
