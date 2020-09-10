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


// TODO: look into UICollectionView to manage multiple

class SignupViewController: UIViewController {
     
    // MARK: - Properties
    let colors = GradientBackground()
    let logo: UILabel = {
        let curr = UILabel()
        curr.text = "Welcome!"
        curr.font = UIFont(name: "Barcelony", size: 50)
        curr.textColor = .white
        return curr
    }()
    
    var currentUser: User?
    
    // let nameBox = RoundedRectangleTextField(placeholder: "Your Name")
    let nameField = UnderlinedTextField(placeholder: "Your Name")
    var viewModel: SignupViewModel?
    let label: UILabel = {
        let curr = UILabel()
        curr.text = "What is your display name?"
        curr.font = UIFont.systemFont(ofSize: 20)
        curr.textAlignment = .right
        curr.textColor = .white
        return curr
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignupViewModel(currentUser)
        
        if let prefilledName = self.viewModel?.user!.name {
            nameField.text = prefilledName
        }
        self.makeUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // we use this function to indentify the frame width and height here, these values are only available after viewDidLayoutSubviews starts to run.
        nameField.underlined(frameWidth: CGFloat(nameField.frame.width),
                             frameHeight: CGFloat(nameField.frame.height))
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
        view.addSubview(logo)
        view.addSubview(nameField)
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        nameField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
        logo.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
    }
}
