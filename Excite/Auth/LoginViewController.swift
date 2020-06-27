//
//  ViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/3/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var loginButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func makeUI() {
        self.view.addSubview(loginButton)
        loginButton.backgroundColor = .black
        loginButton.setTitle("Login", for: .normal)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
           make.center.equalTo(self.view)
        }
        loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }
    @objc func login(sender: UIButton!) {
       print("login")
       let newViewController = MainTabBarController()
       self.navigationController?.pushViewController(newViewController, animated: true)
    }

}
