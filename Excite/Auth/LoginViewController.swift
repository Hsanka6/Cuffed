//
//  ViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/3/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit

class Colors {
    var gl : CAGradientLayer

    init() {
        let colorTop = UIColor(hexString: "6CA0FF").cgColor
        let colorBottom = UIColor(hexString: "FF6299").cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

class LoginViewController: UIViewController {

    var loginButton = UIButton()
    var logo = UITextView()
    var stackView = UIStackView()
    let colors = Colors()
    
    func constructBackground() {
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        constructBackground()
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
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)

        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        logo.textColor = .white
//        logo.backgroundColor = .black
        logo.text = "ExciteDate"
        logo.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        stackView.addSubview(logo)
//
//        loginButton.backgroundColor = .black
//        // test first commit
//        loginButton.setTitle("Login Screen", for: .normal)
//        loginButton.snp.makeConstraints { (make) -> Void in
//            make.height.equalTo(40)
//            make.width.equalTo(100)
//           make.center.equalTo(self.view)
//        }
//
//        stackView.addSubview(logo)
//        stackView.addSubview(loginButton)
//
//
        
//        loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }


    @objc func login(sender: UIButton!) {
       let newViewController = MainTabBarController()
       self.navigationController?.pushViewController(newViewController, animated: true)
    }

}
