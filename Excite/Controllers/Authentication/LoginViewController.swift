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
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {
     
    // MARK: - Properties
    let colors = GradientBackground()
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Cuffed"
        curr.font = UIFont(name: "Barcelony", size: 70)
        curr.textColor = .white
        return curr
    }()
    
    let loginButton = FBLoginButton()
    var viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel()
        // if we already have a FB Access token to use to log in
        self.authenticateUser()
        self.makeUI()
        
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
    
    // MARK: - Handlers
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error != nil {
            let alert = UIAlertController(title: "Login failed!", message: "Message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try again!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if result!.isCancelled {
            let alert = UIAlertController(title: "Oh?", message: "You cancelled?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yeah lemme try again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            authenticateUser()
        }
        
    }
    
    func constructBackground() {
        let backgroundLayer = self.colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    func authenticateUser() {
        if let token = AccessToken.current {
            if !token.isExpired {
                redirect()
            }
        }
    }
    
    // sign in assigns the viewModel's currentUser object
    func redirect() {
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            guard let authResult = authResult else { print(error); return }
            let firUser = authResult.user
            NetworkRequester().getUser(firUser.uid) { (user) in
                self.viewModel.currentUser = user
                if self.viewModel.completeUser() {
                    let newViewController = MainTabBarController()
                    // do something like:
                    // newViewController.currentUser = self.viewModel.currentUser
                    self.navigationController?.pushViewController(newViewController, animated: false)
                } else {
                    self.viewModel.currentUser = User(firebaseUser: firUser)
                    let newViewController = SignupViewController()
                    newViewController.currentUser = self.viewModel.currentUser
                    self.navigationController?.pushViewController(newViewController, animated: false)
                }
            }
        
            // pass the current userID in to create a new User Object and store it in Firebase
        }
    }
    
    // MARK: - Helpers
    
    func makeUI() {
        self.constructBackground()
        // add views logo & loginButton
        view.addSubview(logo)
        view.addSubview(loginButton)
        
        // set constraints for logo
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom).multipliedBy(0.1)
            make.centerX.equalTo(self.view)
        }
        
        // set constraints for the loginButton
        if let constraint = loginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        }) {
            constraint.constant = 40.0
        }
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottomMargin).multipliedBy(0.9)
            make.centerX.equalTo(self.view)
            make.width.equalTo(view.frame.width - 100   )
            make.height.equalTo(50)
        }
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email"]
        
        self.loginButton.delegate = self
    }
}
