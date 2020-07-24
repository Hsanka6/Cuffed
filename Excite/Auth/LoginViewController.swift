//
//  ViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/3/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit


/*
 Check if logged in
 
 https://developers.facebook.com/apps/310379816777022/fb-login/quickstart/?sdk=cocoapods
 Your app can only have one person logged in at a time. We represent each person logged into your app with the [FBSDKAccessToken currentAccessToken].
 The FBSDKLoginManager sets this token for you and when it sets currentAccessToken it also automatically writes it to a keychain cache.
 The FBSDKAccessToken contains userID which you can use to identify the user.
 You should update your view controller to check for an existing token at load. This avoids unnecessary showing the login flow again if someone already granted permissions to your app:
 if let token = AccessToken.current,
     !token.isExpired {
     // User is logged in, do work such as go to next view controller.
 }
 
 */
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

class LoginViewController: UIViewController, LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((error) != nil) {
            let alert = UIAlertController(title: "Login failed!", message: "Message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try again!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if result!.isCancelled {
            let alert = UIAlertController(title: "Oh?", message: "You cancelled?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yeah lemme try again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let newViewController = MainTabBarController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    

    let colors = Colors()
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Tumble"
        // curr.font = UIFont(name: label.font.fontName, size: 20)
        curr.font = UIFont(name: "Barcelony", size: 70)
        curr.textColor = .white
        return curr
    }()
    let loginButton = FBLoginButton()
    func constructBackground() {
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // check to see whether or not user is logged in
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let newViewController = MainTabBarController()
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
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
        
        view.addSubview(logo)
        view.addSubview(loginButton)
        
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_bottom).multipliedBy(0.1)
            make.centerX.equalTo(self.view)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottomMargin).multipliedBy(0.9)
            make.centerX.equalTo(self.view)
        }
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email"]
        self.loginButton.delegate = self
        // loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }
    
    
    // work on taking out showing the page
    // upon login - if it's the first time logging in
    // disclosure agreement
    //      if they don't accept then do the UIAlertController
    // configure a profile page
    
    // filters page
    
    /*
     --- Code for a UIStackView, don't mind this ---
     mainStackview.axis          = .vertical
     mainStackview.alignment     = .center
     mainStackview.distribution  = .equalSpacing
     
     
     usernameView.backgroundColor = .red
     passwordView.backgroundColor = .blue
     
     usernameView.snp.makeConstraints { (make) in
         make.width.equalTo(100)
         make.height.equalTo(50)
     }
     passwordView.snp.makeConstraints { (make) in
         make.width.equalTo(100)
         make.height.equalTo(50)
     }
     
      mainStackview.addArrangedSubview(usernameView)
      mainStackview.addArrangedSubview(passwordView)

     mainStackview.snp.makeConstraints { (make) in
         make.center.equalToSuperview()
         make.width.equalTo(100)
         
     }
     */
}
