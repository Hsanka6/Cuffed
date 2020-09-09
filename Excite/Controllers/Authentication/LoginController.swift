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

class LoginController: UIViewController, LoginButtonDelegate {
     
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
        
        // ??
        self.viewModel.currentUser = User(AccessToken.current!.userID)
        Auth.auth().signIn(with: credential) { (_, error) in
            NetworkRequester().getUser(AccessToken.current!.userID) { (user) in
                self.viewModel.currentUser = user
                if self.viewModel.completeUser() {
                    let newViewController = MainTabBarController()
                    self.navigationController?.pushViewController(newViewController, animated: false)
                } else {
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
    
    /*
     Auth.auth().signIn(with: credential) { (authResult, error) in
       if let error = error {
         let authError = error as NSError
         //if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
         if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
           // The user is a multi-factor user. Second factor challenge is required.
           let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
           var displayNameString = ""
           for tmpFactorInfo in (resolver.hints) {
             displayNameString += tmpFactorInfo.displayName ?? ""
             displayNameString += " "
           }
             self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK,
             displayName in
             var selectedHint: PhoneMultiFactorInfo?
             for tmpFactorInfo in resolver.hints {
               if (displayName == tmpFactorInfo.displayName) {
                 selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
               }
             }
             PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
               if error != nil {
                 print("Multi factor start sign in failed. Error: \(error.debugDescription)")
               } else {
                 self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
                   let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                   let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                   resolver.resolveSignIn(with: assertion!) { authResult, error in
                     if error != nil {
                       print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                     } else {
                       self.navigationController?.popViewController(animated: true)
                     }
                   }
                 })
               }
             }
           })
         } else {
           // self.showMessagePrompt(error.localizedDescription)
           return
         }
         // ...
         return
       }
       // User is signed in
       // ...
     }
     */
    
}


//                        guard let authResult = authResult else { return }
//                        let firUser = authResult.user
//                        // edit this
//                        let newUser = User(uid: firUser.uid, username: username, fullName: fullName, bio: "", website: "", follows: [], followedBy: [], profileImage: self.profileImage)
//                        newUser.save(completion: { (error) in
//                          if let error = error {
//                            // report
//                          } else {
//                            // not sure what you need to do here anymore since the user is already signed in
//                          }
//                        })


//            GraphRequest(graphPath:"me", parameters: ["fields" : "email,name,picture"]).start(completionHandler: { (connection, result, error) in
//                if error == nil {
//                    print("INSIDE OF AUTH SIGNIN")
//                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//                    Auth.auth().signIn(with: credential) { (_, error) in
//                        NetworkRequester().getUser(AccessToken.current!.userID) { (user) in
//                            self.viewModel.currentUser = user
//                        }
//                        // if we don't have an associated user
//                        if self.viewModel.currentUser == nil {
//                            self.viewModel.currentUser = User(AccessToken.current!.userID)
//                        } else {
//                            print("JAN DEBUG")
//                            print(self.viewModel.currentUser)
//                        }
//                    }
//                } else {
//                    print("Error logging in: \(error)");
//                }
//            })
