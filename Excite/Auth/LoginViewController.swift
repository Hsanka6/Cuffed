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
class LoginViewController: UIViewController, LoginButtonDelegate {
    
    let backgroundLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors=[UIColor(hexString: "6CA0FF").cgColor, UIColor(hexString: "FF6299").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if (error) != nil {
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
            // if it's successful and they do not have an account registered in our DB then register them
            // otherwise, we route them to where they started before
            GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture"]).start(completionHandler: { (connection, result, error) in
                if error == nil {
                    // 3776489612377405
                    
                    guard let info = result as? [String : AnyObject] else {
                        return
                    }
                    let id      = info["id"] as? String ?? ""
                    let email   = info["email"] as? String ?? ""
                    var network = NetworkRequesterMock()
                    network.getUser(id: id)
                    
                    // From here, get their information and pull Firestore DB to see if they have a profile configured
                    // If they do, then get them to their matches screen directly
                    // Otherwise, they're going to need to fill up the sign up part.
                    
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if error != nil {
                            print("JAN DEBUG: Something went wrong...")
                            return
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
                        print("JAN DEBUG: Successfully logged in with our user.")
                        print(authResult)
                    }
                } else {
                    print("Error Getting Info \(error)");
                }
            })
            let newViewController = MainTabBarController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Cuffed"
        // curr.font = UIFont(name: label.font.fontName, size: 20)
        curr.font = UIFont(name: "Barcelony", size: 70)
        curr.textColor = .white
        return curr
    }()
    let facebookLoginButton = FBLoginButton()
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
    func constructBackground() {
        self.backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    func makeUI() {
        view.addSubview(logo)
        view.addSubview(facebookLoginButton)
        
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom).multipliedBy(0.1)
            make.centerX.equalTo(self.view)
        }
        
        if let constraint = facebookLoginButton.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height
        }) {
            constraint.constant = 40.0
        }
        facebookLoginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottomMargin).multipliedBy(0.9)
            make.centerX.equalTo(self.view)
            make.width.equalTo(view.frame.width - 100   )
            make.height.equalTo(50)
        }
        facebookLoginButton.center = view.center
        facebookLoginButton.permissions = ["public_profile", "email"]
        self.facebookLoginButton.delegate = self
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
