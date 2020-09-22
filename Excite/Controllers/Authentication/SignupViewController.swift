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

extension UIView {
    var safeArea : ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
}

extension UICollectionView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

// Browse Collections View Controller
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
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // let nameBox = RoundedRectangleTextField(placeholder: "Your Name")
//    let nameField = UnderlinedTextField(placeholder: "Your Name")
    var viewModel: SignupViewModel?
    
    let label: UILabel = {
        let curr = UILabel()
        curr.text = "What is your display name?"
        curr.font = UIFont.systemFont(ofSize: 20)
        curr.textAlignment = .right
        curr.textColor = .black
        return curr
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignupViewModel(currentUser)
//        if let prefilledName = self.viewModel?.user!.name {
//            nameField.text = prefilledName
//        }
        self.constructBackground()
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(30)
        }
        self.createCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // we use this function to indentify the frame width and height here, these values are only available after viewDidLayoutSubviews starts to run.
//        nameField.underlined(frameWidth: CGFloat(nameField.frame.width),
//                             frameHeight: CGFloat(nameField.frame.height))
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
    
    func createCollectionView() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(view.safeArea.top)
            make.bottom.equalTo(view.safeArea.bottom)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.clipsToBounds = false
//        collectionView.center
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(SignupCollectionViewCell.self, forCellWithReuseIdentifier: SignupCollectionViewCell.reuseIdentifier)
    }
}
extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("IS THIS EVER CALLED")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCollectionViewCell.reuseIdentifier, for: indexPath) as? SignupCollectionViewCell {
         cell.initialize()
//         cell.configure(photo: photos[indexPath.row])
         return cell
         }
         return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4, height: height * 0.4)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = CellWidth * CellCount
//        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
}
