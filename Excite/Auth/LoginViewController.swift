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

    let colors = Colors()
    let mainStackview: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.4)
        view.layer.cornerRadius = 20
        return view
    }()
    let logo: UILabel = {
        let view = UILabel()
        view.text = "Pinned"
        view.textColor = .black
        return view
    }()
    let logo2: UILabel = {
        let view = UILabel()
        view.text = "Pinned2"
        view.textColor = .black
        return view
    }()
    let usernameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        return view
    }()
    let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 10
        return view
    }()
    let loginButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 10
        return view
    }()
    var loginStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
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
        view.addSubview(mainStackview)
        mainStackview.axis = .vertical
        mainStackview.alignment = .center
        mainStackview.distribution = .equalSpacing
        mainStackview.spacing = 0.2
        mainStackview.addArrangedSubview(logo)
        mainStackview.addArrangedSubview(logo2)
        logo.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        logo2.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
//         mainStackview.addSubview(loginStack)
//         loginStack.addSubview(usernameView)
//         loginStack.addSubview(passwordView)
//        usernameView.snp.makeConstraints { (make) in
//            make.height.equalTo(50)
//        }
//        passwordView.snp.makeConstraints { (make) in
//            make.height.equalTo(50)
//        }
        mainStackview.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.equalTo(100)
            make.width.equalTo(300)
            make.bottom.equalTo(-20)
            
        }
//        loginStack.snp.makeConstraints { (make) in
//            make.width.height.equalTo(300)
//            make.center.equalTo(self.mainStackview)
//        }
    }
//    @objc func login(sender: UIButton!) {
//       let newViewController = MainTabBarController()
//       self.navigationController?.pushViewController(newViewController, animated: true)
//    }

}
