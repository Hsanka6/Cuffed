//
//  SignUpViewController.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/30/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}


// TODO: look into UICollectionView

class SignupViewController: UIViewController {
     
    // MARK: - Properties
    let colors = GradientBackground()
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Let's sign you up!"
        curr.font = UIFont(name: "Barcelony", size: 50)
        curr.textColor = .white
        curr.backgroundColor = .yellow
        return curr
    }()
    
    var currentUser: User?
    
    var mainStackview: UIStackView = {
        let mainStackview = UIStackView()
        mainStackview.axis          = .vertical
        mainStackview.alignment     = .center
        mainStackview.distribution  = .equalSpacing
        mainStackview.translatesAutoresizingMaskIntoConstraints = false

        return mainStackview
    }()
    
    var nameBox: UITextField = {
        let nameBox = UITextField()
        nameBox.text = "Test Text"
        nameBox.backgroundColor = .blue
        nameBox.font = UIFont(name: "Barcelony", size: 25)
        nameBox.textColor = .black
        return nameBox
    }()
    
    var viewModel: SignupViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignupViewModel(currentUser)
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
    
    // MARK: - Selectors
    func constructBackground() {
        let backgroundLayer = self.colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    // MARK: - Helpers
    
    func makeUI() {
        self.constructBackground()
        // add views logo & loginButton
        view.addSubview(mainStackview)
        
        // logo.text = self.viewModel?.user.userId
        mainStackview.addSubview(logo)
        mainStackview.addSubview(nameBox)
        
        logo.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerY.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        
        nameBox.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
        
        mainStackview.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        mainStackview.addBackground(color: .red)
    }
    
    // You can initialize Properties here
    // reference https://www.hackingwithswift.com/example-code/language/fixing-class-viewcontroller-has-no-initializers
//    required init?(coder aDecoder: NSCoder) {
//        self.username = "Anonymous"
//        super.init(coder: aDecoder)
//    }
    
}
